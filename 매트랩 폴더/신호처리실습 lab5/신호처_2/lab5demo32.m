clc;
clear;

img = myfun_LoadImage('lena.raw', 256, 256);
dctimg = dct2(img);
udctimg = uint8(abs(dctimg));
idctimg = idct2(dctimg);
uidctimg = uint8(idctimg);

subplot(131)
imshow(img)
subplot(132)
imshow(udctimg);
subplot(133)
imshow(uidctimg);