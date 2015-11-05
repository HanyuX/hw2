function [Es, En] = FindEdges(I, thresh, n)
%
% Finds edges in grayscale image I using the eigenvalues computed by the provided function smme.m
% 
% INPUT
%  I:      [M x N] grayscale image
%  thresh: [2 x 1] vector containing threshold parameters (you can safely
%                  assume that the first is larger than the second)
%  n:      [1 x 1] scalar value denoting the size of the window used by
%                  smme (should be passed as argument to smme)
%
% OUTPUT
%  Es:     [M x N] Edge strength map. Should be 0 at non-edge pixels (thus
%                  it should be zero also at corner points)
%  En:     [M x N] Edge normal directions (as angles in [0, pi]). Should be 0 at non-edge pixels (thus
%                  it should be zero also at corner points)
[lambdamax,lambdamin,ori]=smme(I,n);
Es = lambdamax;
En = ori;
Es(lambdamax <= thresh(1)) = 0;
Es(lambdamin >= thresh(2)) = 0;
En(lambdamax <= thresh(1)) = 0;
En(lambdamin >= thresh(2)) = 0;
En(En < 0) = En(En < 0)+3.1415926;
end
