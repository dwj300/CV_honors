%% This will load, segment, and display the "peppers" image
I = imread('peppers.png');
[fimg labels modes regsize grad conf] = edison_wrapper(I,@RGB2Luv, 'steps',1);
imshow(Luv2RGB(fimg))


%% test code:
%% This will load, segment, and display the "peppers" image
I = imread('peppers.png');
[fimg labels modes regsize grad conf] = edison_wrapper(I,@RGB2Luv);
imshow(Luv2RGB(fimg))

%% This sets some specific parameters and segments the gantrycrane image
I = imread('gantrycrane.png');
[fimg labels modes regsize grad conf] = edison_wrapper(I,@RGB2Luv,...
      'SpatialBandWidth',8,'RangeBandWidth',4,...
      'MinimumRegionArea',50);
subplot(2,1,1), imshow(I); subplot(2,1,2), imshow(Luv2RGB(fimg));

%% This performs filtering only the grayscale "cameraman" image
I = imread('cameraman.tif');
I = repmat(I,[1 1 3]);
[fimg labels modes regsize grad conf] = edison_wrapper(I,@RGB2Luv,...
      'steps', 1, 'SpatialBandWidth',8,'RangeBandWidth',4);
I = rgb2gray(Luv2RGB(fimg));
subplot(2,1,1), imshow(I); subplot(2,1,2), imshow(I)