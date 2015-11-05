function Enms = nonmaxsuppression(Es, En)
%
% Performs non-maximum suppression on the edge strength map along the edge
% normal directions encoded in En.
% 
% INPUT
%  Es:     [M x N] Edge strength map. Is 0 at non-edge pixels (thus
%                  it is zero also at corner points)
%  En:     [M x N] Edge normal directions (as angles in [0, pi]). Is 0 at non-edge pixels (thus
%                  it is zero also at corner points)
%
% OUTPUT
%  Enms:   [M x N] Edge strength map after non-maximum suppression along
%                  the edge normal direction
%move = [1, 1, 0, -1 ; 0, 1 ,1 , 1];
move = [0, 1, 1, -1 ; 1, 1 , 0, 1];
EsP = zeros(size(Es,1)+2,size(Es,2)+2);
EsP(2:size(Es,1)+1 , 2:size(Es,2)+1) = Es;
Enms = Es;
for i = 2:size(Es,1)+1,
    for j = 2:size(Es,2)+1,
        Index = angleIndex(En(i-1,j-1));
        if(EsP(i,j) < EsP(i + move(1,Index), j + move(2,Index)) || EsP(i,j) < EsP(i - move(1,Index), j - move(2, Index)))
            Enms(i-1,j-1) = 0;            
        end;
    end
end

function Index = angleIndex(angle)
    if(angle < pi/8 || angle > 7*pi/8)
        Index = 1;
    elseif(angle >= pi/8 && angle < 3*pi/8)
        Index = 2;
    elseif(angle >= 3*pi/8 && angle < 5*pi/8)
        Index = 3;
    else
        Index = 4;
    end
end
end