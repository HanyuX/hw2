function [Cs] = FindCorners(I, thresh, n)
%
% Finds corners in grayscale image I using the eigenvalues computed by the provided function smme.m
% 
% INPUT
%  I:      [M x N] grayscale image
%  thresh: [1 x 1] scalar value containing a single threshold
%  n:      [1 x 1] scalar value denoting the size of the window used by
%                  smme (should be passed as argument to smme)
%
% OUTPUT
%  Cs:     [M x N] Corner strength map. Should be non-zero (and positive) only at corner pixels
[lambdamax,lambdamin,ori]=smme(I,n);
Cs = lambdamax;
Cs(lambdamin < thresh) = 0;
end
