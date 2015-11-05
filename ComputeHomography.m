function H = ComputeHomography(P1, P2)
% INPUT
%  P1:     [N x 2] Coordinates of feature points in I1.
%          The first column contains the x coordinates, the second
%          column the y coordinates.
%  P2:     [N x 2] Coordinates of *corresponding* feature points in I2.
%          The function should assume P2(i, :) is the feature point corresponding to P1(i,:) in I1.
%
% OUTPUT
%
%  H:      [3 x 3] homography matrix
A1 = [P1 ,ones(size(P1,1),1), zeros(size(P1,1),3)];
A2 = [zeros(size(P1,1),3), P1 ,ones(size(P1,1),1)];
A12 = zeros(size(P1,1)*2,6);
A12(1:2:end,:) = A1;
A12(2:2:end,:) = A2;
A3 = [P1(:,1) .* -P2(:,1) , P1(:,2) .* -P2(:,1) , -P2(:,1)];
A4 = [P1(:,1) .* -P2(:,2) , P1(:,2) .* -P2(:,2) , -P2(:,2)];
A34 = zeros(size(P1,1)*2,3);
A34(1:2:end,:) = A3;
A34(2:2:end,:) = A4;
A = [A12, A34];
[U,S,V] = svd(A);
H = V(:,end)';
H = [H(1:3) ; H(4:6) ; H(7:9)]';
end