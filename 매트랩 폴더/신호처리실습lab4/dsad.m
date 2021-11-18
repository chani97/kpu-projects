clc;
clear;
n = 0:1:100;
f1 = 30;
f2 = 70;
fs = 100;
x = cos(2*pi*(f1/fs).*n) + cos(2*pi*(f2/fs).*n);
[f_hat, Xk, N_mult] = customFFT(x);

figure(1)
subplot(211)

stem(n,x)
subplot(212)
plot(n,x)
