% main for em

img=imread('mandril_color.tif');
[maskOut]=kGaussian_color_EM(img,3); 
figure;
imshow(maskOut)
