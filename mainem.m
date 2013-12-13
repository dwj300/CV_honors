% main for em

img=imread('mandril_color.tif');
[maskOut]=kGaussian_color_EM(img,9); 
figure;
imshow(maskOut)
