%%%%%%%%%%%%% The active_contour.m file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:
%      Demonstrates the activecontour function of MATLAB.
%
% Processing Flow:
%      1.  For each image, imput the image then either 
%      a.  Creates a mask of all ones with a 25 px border to use for active
%              contour analysis
%      b.  Askes the user to draw a mask on the image
%      2.  Applies the activecontour function with various parameters
%      3.  Outputs the segmented image
%
%  Author:      Douglas Jordan, Matt Rozak
%  Date:        12/18/2013
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function active_contour_demo()
    % Part 1: demonstrate activecontour without human interaction 
    clear; 
    filename = 'images/coins.png';
    I = imread(filename);
    figure, imshow(I);
    % Specify mask of all 1's (except for a 25 pixel border of 0's)
    mask = zeros(size(I));
    mask(25:end-25,25:end-25) = 1;
    
    figure, imshow(mask);
    title('Initial Contour Location');
    
    bw = activecontour(I,mask,300);
      
    figure, imshow(bw);
    title('Segmented Image - 300 itterations');
    
    bw2 = activecontour(I,mask,100); 
    figure, imshow(bw2);node
    title('Segmented Image - 100 itterations');

    % Part 2: Image segmentation with human interaction - coloredChips.png
    filename = 'images/coloredChips.png';
    I = imread(filename);
    figure, imshow(I);

    str = 'Click to select initial contour location. Double-click to confirm and proceed.';
    title(str,'Color','b','FontSize',12);
    mask = roipoly; % Interactively determine mask

    figure, imshow(mask);
    title('Initial MASK');

    % Only if greyscale image
    I = rgb2gray(I); 
    bw = activecontour(I, mask, 250, 'Chan-Vese'); 
   
    figure, imshow(bw)
    title('Segmented Image 250 itterations');
    
    bw2 = activecontour(I, mask, 200, 'Chan-Vese'); 
   
    figure, imshow(bw2)
    title('Segmented Image - 20 itterations');
    
    % Part 3 - cameraman.tif
    filename = 'images/cameraman.tif';
    I = imread(filename);
    figure, imshow(I);

    str = 'Click to select initial contour location. Double-click to confirm and proceed.';
    title(str,'Color','b','FontSize',12);
    mask = roipoly; % Interactively determine mask

    figure, imshow(mask);
    title('Initial MASK');

    bw = activecontour(I, mask, 250, 'Chan-Vese'); 
   
    figure, imshow(bw)
    title('Segmented Image - Chan-Vese');
    
    bw2 = activecontour(I, mask, 250, 'Edge'); 
   
    figure, imshow(bw2)
    title('Segmented Image - Edge');
    
    % Part 4 - onion.png
    filename = 'images/onion.png';
    I = imread(filename);
    figure, imshow(I);

    str = 'Click to select initial contour location. Double-click to confirm and proceed.';
    title(str,'Color','b','FontSize',12);

    mask = roipoly; % Interactively determine mask
     
    figure, imshow(mask);
    title('Initial MASK');

    % Only if greyscale image
    I = rgb2gray(I); 
    
    bw = activecontour(I, mask, 250, 'Chan-Vese'); 
    figure, imshow(bw)
    title('Segmented Image - Chan-Vese');
    
    bw2 = activecontour(I, mask, 250, 'Edge');
    figure, imshow(bw2)
    title('Segmented Image - Edge');
end
