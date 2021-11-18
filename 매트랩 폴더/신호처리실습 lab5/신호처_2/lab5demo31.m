clc;
clear;

img = myfun_LoadImage('lena.raw', 256, 256);
fftimg = fft2(img);
ufftimg = uint8((1/256)*(abs(fftimg)));
ifftimg = ifft2(fftimg);
uifftimg = uint8(abs(ifftimg));
subplot(131)
imshow(img)
subplot(132)
imshow(ufftimg)
subplot(133)
imshow(uifftimg)