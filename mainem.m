% main for em

img=imread('lena_color.tif');
[maskOut]=kGaussian_color_EM(img,9); 
figure;
imshow(maskOut)
