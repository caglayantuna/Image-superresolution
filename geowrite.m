function result=geowrite(im,row,col);
[FileName,PathName] = uigetfile('*.tif','Select GeoTIFF file');
[a R]= geotiffread(strcat(PathName,FileName));
info = geotiffinfo('strcat(PathName,FileName');
xi = [1 - .5, col + .5];
yi = [1 - .5, row + .5];
[xlimits, ylimits] = intrinsicToWorld(R, xi, yi);
subR = R;
subR.RasterSize =[2*row 2*col];
subR.XLimWorld = sort(xlimits);
subR.YLimWorld = sort(ylimits);
[FileName,PathName] = uigetfile('*.tif','Select GeoTIFF file');
info= geotiffinfo(strcat(PathName,FileName));
info.GeoTIFFTags.GeoKeyDirectoryTag.ProjectedCSTypeGeoKey=32635;
im=uint16(im);
geotiffwrite('im.tif', im, subR,'GeoKeyDirectoryTag', info.GeoTIFFTags.GeoKeyDirectoryTag);
end
