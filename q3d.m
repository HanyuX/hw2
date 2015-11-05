%  Size-checking
ret_code = checking('q3d');

if(ret_code ~= 0)
    fprintf(1, 'Checking q3d did not pass. Not executing this script file q3d.m\n');
    return
end

clear;
% End of size-checking

n=5;
thresh_corners = 120;

I = double(imread('venice.pgm'));

Cs = FindCorners(I, thresh_corners, n);
[ic,jc] = find(Cs>0);

figure;
imshow(uint8(I));
hold on;
plot(jc, ic, 'sb');
hold off;
title('corners');

