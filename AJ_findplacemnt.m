function [out] = AJ_findplacemnt(in)
% code to find the sign corresponding to early or late placement
% input: in - input specturm in f2-f1 or x-y-f2-f1 or x-y-z-f2-f1
%
% AJ - 08/03/22
%----------------------------------------------------------------

if ~ismatrix(in)
    if ndims(in)==4
        temp    = squeeze(sum(sum(in,3),4));
        [~,idx] = max(temp(:));
        [ii,jj] = ind2sub([16 16 8],idx);
        spec    = squeeze(in(ii,jj,:,:));
    elseif ndims(in)==5
        temp = squeeze(sum(sum(in,4),5));
        [~,idx]=max(temp(:));
        [ii,jj,kk]=ind2sub([16 16 8],idx);
        spec    = squeeze(in(ii,jj,kk,:,:));
    end
else
    spec = in; 
end

% frequency domain to time domain
temp = iffts(iffts(spec,1),2);
% unwraped phase
temp = unwrap(angle(temp(:,1)));
% find the sign for placement from phase
out  = sign(temp(1)-temp(end));