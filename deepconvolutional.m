clear all;
close all;
addpath('C:\Users\PROCOMP7\Desktop\Superresolution\Matlab\superresolution_matlab');
[FileName,PathName] = uigetfile('*.tif','Select GeoTIFF file');
LR1= imread(strcat(PathName,FileName));
[FileName,PathName] = uigetfile('*.tif','Select GeoTIFF file');
LR2 = imread(strcat(PathName,FileName));
[FileName,PathName] = uigetfile('*.tif','Select GeoTIFF file');
LR3 = imread(strcat(PathName,FileName));

b=zeros(5,5,3);
filter=[0,0,1,0,0;0,1,2,1,0;1,2,-16,2,1;0,1,2,1,0;0,0,1,0,0];
b(:,:,1)=filter;
b(:,:,2)=filter;
b(:,:,3)=filter;
LR1up=imresize(LR1,2,'bicubic');
LR1conv=convn(LR1up,b);

figure;imshow(uint16(30*LR1conv(:,:,1)));
figure;imshow(uint16(30*LR1(:,:,1)));
