clear all;
close all;
addpath('C:\Users\PROCOMP7\Desktop\Superresolution\Matlab\superresolution_matlab');
[FileName,PathName] = uigetfile('*.tif','Select GeoTIFF file');
LR1= imread(strcat(PathName,FileName));
[FileName,PathName] = uigetfile('*.tif','Select GeoTIFF file');
LR2 = imread(strcat(PathName,FileName));
[FileName,PathName] = uigetfile('*.tif','Select GeoTIFF file');
LR3 = imread(strcat(PathName,FileName));

LR1=LR1(1:150,1:150,1:4);
LR2=LR2(1:150,1:150,1:4);
LR3=LR3(1:150,1:150,1:4);
[row col band]=size(LR1);
hr=zeros(2*row,2*col,band);
nrofim=3;%number of images
s={LR1,LR2,LR3};
[x y] =estimate_shift(s,4);
F=shiftmatrix(x,y,2*row,2*col,nrofim);
D=downfunction(hr);
B=blur2(hr);
W=systemmatrix(D,B,F,nrofim);

int=interp(s,nrofim);
int=(double(int{1})+double(int{2})+double(int{3}))/3;
SR=l1btv(W,s,nrofim);
resultl2norm=l2normlaplacien(s,W,nrofim);
resultl2norm2=l2normlaplacien2(s,W,nrofim);
l2norm3=l2normlaplacien3(s,W,nrofim);
l1normlaplacien2=l1normlaplacien2(s,W,nrofim);
huberresult=totalvar(s,W,nrofim);
if band>1
figure;imshow(uint16(50*(LR1(:,:,1:band-1))));title 'One of Low Resolution Image';
figure;imshow(uint16(50*(int(:,:,1:band-1))));title 'Interpolation Result';
figure;imshow(uint16(50*(SR(:,:,1:band-1))));title 'L1+BTVResult';
figure;imshow(uint16(50*(resultl2norm(:,:,1:band-1))));title 'L2 Norm';
figure;imshow(uint16(50*(resultl2norm2(:,:,1:band-1))));title 'L2 Norm2';
figure;imshow(uint16(50*(l2norm3(:,:,1:band-1))));title 'L2 Norm3';
figure;imshow(uint16(50*(l1normlaplacien2(:,:,1:band-1))));title 'l1norm2 laplacien';
figure;imshow(uint16(50*(huberresult(:,:,1:band-1))));title 'huberresult';
else
 figure;imshow(uint16(40*(LR1)));title 'One of Low Resolution Image';
figure;imshow(uint16(30*(int)));title 'Interpolation Result';
figure;imshow(uint16(30*(SR)));title 'L1+BTV';
figure;imshow(uint16(30*(resultl2norm)));title 'L2 Norm';
figure;imshow(uint16(30*(resultl2norm2)));title 'L2 Norm2';
figure;imshow(uint16(30*(l2norm3)));title 'L2 Norm3';
figure;imshow(uint16(30*(l1normlaplacien2)));title 'l1norm2 laplacien';
figure;imshow(uint16(40*(huberresult)));title 'tv';
end
%result=geowrite(resull2norm,row,col);