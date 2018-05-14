clear all;
close all;
addpath spotxs
load('webcamsSceneReconstruction.mat');

a=imread('multi1.tif');
b=imread('multi3.tif');

[J1, J2] = rectifyStereoImages(a(:,:,1:3),b(:,:,1:3),stereoParams);
figure;
imshow(cat(3,30*J1(:,:,1),30*J2(:,:,2:3)),'InitialMagnification',50);
disparityMap = disparity(rgb2gray(J1), rgb2gray(J2));
figure;
imshow(disparityMap,[0,64],'InitialMagnification',50);