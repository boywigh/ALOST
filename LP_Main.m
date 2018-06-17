%Local Phase
% This is an example script for using the monogenic signal code for 2D
% images

% Add monogenic_signal source directory to path
addpath('src')

% Load a matlab test image
% If running under octave, you will need to change this to an image file of
% your choice.
% Note that the monogenic signal is intended to on greyscale images (using it on
% a colour image will result in the three channels being processed independently).
[Y,X] = size(I2);

% First we have to choose a set of centre-wavelengths for our filters,
% typically you will want to play around with this a lot.
% Centre-wavelengths are expressed in pixel units. Here we use a set of
% wavelenths with a constant scaling factor of 1.5 between them, starting
% at 20 pixels
cw = 20*1.5.^(0:4);

% Now use these wavelengths to create a structure containing
% frequency-domain filters to calculate the mnonogenic signal. We can
% re-use this structure many times if we need for many images of the same
% size and using the same wavelength. We can choose from a number of
% different filter types, with log-Gabor ('lg') being the default. For lg
% filters we can also choose the shape parameter (between 0 and 1), which
% governs the bandwidth (0.41 gives a three-octave filter, 0.55 gives a two
% octave filter)
filtStruct = createMonogenicFilters(Y,X,cw,'lg',0.55);

% Now we can use this structure to find the monogenic signal for the image
[m1,m2,m3] = monogenicSignal(I1,filtStruct);

% The returned values are the three parts of the monogenic signal: m1 is
% the even part, and m2 and m3 are the odd parts in the vertical and
% horizontal directions respectively. Each array is Y x X x 1 x W, where
% X and Y are the image dimensions and W is the number of wavelengths.
% The filter responses to the filters of each scale are stacked along the
% fourth dimension.

% (Alternatively one may pass a 3D volume to monogenicSignal, in which case
% the 2D monogenic signal is found for each of the Z 2D planes independently and
% returned as a set of Y x X x Z x W arrays)

% From here we can straightforwardly find many of the derived measures by
% passing these three arrays

% Local phase (calculated on a per-scale basis)
LP = localPhase(m1,m2,m3);

mind=MIND_descriptor2D(I1);

% Set static and moving image
S=I2; M=LP(:,:,1,1);

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

MINDL=M;

%Testing for correlation Coefficient
LCC=corr2(I1,M);
lrmse=RMSE(I1,M);
lmtre=TRE(I1,M);
ldc=DC(I1,M);
