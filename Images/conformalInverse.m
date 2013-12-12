function U = conformalInverse(X, t)
% conformalInverse Inverse conformal transformation.
%
% Supports conformal transformation example, ipexconformal.m
% ("Exploring a Conformal Mapping").

% Copyright 2005-2012 The MathWorks, Inc. 
% $Revision: 1.1.6.2 $  $Date: 2012/03/22 22:35:14 $

Z = complex(X(:,1),X(:,2));
W = (Z + 1./Z)/2;
U(:,2) = imag(W);
U(:,1) = real(W);
