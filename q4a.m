I1 = imread('church1.jpg');
I2 = imread('church2.jpg');

if exist('q4a.mat', 'file'),
    fprintf('File q4a.mat already exists, skipping point collection....\n');
    
    load('q4a.mat', 'P1', 'P2');
else       
    [P1, P2] = CollectGTpoints(I1, I2);
end

if (size(P1,1) ~= size(P2,1)) | (size(P1,2) ~= 2) | (size(P2,2) ~= 2),
    fprintf('Error: either P1 or P2 does not have the proper size.\n');
    return;    
end
close all;

figure(1);
I3=[I1 I2];
imshow(I3);

hold on;
plot([P1(:,1); P2(:,1)+size(I1,2)],[P1(:,2); P2(:,2)],'*','MarkerSize',10);
line([P1(:,1) P2(:,1)+size(I1,2)]',[P1(:,2) P2(:,2)]');
hold off;

save('q4a.mat', 'P1', 'P2');