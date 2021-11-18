clc;
clear;

n = linspace(0,49,50);
f1 = 0.1;
f2 = 0.2;
f3 = 0.3;

x1 = cos(2*pi*f1*n);
x2 = 0.5*cos(2*pi*f2*n);
x3 = 0.1*cos(2*pi*f3*n);
xn = x1+x2+x3;
[f_hat, Xk, N_mult] = customDFT(xn);


figure(1)
subplot(211)
stem(n,xn)
xlabel('n')
ylabel('x[n]')
subplot(212)
stem(f_hat, abs(Xk))
xlabel('frequency axis')
ylabel('absolute of X[k]')
