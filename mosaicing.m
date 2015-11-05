function Ip = mosaicing(I1,I2,H)

Ht = H;

[h1 w1 d1] = size(I1);
[h2 w2 d2] = size(I2);
TRF=maketform('projective',Ht);

[TI1 xdata ydata] = imtransform(I1, TRF);
[ht wt dt] = size(TI1);

minx = min(1, floor(xdata(1)));
maxx = max(w2, floor(xdata(2)));

miny = min(1, ceil(ydata(1)));
maxy = max(h2, ceil(ydata(2)));

wIp = maxx - minx + 1;
hIp = maxy - miny + 1;

[XI,YI] = meshgrid(minx:maxx, miny:maxy);

Ip = zeros(hIp, wIp, 3);
c2 = zeros(hIp, wIp, 3);
for channel=1:3,
    c2(:,:,channel) = interp2(double(I2(:,:,channel)), XI, YI);        
end
c1 = imtransform(double(I1), TRF, 'XData', [minx maxx], 'YData', [miny maxy], 'fillvalues', nan);

isnotnan_1and2 = find( (1-isnan(c1(:,:,1))).*(1-isnan(c2(:,:,1))) );
Ip(isnotnan_1and2) = 0.5*(c1(isnotnan_1and2) + c2(isnotnan_1and2));
Ip(isnotnan_1and2 + hIp*wIp) = 0.5*(c1(isnotnan_1and2 + hIp*wIp) + c2(isnotnan_1and2 + hIp*wIp));
Ip(isnotnan_1and2 + hIp*wIp*2) = 0.5*(c1(isnotnan_1and2 + hIp*wIp*2)  + c2(isnotnan_1and2 + hIp*wIp*2));

isnotnan_only1 = find( (1-isnan(c1(:,:,1))).*(isnan(c2(:,:,1))) );
Ip(isnotnan_only1) = c1(isnotnan_only1);
Ip(isnotnan_only1 + hIp*wIp) = c1(isnotnan_only1 + hIp*wIp);
Ip(isnotnan_only1 + hIp*wIp*2) = c1(isnotnan_only1 + hIp*wIp*2);

isnotnan_only2 = find( (isnan(c1(:,:,1))).*(1-isnan(c2(:,:,1))) );
Ip(isnotnan_only2) = c2(isnotnan_only2);
Ip(isnotnan_only2 + hIp*wIp) = c2(isnotnan_only2 + hIp*wIp);
Ip(isnotnan_only2 + hIp*wIp*2) = c2(isnotnan_only2 + hIp*wIp*2);

Ip = uint8(Ip);
