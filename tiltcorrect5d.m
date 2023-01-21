%[out] = tiltcorrect5d(in,-2,840);
function [out] = tiltcorrect5d(ws_recon,ntilt,dt2)

bw1       = 1000;
bw2       = 1/(dt2*1e-6); %1190
tiltangle = ntilt*2;

[ny,nx,nz,nt2,nt1] = size(ws_recon);
T1     = (0:1:nt1-1)/bw1;
F2     = (bw2/nt2)*(-nt2/2:1:nt2/2 - 1).';
phase  = permute(repmat(exp(1i*tiltangle*pi*F2*T1),[1 1 ny nx nz]),[3 4 5 1 2]);
out = iffts(fftsn(fftsn(fftsn(ws_recon,1),2),3),5);
out = ffts(ifftsn(ifftsn(ifftsn(out.*phase,1),2),3),5);

% out2 = iffts((((ws_recon))),5);
% out2 = ffts((((out2.*phase))),5);

% tmp1 = iffts(iffts(fftsn(fftsn(fftsn(ws_recon,1),2),3),4),5);
% tmp2 = iffts(iffts(fftsn(fftsn(fftsn(out,1),2),3),4),5);
% out2 = abs(tmp1).*exp(1i*angle(tmp2));
% out2 = ffts(ffts(ifftsn(ifftsn(ifftsn(out2,1),2),3),4),5);

% out2 = ffts(padarray(iffts(out,5),[0 0 0 0 nt1],'post'),5);