
mind=MIND_descriptor2D(I1);
% Set static and moving image
S=I2; M=I1;

% Alpha (noise) constant
alpha=2.5;

% Velocity field smoothing kernel
Hsmooth=fspecial('gaussian',[60 60],10);

% The transformation fields
Tx=zeros(size(M)); Ty=zeros(size(M));

[Sy,Sx] = gradient(S);
for itt=1:100
	    % Difference image between moving and static image
        Idiff=mind(:,:,1);

        [My,Mx] = gradient(M);
        Ux = -Idiff.*  ((Sx./((Sx.^2+Sy.^2)+alpha^2*Idiff.^2))+(Mx./((Mx.^2+My.^2)+alpha^2*Idiff.^2)));
        Uy = -Idiff.*  ((Sy./((Sx.^2+Sy.^2)+alpha^2*Idiff.^2))+(My./((Mx.^2+My.^2)+alpha^2*Idiff.^2)));
 
        % When divided by zero
        Ux(isnan(Ux))=0; Uy(isnan(Uy))=0;

        % Smooth the transformation field
        Uxs=3*imfilter(Ux,Hsmooth);
        Uys=3*imfilter(Uy,Hsmooth);

        % Add the new transformation field to the total transformation field.
        Tx=Tx+Uxs;
        Ty=Ty+Uys;
        M=movepixels(I1,Tx,Ty); 
end

MINDI=M;

%Testing for correlation Coefficient
ICC=corr2(I1,M);
irmse=RMSE(I1,M);
imtre=TRE(I1,M);
idc=DC(I1,M);
