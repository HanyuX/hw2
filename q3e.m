%  Size-checking
ret_code = checking('q3e');

if(ret_code ~= 0)
    fprintf(1, 'Checking q3e did not pass. Not executing this script file q3e.m\n');
    return
end

clear;
% End of size-checking

n = {5, 5};
thresh_edges = {[130 30], [60 30]};
thresh_corners = {120, 40};
title_str = {'edges and corners from original image', 'edges and corners from smoothed image'};

I{1} = double(imread('venice.pgm'));
I{2} = gaussn(I{1}, 15);

figure;
for k=1:2,
    [Es{k}, En{k}] = FindEdges(I{k}, thresh_edges{k}, n{k});
    [i{k},j{k}] = find(Es{k}>0);
    
    Enms{k} = nonmaxsuppression(Es{k}, En{k});
    [inms{k},jnms{k}] = find(Enms{k}>0);
    
    Cs{k} = FindCorners(I{k}, thresh_corners{k}, n{k});
    [ic{k},jc{k}] = find(Cs{k}>0);
    
    subplot(1,2,k);
    imshow(uint8(I{1}));
    hold on;
    plot(jnms{k},inms{k}, '.r');
    plot(jc{k}, ic{k}, 'sb');
    hold off;
    
    title(title_str{k});
end

