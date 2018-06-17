
%Phase Congurency
% This is an example script for using the monogenic signal code for 2D
% images

% Add monogenic_signal source directory to path
addpath('src')

% Load a matlab test image
% If running under octave, you will need to change this to an image file of
% your choice.
% Note that the monogenic signal is intended to on greyscale images (using it on
% a colour image will result in the three channels being processed independently).
[Y,X] = size(I1);

% This time we have to use exactly two scales, as this is required by
% Felsberg's phase congruency method. As he suggests, let's use
% three-ocatave filters and leave a three-octave spacing between them.
% We want small filters to pick out the fine detail in this image.
cw = [3,24];

% Construct new filters, as before
filtStruct = createMonogenicFilters(Y,X,cw,'lg',0.41);

% Find monogenic signal, as before
[m1,m2,m3] = monogenicSignal(I1,filtStruct);

% Now use the phase congruency algorithm. The fourth parameter is a
% threshold between 0 and 1 used for noise supression. You will always need
% to use this to get reasonable results. Somewhere between 0 and 0.1 should
% do in most cases.
PC = phaseCongruency(m1,m2,m3,0.05);

mind=MIND_descriptor2D(I1);

% Set static and moving image
S=I2; M=PC;

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
        Ux = -Idiff.*  ((Sx./((Sx.^2+Sy.^2)+alpha.^2*Idiff.^2))+(Mx./((Mx.^2+My.^2)+alpha.^2*Idiff.^2)));
        Uy = -Idiff.*  ((Sy./((Sx.^2+Sy.^2)+alpha.^2*Idiff.^2))+(My./((Mx.^2+My.^2)+alpha.^2*Idiff.^2)));
 
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

MINDP=M;

%Testing for correlation Coefficient
PCC=corr2(I1,M);
prmse=RMSE(I1,M);
pmtre=TRE(I1,M);
pdc=DC(I1,M);
