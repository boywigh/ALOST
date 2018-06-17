function I3=movepixels(I1,Tx,Ty,Tz,mode)
% This function movepixels, will (backwards) translate the pixels 
% of an 2D/3D image according to x, y (and z) translation images 
% (bilinear interpolated).

if(~exist('mode','var')), mode=0; end

if(size(I1,3)<4)
    I3=movepixels_2d_double(double(I1),double(Tx),double(Ty),double(mode));
else
    if(isa(I1,'double'))
        I3=movepixels_3d_double(double(I1),double(Tx),double(Ty),double(Tz),double(mode));
    else
        I3=movepixels_3d_single(single(I1),single(Tx),single(Ty),single(Tz),single(mode));
    end
end
if(~isa(I1,'double')&&~isa(I1,'single'))
    if(isa(I1,'uint8')), I3=uint8(I3); end
    if(isa(I1,'uint16')), I3=uint16(I3); end
    if(isa(I1,'uint32')), I3=uint32(I3); end
    if(isa(I1,'int8')),   I3=int8(I3); end
    if(isa(I1,'int16')), I3=int16(I3); end
    if(isa(I1,'int32')), I3=int32(I3); end
end


