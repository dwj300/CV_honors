function ax = conformalSetupInputAxes(ax)
% conformatlSetupInputAxes Set up axes in the input/'w' plane.
%
% Supports conformal transformation example, ipexconformal.m
% ("Exploring a Conformal Mapping").

% Copyright 2005-2012 The MathWorks, Inc. 
% $Revision: 1.1.6.2 $  $Date: 2012/03/22 22:35:16 $

set(ax, 'DataAspectRatio',[1 1 1],...
		'XLimMode','manual',...
        'YLimMode','manual',...
		'PlotBoxAspectRatioMode', 'manual');
set(ax,'XLim',[-1.5 1.5]);
set(ax,'YLim',[-1.0 1.0]);
set(ax,'Xlabel',text('String','Re(w)'));
set(ax,'Ylabel',text('String','Im(w)'));
set(ax,'Title',text('String','Input Plane'));
