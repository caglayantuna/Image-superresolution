clear all;
close all;
addpath('C:\Users\PROCOMP7\Desktop\Superresolution\Matlab\superresolution_matlab');
[FileName,PathName] = uigetfile('*.tif','Select GeoTIFF file');
LR1= imread(strcat(PathName,FileName));
[FileName,PathName] = uigetfile('*.tif','Select GeoTIFF file');
LR2 = imread(strcat(PathName,FileName));
[FileName,PathName] = uigetfile('*.tif','Select GeoTIFF file');
LR3 = imread(strcat(PathName,FileName));
LR1=LR1(1:216,1:348,:);
LR2=LR2(1:216,1:348,:);
LR3=LR3(1:216,1:348,:);

[row col band]=size(LR1);

LR11=LR1(1:2:row,1:2:col,1:4);
LR2=LR2(1:2:row,1:2:col,1:4);
LR3=LR3(1:2:row,1:2:col,1:4);
s={LR11,LR2,LR3};
nrofim=3;%number of images
[x y] = estimate_shift(s,25);
F=shiftmatrix(x,y,row,col,nrofim);
B=blur(LR1);
D=downfunction(LR1);
W=systemmatrix(D,B,F,nrofim);

int=imresize(LR11,2,'bicubic');
%int=(double(int{1})+double(int{2})+double(int{3}))/3;
%SR=l1btv(W,s,nrofim);
L2norm=l2normlaplacien(s,W,nrofim);
l2norm2=l2normlaplacien2(s,W,nrofim);
l2norm3=l2normlaplacien3(s,W,nrofim);
l12=l1normlaplacien2(s,W,nrofim);
huberresult=superhuber(s,W,nrofim);

disp(compute_psnr(double(LR1),double(int)));
disp(compute_psnr(double(LR1(2:end-1,2:end-1,1:band)),L2norm));
disp(compute_psnr(double(LR1(2:end-1,2:end-1,1:band)),l2norm2));
disp(compute_psnr(double(LR1(2:end-1,2:end-1,1:band)),l2norm3));
disp(compute_psnr(double(LR1(2:end-1,2:end-1,1:band)),l12));
disp(compute_psnr(double(LR1(2:end-1,2:end-1,1:band)),huberresult));