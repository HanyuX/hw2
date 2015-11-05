function G1=gaussn(G0,N);
% G1=gaussn(G0,N);
% Convolve image with NxN Gaussian kernel and trim borders.
%

% coefficients for separable N-tap filter:
g=diag(fliplr(pascal(N)))';
g=g/sum(g); 

m=min(size(G0));

if m~=1
   % convolve rows first, then columns with g:
   G1=conv2(conv2(G0,g,'s'),g','s');
else
   G1=conv2(G0,g,'s');
end

