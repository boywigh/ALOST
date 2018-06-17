
% Clean
clc; clear all; close all;
dname = uigetdir('.');
filenames = dir(fullfile(dname, '*.dcm'));  % read all images with specified extention, its jpg in our case
 total_images = numel(filenames);    % count total number of photos present in that folder
full_name= fullfile(dname, filenames(1).name);         % it will specify images names with full path and extension
I2=im2double(dicomread(full_name));

tICC=[];
tnICC=[];
tLCC=[];
tPCC=[];
tACC=[];
tnrmse=[];
tirmse=[];
tlrmse=[];
tprmse=[];
tarmse=[];
tntre=[];
timtre=[];
tlmtre=[];
tpmtre=[];
tamtre=[];
tndc=[];
tidc=[];
tldc=[];
tpdc=[];
tadc=[];

for n = 2:total_images
  full_name= fullfile(dname, filenames(n).name);         % it will specify images names with full path and extension
  I1 = im2double(dicomread(full_name));  

msg=strcat('Iteration for image : ', num2str(n-1));
disp(msg);

MIND_Main
LP_Main
PC_Main
ALOST

%performances

tICC=[tICC; ICC];
tnICC=[tnICC; corr2(I1,I2)];
tLCC=[tLCC; LCC];
tPCC=[tPCC; PCC];
tACC=[tACC; ACC];

tnrmse=[tnrmse; RMSE(I1,I2)];
tirmse=[tirmse; irmse];
tlrmse=[tlrmse; lrmse];
tprmse=[tprmse; prmse];
tarmse=[tarmse; armse];

tntre=[tntre; TRE(I1,I2)];
timtre=[timtre; imtre];
tlmtre=[tlmtre; lmtre];
tpmtre=[tpmtre; pmtre];
tamtre=[tamtre; amtre];

tndc=[tndc; DC(I1,I2)];
tidc=[tidc; idc];
tldc=[tldc; ldc];
tpdc=[tpdc; pdc];
tadc=[tadc; adc];

end
