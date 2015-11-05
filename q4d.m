%  Size-checking
I1 = imread('church1.jpg');
I2 = imread('church2.jpg');
P1 = 50+round(100*rand(5,2));
P2 = 50+round(100*rand(5,2));
w = 7;

f = 0;
try
    [F1, F2] = ExtractPatches(P1, P2, I1, I2, w);
    if ~((size(F1,1) == 5) && (size(F1,2) == 49) ...
        && (size(F2,1) == 5) && (size(F2,2) == 49))
        fprintf(1, 'Function ExtractPatches failed output parameter size check. \n');
        f = f+1;
    else
       fprintf(1, 'ExtractPatches successfully passed size tests \n');
    end
catch ME
    fprintf(1, 'Cannot execute function ExtractPatches.\n');
    f = f+1;
end

F1 = round(255*rand(5,49));
F2 = round(255*rand(5,49));
thresh = 2.5*w^2;
try
    [D, i, j] = EstablishCorrespondences(F1, F2, thresh);
    if ~((size(D,1) == 5) && (size(D,2) == 5) ...
        && (size(i,1) == size(j,1)))
        fprintf(1, 'Function EstablishCorrespondences failed output parameter size check. \n');
        f = f+1;
    else
       fprintf(1, 'EstablishCorrespondences successfully passed size tests \n');
    end
catch ME
    fprintf(1, 'Cannot execute function EstablishCorrespondences.\n');
    f = f+1;
end

if f > 0
    fprintf(1, 'Checking q4d did not pass. Not executing this script file q4d.m\n');
    return
end
clear;
% End of size-checking


w = 15;
thresh = 2.5*w^2;

I1 = imread('church1.jpg');
I2 = imread('church2.jpg');

if ~exist('q4a.mat', 'file'),
    fprintf('File q4a.mat does not exists. You must run q4a.m before this script.....\n');
    return;    
else       
    load('q4a.mat', 'P1', 'P2');
end

[F1, F2] = ExtractPatches(P1, P2, I1, I2, w);

[D, i, j] = EstablishCorrespondences(F1, F2, thresh);

close all;

figure(1);
I3=[I1 I2];
imshow(I3);

hold on;
plot([P1(:,1); P2(:,1)+size(I1,2)],[P1(:,2); P2(:,2)],'*','MarkerSize',10);
line([P1(i,1) P2(j,1)+size(I1,2)]',[P1(i,2) P2(j,2)]');
hold off;

