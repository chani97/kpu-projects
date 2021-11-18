clear;
clc;

n = 0:1:499;
f = 0:1:599;
f1 = 100;
f2 = 500;
fs = 3000;
x = cos(2*pi*(f1/fs).*n) + cos(2*pi*(f2/fs).*n);
[freq1, X1] = myfun_SA(n./fs, x);

[a, b, c] = buttap(7);
[z, p] = zp2tf(a, b, c); %zero-pole to transfer function
[lpz, lpp] = lp2lp(z, p, 300*2*pi); %changing cutoff freqency
[dlpz, dlpp] = bilinear(lpz, lpp, fs); %discretize low pass filter
y = filter(dlpz, dlpp, x);  %output of digital system
resp = freqz(dlpz, dlpp, f*2*pi/fs); %frequency response of digital lpf

[freq2, X2] = myfun_SA(n./fs, y); %./fs 하여 시간축으로 들어가게끔 함.

figure(1)
subplot(3,2,1); %output of x(t)
    plot(n./fs, x); %x축에 ./fs 하는 이유, x축은 시간축 (t[sec])
    xlim([0 0.1]);
subplot(3,2,2);
    stem(freq1, abs(X1));
    xlim([0 600]);
subplot(3,2,4);
    plot(f,abs(resp));
subplot(3,2,5);
    plot(n./fs, y); %x축에 ./fs 하는 이유, x축은 시간축 (t[sec])
    xlim([0 0.1]);
subplot(3,2,6);
    stem(freq2, abs(X2));
    xlim([0 600]);