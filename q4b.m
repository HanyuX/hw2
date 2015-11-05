%  Size-checking
ret_code = checking('q4b');

if(ret_code ~= 0)
    fprintf(1, 'Checking q4b did not pass. Not executing this script file q4b.m\n');
    return
end

clear;
% End of size-checking

I1 = imread('church1.jpg');
I2 = imread('church2.jpg');

if ~exist('q4a.mat', 'file'),
    fprintf('File q4a.mat does not exists. You must run q4a.m before this script.....\n');
    return;    
else       
    load('q4a.mat', 'P1', 'P2');
end

H = ComputeHomography(P1, P2);

Ip = mosaicing(I1, I2, H);
figure;
imshow(Ip);
title('Mosaic created from ground truth correspondences');