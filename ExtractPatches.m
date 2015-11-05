function [F1, F2] = ExtractPatches(P1, P2, I1, I2, w)

% INPUT
%  P1:     [N x 2] Coordinates of feature points in I1.
%          The first column contains the x coordinates, the second
%          column the y coordinates.
%  P2:     [N x 2] Coordinates of feature points in I2.
%  I1:     [m x n x 3] color image
%  I2:     [m x n x 3] color image
%  w:      [1 x 1] size of patches
%
% OUTPUT
%
%  F1:     [N x w^2] matrix containing N features descriptors extracted
%          from I1 at points P1. The i-th row contains the flattened
%          grayscale patch of size wxw centered at P1(i,:)
%  F2:     [N x w^2] matrix containing N features descriptors extracted
%          from I2 at points P2. The i-th row contains the flattened
%          grayscale patch of size wxw centered at P2(i,:)
temp = P1(:,1);
P1(:,1) = P1(:,2);
P1(:,2) = temp;
temp = P2(:,1);
P2(:,1) = P2(:,2);
P2(:,2) = temp;

I1b = zeros(size(I1,1)+w*2,size(I1,2)+w*2,1);
I2b = zeros(size(I2,1)+w*2,size(I2,2)+w*2,1);
I1b(w+1:size(I1,1)+w,w+1:size(I1,2)+w) = rgb2gray(I1);
I2b(w+1:size(I2,1)+w,w+1:size(I2,2)+w) = rgb2gray(I2);
F1 = zeros(1,w*w);
F2 = zeros(1,w*w);
for i = 1:size(P1,1),
    m1 = I1b(w+P1(i,1)-(w-1)/2:w+P1(i,1)+(w-1)/2,w+P1(i,2)-(w-1)/2:w+P1(i,2)+(w-1)/2);
    m2 = I2b(w+P2(i,1)-(w-1)/2:w+P2(i,1)+(w-1)/2,w+P2(i,2)-(w-1)/2:w+P2(i,2)+(w-1)/2);
    m3 = m1(:)';
    m4 = m2(:)';
    F1 = [F1 ; m3];
    F2 = [F2 ; m4];
end
F1 = F1(2:end, :);
F2 = F2(2:end, :);
end
