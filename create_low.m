function [s]=create_low(first_image)
[row col]=size(first_image);
%downsampled low images
low1=first_image(1:2:end,1:2:end);
%transform low images seperately
%low1reference
%low2
low2 = imtranslate(low1,[0.8, 0.3]);
%low3
low3= imtranslate(low1,[0.25, 0.4]);
%low4
low4= imtranslate(low1,[0.6, 0.5]);
s={low1,low2,low3,low4};
end