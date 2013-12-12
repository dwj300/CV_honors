function X = conformalForward2(U, t)
% conformalForward2 Forward transformation with negative square root.
%
% Supports conformal transformation example, ipexconformal.m
% ("Exploring a Conformal Mapping").

% Copyright 2005-2012 The MathWorks, Inc. 
% $Revision: 1.1.6.2 $  $Date: 2012/03/22 22:35:13 $

W = complex(U(:,1),U(:,2));
Z = W - sqrt(W.^2 - 1);
X(:,2) = imag(Z);
X(:,1) = real(Z);
