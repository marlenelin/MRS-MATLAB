function admap = adjustmap(in,T,bw2,bw1,zp2,zp1,f2ref,f1ref,mode)  
    [ny, nx, nz, nt2, nt1] = size(in);
    ax1   = bw1/2/nt1*(-nt1/2:1:nt1/2-1) + zp1;
    if strcmpi(mode,'IP') || strcmpi(mode,'CT')
        ax1 = bw2/2/nt1*(-nt1/2:1:nt1/2-1) + zp1; 
    end
    ax2   = (-1/2:1/nt2:1/2-1/nt2)*bw2/T + zp2;
    admap = cell(nx,ny,nz);
    for sl = 5
        for y = 5:13
            for x = 5:13
                %1:nz, 1:ny, 1:nx respectively for full ranges
                [xadjust,yadjust] = adjustpt(in,ax1,ax2,x,y,sl);
                %x doesn't matter a lot
                reconyp = adjustdata(in,xadjust,yadjust,ax1,ax2,f2ref,f1ref);
                reconym = adjustdata(in,xadjust,-yadjust,ax1,ax2,f2ref,f1ref);
                [x1,yp] = adjustpt(reconyp,ax1,ax2,x,y,sl);
                [x2,ym] = adjustpt(reconym,ax1,ax2,x,y,sl);
                dist1 = sqrt((x1-f2ref)^2+(yp-f1ref)^2);
                dist2 = sqrt((x2-f2ref)^2+(ym-f1ref)^2);
                if dist1 < dist2
                    admap(x,y,sl) = {[xadjust,yadjust]};
                else
                    admap(x,y,sl) = {[xadjust,-yadjust]};
                end
                %shift = admap{x,y,sl};
                %disp(strca
                % t('x:',num2str(x),' y:',num2str(y),' z:',num2str(sl),' F2-shift:',num2str(shift(1)),' F1-shift:',num2str(shift(2))));
            end
        end
    end
    save('admap.mat','admap');


     
    %get shift adjusted recon data
    function recon = adjustdata(in,xadjust,yadjust,ax1,ax2,f2ref,f1ref)
             
            if ndims(in)==4, in = permute(in,[1,2,5,3,4]); end
            if ismatrix(in), if size(in,1)<size(in,2), in = permute(in,[2,1]); end; in = permute(in,[3,4,5,1,2]); end
            %f1 y
            id1_1 = find(abs(ax1-f1ref)==min(abs(ax1-f1ref)));
            ax1   = ax1 - (yadjust-f1ref);
            id1_2 = find(abs(ax1-f1ref)==min(abs(ax1-f1ref)));
            
            %f2 x
            id2_1 = find(abs(ax2-f2ref)==min(abs(ax2-f2ref)));
            ax2   = ax2 - (xadjust-f2ref);
            id2_2 = find(abs(ax2-f2ref)==min(abs(ax2-f2ref)));
    
            %shift
            out = circshift(in,[0,0,0,id2_1-id2_2,id1_2-id1_1]);
            recon = squeeze(out);
    end

    %get coords of the adjust point
    function [xadjust,yadjust] = adjustpt(recon,ax1,ax2,xpos,ypos,sl)
                 r21 = find(ax2 >= 1.5,1,'first'); 
                 r22 = find(ax2 <= 2.5,1,'last');
                 r11 = find(ax1 >= -30,1,'first');
                 r12 = find(ax1 <= 30,1,'last');
                 spec1 = abs(squeeze(recon(ypos,xpos,sl,r21:r22,r11:r12)));  
                 cm = contourc(ax2(r21:r22), ax1(r11:r12), spec1.');

                 %convert contour matrix to xcoord, ycoord cx, cy grouped by
                %contour levels cz (cell arrays)
                [cx,cy,cz] = C2xyz(cm);
                %max level in selected region
                maxlvl = max(cz);
                %points corresponding to the contour line 
                for n = find(cz==maxlvl)
                    xl = cx{n};
                    yl = cy{n};
                end
                xadjust = mean(xl);
                yadjust = mean(yl);
                %                 %get data point closeset to max
%                 xi=0;
%                 yi=0;
%                 mind=10000;
%                 for idx=1:length(xl)
%                     dis = sqrt((xl(idx)-2.01)^2+(yl(idx)-0)^2);
%                     if(dis<mind)
%                         xi=xl(idx);
%                         yi=yl(idx);
%                         mind=dis;
%                     end
%                 end
%                 %verify
%                  xadjust = xi;
%                  yadjust = yi;
    end
end