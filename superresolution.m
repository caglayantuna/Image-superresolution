clear all;
close all;

[FileName,PathName] = uigetfile('*.tif','Select GeoTIFF file');
first_image = imread(strcat(PathName,FileName));
first_image=first_image(1:282,:);
[row col band]=size(first_image);
s=create_low(first_image);
nrofim=4;%number of images
[x y] = estimate_shift(s,10);
F=shiftmatrix(x,y,row,col,4);
B=blur2(first_image);
D=downfunction(first_image);
W=systemmatrix(D,B,F,4);

int=imresize(s{1},2,'bicubic');
% int=(single(int{1})+single(int{2})+single(int{3})+single(int{4}))/4;
l2norm=l2normlaplacien(s,W,nrofim);
l2norm2=l2normlaplacien2(s,W,nrofim);
l2norm3=l2normlaplacien3(s,W,nrofim);
SR=l1btv(W,s,nrofim);
l1norm2=l1normlaplacien2(s,W,nrofim);
huberresult=totalvar(s,W,nrofim);

figure;imshow(s{1});title 'One Of Low Resolution Image Image';
figure;imshow(first_image);title 'Original Image');
figure;imshow(uint8(int));title 'interpolation result';
figure;imshow(uint8(SR));title 'L1+BTV result';
figure;imshow(uint8(l2norm));title 'l2norm laplacien';
figure;imshow(uint8(l2norm2));title 'l2norm2 laplacien';
figure;imshow(uint8(l2norm3));title 'l2norm3 laplacien';
figure;imshow(uint8(l1norm2));title 'l1norm laplacien2';
figure;imshow(uint8(huberresult));title 'huber result';




