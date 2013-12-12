%% Registering Multimodal MRI Images
% This example shows how you can use |imregister| to automatically
% align two magnetic resonance images (MRI) to a common coordinate
% system using intensity-based image registration.  Unlike some other
% techniques, it does not find features or use control points.
% Intensity-based registration is often well-suited for medical and
% remotely sensed imagery.

% Copyright 2011 The MathWorks, Inc.


%% Step 1: Load Images
% This example uses two magnetic resonance (MRI) images of a knee.
% The fixed image is a spin echo image, while the moving image is a
% spin echo image with inversion recovery.  The two sagittal slices
% were acquired at the same time but are slightly out of alignment.

fixed = dicomread('knee1.dcm');
moving = dicomread('knee2.dcm');

%%
% The |imshowpair| function is a useful function for visualizing
% images during every part of the registration process.  Use it to see
% the two images individually in a montage fashion or display them
% stacked to show the amount of misregistration.

figure, imshowpair(moving, fixed, 'montage')
title('Unregistered')

%%
% In the overlapping image from |imshowpair|, gray areas correspond to
% areas that have similar intensities, while magenta and green areas
% show places where one image is brighter than the other.  In some
% imager pairs, green and magenta areas don't always indicate
% misregistration, but in this example it's easy to use the color
% information to see where they do.

figure, imshowpair(moving, fixed)
title('Unregistered')


%% Step 2: Set up the Initial Registration
% The |imregconfig| function makes it easy to pick the correct
% optimizer and metric configuration to use with |imregister|. These
% two images have different intensity distributions, which suggests a
% multimodal configuration.

[optimizer,metric] = imregconfig('multimodal');

%%
% The distortion between the two images includes scaling, rotation,
% and (possibly) shear.  Use an affine transformation to register the
% images.
%
% It's very, very rare that |imregister| will align images perfectly
% with the default settings.  Nevertheless, using them is a useful way
% to decide which properties to tune first.

tic
movingRegisteredDefault = imregister(moving, fixed, 'affine', optimizer, metric);
timeDefault = toc

figure, imshowpair(movingRegisteredDefault, fixed)
title('A: Default registration')


%% Step 3: Improve the Registration
% The initial registration was pretty good, but there are still some
% areas that don't line up.  It's easiest to see this along the left
% and right edges of the image and in the small bright bands that run
% through the right-hand part.  Try to improve the registration by
% adjusting the optimizer and metric configuration properties.
%
% The optimizer and metric variables are objects whose properties
% control the registration.

optimizer
metric

%%
% Because the registration improved with the default parameters,
% perhaps it will continue to improve if the optimization runs longer.

optimizer.MaximumIterations = 300;

movingRegistered = imregister(moving, fixed, 'affine', optimizer, metric);
figure, imshowpair(movingRegistered, fixed)
title('MaximumIterations = 300')

%%
% Does it continue to improve if run even longer?

optimizer.MaximumIterations = 500;

tic
movingRegistered500 = imregister(moving, fixed, 'affine', optimizer, metric);
time500 = toc

figure, imshowpair(movingRegistered500, fixed)
title('B: MaximumIterations = 500')


%% Step 4: Improve the Speed of Registration
% The previous section showed that it's often possible to improve a
% registration with the default parameters simply by letting it run
% longer.  Although increasing 'MaximumIterations' will likely lead to
% convergence, it's also likely that running for a longer time will
% yield diminishing returns.
%
% It's often possible to force the optimizer to be more aggressive in
% its initial steps.  Changing parameters that control step size might
% move the registration closer to the correct solution more quickly,
% but it could result in treating a local extrema as the best answer,
% when the best answer is elsewhere in the optimization space.
%
% The 'InitialRadius' property controls the initial search radius for
% the optimizer.

optimizer.MaximumIterations = 100;
optimizer.InitialRadius = 0.009;

movingRegistered = imregister(moving, fixed, 'affine', optimizer, metric);
figure, imshowpair(movingRegistered, fixed)
title('MaximumIterations = 100, InitialRadius = 0.009')

%%
% Compared with the default configuration, the results are worse.
% While 'InitialRadius specifies the upper bound of the search radius,
% 'Epsilon' sets the lower bound.

[optimizer,metric] = imregconfig('multimodal');
optimizer.Epsilon = 1.5e-4;

movingRegistered = imregister(moving, fixed, 'affine', optimizer, metric);
figure, imshowpair(movingRegistered, fixed)
title('MaximumIterations = 100, Epsilon = 1.5e-4')

%%
% This configuration yields almost exactly the same registration as
% the default parameters with almost no difference in performance.
%
% The only remaining optimizer property to tweak independently is
% 'GrowthFactor', which controls the rate at which the search radius
% grows in parameter space.  A larger growth factor causes a more
% aggressive optimization.

[optimizer,metric] = imregconfig('multimodal');
optimizer.GrowthFactor = 1.1;

movingRegistered = imregister(moving, fixed, 'affine', optimizer, metric);
figure, imshowpair(movingRegistered, fixed)
title('MaximumIterations = 100, GrowthFactor = 1.1')

%%
% That seemed too aggressive.  Perhaps the default value is too
% large.  Try a smaller 'GrowthFactor' setting.

optimizer.GrowthFactor = 1.01;

tic
movingRegisteredGrowth = imregister(moving, fixed, 'affine', optimizer, metric);
timeGrowth = toc

figure, imshowpair(movingRegisteredGrowth, fixed)
title('C: MaximumIterations = 100, GrowthFactor = 1.01')


%% Step 5: Further Refinement
% Usually a combination of changes to the step-size parameters and
% number of iterations to run yields the best results.

[optimizer,metric] = imregconfig('multimodal');
optimizer.GrowthFactor = 1.01;
optimizer.InitialRadius = 0.009;
optimizer.Epsilon = 1.5e-4;
optimizer.MaximumIterations = 300;

tic
movingRegisteredTuned = imregister(moving, fixed, 'affine', optimizer, metric);
timeTuned = toc

figure, imshowpair(movingRegisteredTuned, fixed)
title('D: MaximumIterations = 300, GrowthFactor = 1.01, Epsilon = 1.5e-4, InitialRadius = 0.009')


%% Step 6: Deciding When Enough is Enough
% Comparing the results of running |imregister| with different
% configurations, it becomes apparent that there's a trade-off between
% performance and accuracy.  The difference in execution time and
% quality of the default registration run for 100 iterations (A) and
% the most highly tuned set of properties (B) is quite large.
%
% The difference between running |imregister| with a nonstandard
% growth factor for 100 iterations (C) and the best result (B) is
% obvious, too. It becomes more of a trade-off between the quality of
% the highly tuned registration executed to 300 iterations (D) and the
% default registration run to 500 iterations (B), given the
% comparatively small amount of time that it took to get there.

figure
imshowpair(movingRegisteredDefault, fixed)
title(sprintf('A - Default settings - %0.2f sec', timeDefault))

figure
imshowpair(movingRegistered500, fixed)
title(sprintf('B - Default settings, 500 iterations - %0.2f sec', time500))

figure
imshowpair(movingRegisteredGrowth, fixed)
title(sprintf('C - Growth factor, 100 iterations - %0.2f sec', timeGrowth))

figure
imshowpair(movingRegisteredTuned, fixed)
title(sprintf('D - Highly tuned, 300 iterations - %0.2f sec', timeTuned))


%% Step 7: Alternate Visualizations
% Often as the quality of multimodal registrations improve it becomes more
% difficult to judge the quality of registration visually.  This is because
% the intensity differences can obscure areas of misalignment.  Sometimes
% switching to a different display mode for |imshowpair| exposes hidden
% details.  (This is not always the case.)


displayEndOfDemoMessage(mfilename)
