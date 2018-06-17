
% Clean
clc; clear all; close all;
dname = uigetdir('.');
filenames = dir(fullfile(dname, '*.dcm'));  % read all images with specified extention, its jpg in our case
 total_images = numel(filenames);    % count total number of photos present in that folder

 for n = 2:total_images
  full_name= fullfile(image_folder, filenames(n).name);         % it will specify images names with full path and extension
our_images = imread(f);                 % Read images  
   figure (n)                           % used tat index n so old figures are not over written by new new figures
    imshow(our_images)                  % Show all images
[file,path]=uigetfile('*.dcm','Moving Image');
% Read two images
I1=im2double(dicomread([path,file]));  
[file,path]=uigetfile('*.dcm','Reference Image');
I2=im2double(dicomread([path,file]));


MIND_Main
LP_Main
PC_Main
ALOST

 end

names=['    Initial  ' ' MIND_I  ' '  MIND_LP  ' ' MIND_PC ' '  ALOST'];
disp(names);
TCC=[corr2(I1,I2) ICC LCC PCC ACC];
disp(TCC);
trmse=[rmse(I1,I2) irmse lrmse prmse armse];
disp(trmse);
tmtre=[TRE(I1,I2) imtre lmtre pmtre amtre];
disp(tmtre);
tdc=[DC(I1,I2) idc ldc pdc adc];
disp(tdc);