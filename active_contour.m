% main.m % authors: Matt Rozak, Douglas Jordan

clear;
%toyobjects.png
filename = 'toyobjects.png' %'Images/cameraman.tif';

I = imread(filename);
imshow(I)
  
str = 'Click to select initial contour location. Double-click to confirm and proceed.';
title(str,'Color','b','FontSize',12);
disp(sprintf('\nNote: Click close to object boundaries for more accurate result.'))

mask = roipoly;
  
figure, imshow(mask)
title('Initial MASK');

maxIterations = 200; 
bw = activecontour(I, mask, maxIterations, 'Chan-Vese');
  
% Display segmented image
figure, imshow(bw)
title('Segmented Image'); 