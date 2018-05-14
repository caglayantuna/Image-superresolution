clear all;
close all;
addpath spotpan
[a R]=geotiffread('spotpan1.tif');
info = geotiffinfo('spotpan1.tif');
int=imresize(a,2,'bicubic');
Rint=R;
Rint.RasterSize = size(int);
info.GeoTIFFTags.GeoKeyDirectoryTag.ProjectedCSTypeGeoKey=32635;
subImage = int;
 xi = [1 - .5, 4092 + .5];
 yi = [1 - .5, 2762 + .5];
[xlimits, ylimits] = intrinsicToWorld(Rint, xi, yi);
subR = Rint;
subR.RasterSize = size(subImage);
subR.XLimWorld = sort(xlimits);
subR.YLimWorld = sort(ylimits);
filename = 'int2.tif';
geotiffwrite(filename, subImage, subR,  ...
       'GeoKeyDirectoryTag', info.GeoTIFFTags.GeoKeyDirectoryTag);      
