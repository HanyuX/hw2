function [D, i, j] = EstablishCorrespondences(F1, F2, thresh)

% INPUT
%  F1:     [N x w^2] matrix containing N features descriptors extracted
%          from I1 
%  F2:     [N x w^2] matrix containing N features descriptors extracted
%          from I2 
%  thresh: [1 x 1] threshold on the Euclidean distances between feature
%          descriptors
%
% OUTPUT
%  D       [N x N] feature distance matrix. Entry D(m,n) should contain the
%          Euclidean distance between F1(m,:) and F2(n,:)
%  i       [r x 1] indices to points in P1
%  j       [r x 1] indices to points in P2
%          The interpretation is that there are r entries of D that have
%          value less than thresh. [i j] provide indices to such entries.
%          Thus (i(k), j(k)) is the k-th correspondence indicating that the
%          Euclidean distance between F1(i(k),:) and F2(j(k),:) is less
%          than thresh
D = pdist2(F1,F2);
index = find(D < thresh);
[i,j] = ind2sub(size(D),index);
end
