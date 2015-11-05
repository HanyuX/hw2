function [lambdamax,lambdamin,ori]=smme(I,N)
% [lambdamax,lambdamin,ori] = smme(I,N)
% Calculate the eigenvalues of the the second moment matrices for image I
%
% Inputs
% I: a grayscale image
% N: scalar value defining the size of the window used to calculate the smme matrix of each pixel
%
% Outputs
% lambdamax: 2D matrix containing the maximum eigenvalues
% lambdamin: 2D matrix containing the minimum eigenvalues
% ori: 2D matrix containing the orientations of the eigenvectors associated to the maximum eigenvalues

[Gx,Gy]=gradient(I);

GGTxx=Gx.^2;
GGTxy=Gx.*Gy;
GGTyy=Gy.^2;

Txx=gaussn(GGTxx,N);
Txy=gaussn(GGTxy,N);
Tyy=gaussn(GGTyy,N);

V1=0.5*sqrt((Txx+Tyy).^2-4*(Txx.*Tyy-Txy.^2));

lambdamax=0.5*(Txx+Tyy)+V1;
lambdamin=0.5*(Txx+Tyy)-V1;

ori = atan2( Txx-lambdamax, -Txy );
