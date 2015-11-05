function [P1, P2] = CollectGTpoints(I1, I2)

% INPUT
%  I1:      [m x n x 3] color image
%  I2:      [m x n x 3] color image
%
% OUTPUT
%  P1:     [N x 2] Coordinates of feature points manually selected in I1.
%          The first column should contain the x coordinates, the second
%          column the y coordinates.
%  P2:     [N x 2] Coordinates of feature points manually selected in I2.
%          P2(i, :) should be the I2 point corresponding to P1(i,:) in I1.i
gap = 255*ones(size(I1,1),100,3);
I = [I1,gap,I2];
imshow(I);
flag = 1;
b = zeros(1,1);
P1 = zeros(1,2);
P2 = zeros(1,2);
while(b(1) ~= 3)
    [x,y,b] = ginput(1);
    I(floor(y):floor(y)+10,floor(x):floor(x)+10,1) = 255;
    imshow(I);
    if flag == 1,
        P1 = [P1 ; [floor(x),floor(y)]];
        flag = 2;
    else
        P2 = [P2 ; [floor(x)-size(I1,2)-100, floor(y)]];
        flag = 1;
    end
end
P1 = P1(2:size(P1,1)-1  , 1:2);
P2 = P2(2:size(P2,1)    , 1:2);
end