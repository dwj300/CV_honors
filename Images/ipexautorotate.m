%% Find Image Rotation and Scale Using Automated Feature Matching
% This example shows how to automatically align two images that differ by a
% rotation and a scale change. It closely parallels another example titled
% <matlab:showdemo('ipexrotate') Find Image Rotation and Scale>. 
% Instead of using a manual approach to register the two images, it
% utilizes feature-based techniques found in the Computer Vision System
% Toolbox(TM) to automate the registration process.
%
% In this example, you will use |detectSURFFeatures| and 
% |vision.GeometricTransformEstimator| System object to recover rotation 
% angle and scale factor of a distorted image. You will then transform the 
% distorted image to recover the original image.

% Copyright 1993-2012 The MathWorks, Inc. 
% $Revision: 1.1.6.4 $ $Date: 2012/04/25 07:11:25 $

%% Step 1: Read Image
% Bring an image into the workspace.
original = imread('cameraman.tif');
imshow(original);
text(size(original,2),size(original,1)+15, ...
    'Image courtesy of Massachusetts Institute of Technology', ...
    'FontSize',7,'HorizontalAlignment','right');

%% Step 2: Resize and Rotate the Image

scale = 0.7;
J = imresize(original, scale); % Try varying the scale factor.

theta = 30;
distorted = imrotate(J,theta); % Try varying the angle, theta.
figure, imshow(distorted)

%%
% You can experiment by varying the scale and rotation of the input image.
% However, note that there is a limit to the amount you can vary the scale
% before the feature detector fails to find enough features.

%% Step 3: Find Matching Features Between Images
% Detect features in both images.
ptsOriginal  = detectSURFFeatures(original);
ptsDistorted = detectSURFFeatures(distorted);

%%
% Extract feature descriptors.
[featuresIn   validPtsIn]  = extractFeatures(original,  ptsOriginal);
[featuresOut validPtsOut]  = extractFeatures(distorted, ptsDistorted);

%%
% Match features by using their descriptors.
index_pairs = matchFeatures(featuresIn, featuresOut);

%%
% Retrieve locations of corresponding points for each image.
matchedOriginal  = validPtsIn(index_pairs(:,1));
matchedDistorted = validPtsOut(index_pairs(:,2));

%%
% Show point matches. Notice the presence of outliers.
figure;
showMatchedFeatures(original,distorted,matchedOriginal,matchedDistorted);
title('Putatively matched points (including outliers)');

%% Step 4: Estimate Transformation
% Find a transformation matrix corresponding to the matching point pairs 
% using the statistically robust RANdom SAmpling Consensus (RANSAC) 
% algorithm. Remove outliers while computing the transformation matrix.
%
% Note the use of System object from the Computer Vision System Toolbox.
% To use a System object, you will first construct it, configure it,
% and then invoke a step() method to execute the main algorithm.
geoTransformEst = vision.GeometricTransformEstimator; % defaults to RANSAC

% Configure the System object.
geoTransformEst.Transform = 'Nonreflective similarity';
geoTransformEst.NumRandomSamplingsMethod = 'Desired confidence';
geoTransformEst.MaximumRandomSamples = 1000;
geoTransformEst.DesiredConfidence = 99.8;

% Invoke the step() method on the geoTransformEst object to compute the 
% transformation from the distorted to the original image. You 
% may see varying results of the transformation matrix computation because 
% of the random sampling employed by the RANSAC algorithm.
[tform_matrix inlierIdx] = step(geoTransformEst, matchedDistorted.Location, ...
    matchedOriginal.Location);

%%
% Display matching point pairs used in the computation of the
% transformation matrix.
figure;
showMatchedFeatures(original,distorted,matchedOriginal(inlierIdx),...
    matchedDistorted(inlierIdx));
title('Matching points (inliers only)');
legend('ptsOriginal','ptsDistorted');

%% Step 5: Solve for Scale and Angle
% Use the geometric transformation matrix, TFORM_MATRIX, to recover 
% the scale and angle. Since we computed the transformation from the
% distorted to the original image, we need to compute its inverse to 
% recover the distortion.
%
%  Let sc = s*cos(theta)
%  Let ss = s*sin(theta)
%
%  Then, Tinv = [sc -ss  0;
%                ss  sc  0;
%                tx  ty  1]
%
%  where tx and ty are x and y translations, respectively.
%

%%
% The matrix obtained in the previous step describes a nonreflective 
% similarity transformation in a compact 3-by-2 matrix, without the implied 
% [0 0 1]' last column. The inverse operation requires this column.
tform_matrix = cat(2,tform_matrix,[0 0 1]'); % pad the matrix
Tinv  = inv(tform_matrix);

ss = Tinv(2,1);
sc = Tinv(1,1);
scale_recovered = sqrt(ss*ss + sc*sc)
theta_recovered = atan2(ss,sc)*180/pi

%%
% The recovered values should match your scale and angle values selected in
% *Step 2: Resize and Rotate the Image*.

%% Step 6: Recover the Original Image
% Recover the original image by transforming the distorted image.
t = maketform('affine', double(tform_matrix));
D = size(original);
recovered = imtransform(distorted,t,'XData',[1 D(2)],'YData',[1 D(1)]);

%%
% Compare |recovered| to |original| by looking at them side-by-side in a montage.
figure, imshowpair(original,recovered,'montage')

%%
% The |recovered| (right) image quality does not match the |original| (left)
% image because of the distortion and recovery process. In particular, the 
% image shrinking causes loss of information. The artifacts around the edges are 
% due to the limited accuracy of the transformation. If you were to detect 
% more points in *Step 4: Find Matching Features Between Images*, 
% the transformation would be more accurate. For example, we could have
% used a corner detector, |vision.CornerDetector|, to complement the SURF 
% feature detector which finds blobs. Image content and image size also 
% impact the number of detected features.

displayEndOfDemoMessage(mfilename)
