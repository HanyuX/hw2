%  Size-checking
ret_code = checking('q3c');

if(ret_code ~= 0)
    fprintf(1, 'Checking q3c did not pass. Not executing this script file q3c.m\n');
    return
end

clear;
% End of size-checking

n=5;
thresh_edges=[130 30];

I = double(imread('venice.pgm'));

[Es, En] = FindEdges(I, thresh_edges, n);
[i,j] = find(Es>0);

Enms = nonmaxsuppression(Es, En);
[inms,jnms] = find(Enms>0);

figure;
subplot(1,2,1);
imshow(uint8(I));
hold on;
plot(j, i, '.r');
hold off;
title('thresholded edges');

subplot(1,2,2);
imshow(uint8(I));
hold on;
plot(jnms, inms, '.r');
hold off;
title('edges after non-max suppression');

