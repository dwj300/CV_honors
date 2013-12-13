% em.m % Matt Rozak
% Image segmentation using the Expectation-Maximization with a mixture of Gaussians

% args
x = [] % MxNxn - row, column, property, each pixel is a vector of properties
maxIter = 100
K = 5 % the number of clusters

function [] = exMax(x, K, maxIter, convTol)

% 'unpack' image into two dimensional matrix

%{ *** Initialization ***

Initialize each cluster's parameters
   Cluster Ck:
      u - mean
         Init to random property vector of length n
      E - covariance matrix
         Init to nxn identity matrix for property vectors of length n
      w - weight = P(Ck)
         Init to 1/K so that all clusters are intially weighted equally
%}

n = 0;
hasConverged = 1;


while n < maxIter && ~hasConverged % repeat E and M steps until convergence

% *** Assign pixels to clusters - Expectation ***

% for each pixel p
   % for each cluster k
   % end
% end

%{ *** Recomputer Parameters - Maximization ***

}%

end

end
