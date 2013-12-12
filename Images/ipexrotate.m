%% Find Image Rotation and Scale
% This example shows how to align or register two images that differ by a
% rotation and a scale change. You can use |cp2tform| to find the rotation angle
% and scale factor after manually picking corresponding points. You can then
% transform the distorted image to recover the original image.

% Copyright 1993-2012 The MathWorks, Inc. 
% $Revision: 1.4.4.11 $ $Date: 2012/04/25 07:11:26 $

%% Step 1: Read Image
% Read an image into the workspace.

original = imread('cameraman.tif');
imshow(original);
text(size(original,2),size(original,1)+15, ...
    'Image courtesy of Massachusetts Institute of Technology', ...
    'FontSize',7,'HorizontalAlignment','right');

%% Step 2: Resize and Rotate the Image

scale = 0.7;
distorted = imresize(original,scale); % Try varying the scale factor.

theta = 30;
distorted = imrotate(distorted,theta); % Try varying the angle, theta.
figure, imshow(distorted)

%% Step 3: Select Control Points
% Use the Control Point Selection Tool to pick at least two pairs of
% control points. 

input_points = [151.52  164.79; 131.40 79.04];
base_points = [135.26  200.15; 170.30 79.30];

%%
% You can run the rest of the example with these pre-picked points, but 
% try picking your own points to see how the results vary.
%
%  cpselect(distorted,original,input_points,base_points);

%%
% Save control points by choosing the *File* menu, then the *Save Points to
% Workspace* option. Save the points, overwriting variables |input_points|
% and |base_points|.

%% Step 4: Estimate Transformation
% Find a |TFORM| structure that is consistent with your control points.

t = cp2tform(input_points,base_points,'nonreflective similarity');

%%
% After you have done Steps 5 and 6, repeat Steps 4 through 6 but try using
% 'affine' instead of 'nonreflective similarity'. What happens? Are the results
% as good as they were with 'nonreflective similarity'?

%% Step 5: Solve for Scale and Angle
% The |TFORM| structure, |t|, contains a transformation matrix in
% |t.tdata.Tinv|. Since you know that the transformation includes only
% rotation and scaling, the math is relatively simple to recover the scale
% and angle.
%
%  Let sc = s*cos(theta)
%  Let ss = s*sin(theta)
%
%  Then, Tinv = t.tdata.Tinv = [sc -ss  0;
%                               ss  sc  0;
%                               tx  ty  1]
%
%  where tx and ty are x and y translations, respectively.

ss = t.tdata.Tinv(2,1);
sc = t.tdata.Tinv(1,1);
scale_recovered = sqrt(ss*ss + sc*sc)
theta_recovered = atan2(ss,sc)*180/pi

%%
% The recovered values of |scale_recovered| and |theta_recovered| should match
% the values you set in *Step 2: Resize and Rotate the Image*.

%% Step 6: Recover Original Image
% Recover the original image by transforming |distorted|, the rotated-and-scaled
% image, using |TFORM| structure |t| and what you know about the size of
% |original|.

D = size(original);
recovered = imtransform(distorted,t,'XData',[1 D(2)],'YData',[1 D(1)]);

%%
% Compare |recovered| to |original| by looking at them side-by-side in a montage.
figure, imshowpair(original,recovered,'montage')

%%
% The |recovered| (right) image quality does not match the |original| (left)
% image because of the distortion and recovery process. In particular, the image
% shrinking causes loss of information. The artifacts around the edges are due
% to the limited accuracy of the transformation.  If you were to pick more
% points in *Step 3: Select Control Points*, the transformation would be more
% accurate.

displayEndOfDemoMessage(mfilename)

