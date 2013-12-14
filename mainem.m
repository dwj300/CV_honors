% main for em

img=imread('lena_color.tif');
maskOut = em(img,2,10000,1,3,4); 
figure;
imshow(maskOut)
