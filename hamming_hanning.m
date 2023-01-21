
% hamming
% define filter for three spatial dimensions
filt = hamming(app.ny).*hamming(app.nx).'.*permute(hamming(app.nz),[2,3,1]);
%tranform to fourier domain, apply filter and then transform back to image domain
app.cdata = ifftsn(ifftsn(ifftsn( fftsn(fftsn(fftsn(app.cdata,1),2),3).*filt ,1),2),3); 
%unapply, transform to fourier domain, unapply filter by division? and then transform back to image domain 
% app.cdata =  ifftsn(ifftsn(ifftsn(
% fftsn(fftsn(fftsn(app.cdata,1),2),3).*(1/filt) ,1),2),3); ?


% hanning
filt = hanning(app.ny).*hanning(app.nx).'.*permute(hanning(app.nz),[2,3,1]);
app.cdata = ifftsn(ifftsn(ifftsn( fftsn(fftsn(fftsn(app.cdata,1),2),3).*filt ,1),2),3);


% fftsn and ifftsn definisions
function out = fftsn(x,dim)
out = (1/sqrt(size(x,dim)))*fftshift(fft(fftshift(x,dim),[],dim),dim);
end
function out = ifftsn(x,dim)
    out = sqrt(size(x,dim))*ifftshift(ifft(ifftshift(x,dim),[],dim),dim);
end