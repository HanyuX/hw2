function [H, icorrect, jcorrect] = ComputeHomographyRANSAC(P1, P2, inoisy, jnoisy, s, niter, ithresh)
% INPUT
%  P1:     [N x 2] Coordinates of feature points in I1.
%          The first column contains the x coordinates, the second
%          column the y coordinates.
%  P2:     [N x 2] Coordinates of feature points in I2.
%          The first column contains the x coordinates, the second
%          column the y coordinates.
%  inoisy: [n x 1] vector of indices into P1
%  jnoisy: [n x 1] vector of indices into P2. 
%          [inoisy, jnoisy] define the n (noisy) candidate correspondences.
%          For example, the k-th candidate correspondence suggests that
%          P1(inoisy(k),:) corresponds to P3(jnoisy(k),:)
% s:       [1 x 1] RANSAC sample size. This is the number of
%          correspondences that should be randomly selected from the
%          candidate set [inoisy, jnoisy] at each RANSAC iteration
% niter:   [1 x 1] the number of RANSAC iterations to run
% ithresh: [1 x 1] the inlier threshold 
%
% OUTPUT
%
%  H:      [3 x 3] homography matrix computed from correspondences that
%          gave the max number of inliers over all iterations
%  icorrect: [m x 1] vector of indices into P1
%  jcorrect: [m x 1] vector of indices into P2
%
%
%  In summary, here is what you need to do at each RANSAC iteration:
%  1. Select a random subset of s correspondences from [inoisy, jnoisy]
%  2. Compute a candidate homography Hcand from these s correspondences
%  3. Transform points P1 according to this candidate homography Hcand. 
%     Let P1T be the transformed points.
%  4. Count the number of inliers, i.e., count how many P2 points 
%     lie within a radius of "ithresh" from P1T points.
%
%  At the end of the iterative loop, use the inlier correspondences 
%  obtained for the maximum number of inliers to recompute the
%  homography and return the inlier correspondences in icorrect jcorrect
count = 0;
P1c = zeros(0,2);
P2c = zeros(0,2);
Dis = zeros(size(inoisy,1),1);
for i = 1 : size(inoisy,1),
    P1c = [P1c ; P1(inoisy(i,1),:)];
    P2c = [P2c ; P2(jnoisy(i,1),:)];
end;

for i = 1 : niter,
    r = randperm(size(inoisy,1));
    P1t = P1(inoisy(r(1:s)),:);
    P2t = P2(jnoisy(r(1:s)),:);
    h = ComputeHomography(P1t,P2t)';
    P1_homo = [P1c';ones(1,size(P1c,1))];
    P2_hPq = h*P1_homo;
    thirdC = [P2_hPq(3,:) ; P2_hPq(3,:) ; P2_hPq(3,:)];
    P2_hPq = P2_hPq ./ thirdC;
    P2_noHomo = P2_hPq(1:2,:)';
    dis_all = pdist2(P2c,P2_noHomo);
    dis = diag(dis_all);
    countNow = size(find(dis < ithresh),1);
    if(countNow > count || count == 0),
        count = countNow;
        H = h';
        Dis = dis;
    end
end
 icorrect = inoisy(find((Dis < ithresh) > 0))';
 jcorrect = jnoisy(find((Dis < ithresh) > 0))';
 H = ComputeHomography(P1(icorrect,:),P2(jcorrect,:));
end

