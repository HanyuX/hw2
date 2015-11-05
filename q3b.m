%  Size-checking
ret_code = checking('q3b');

if(ret_code ~= 0)
    fprintf(1, 'Checking q3b did not pass. Not executing this script file q3b.m\n');
    return
end

clear;
% End of size-checking

n=5;
thresh_edges=[130 30];

I = double(imread('venice.pgm'));

[Es, En] = FindEdges(I, thresh_edges, n);

[i,j] = find(Es>0);

figure;
imshow(uint8(I));
hold on;
plot(j, i, '.r');
hold off;
title('thresholded edges');

