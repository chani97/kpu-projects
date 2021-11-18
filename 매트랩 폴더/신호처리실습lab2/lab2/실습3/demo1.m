clc;
clear;

n = linspace(0,49,50);
f1 = 0.1;
x = cos(2*pi*f1*n);
[f_hat, Xk, N_mult] = customDFT(x);
N_mult      %°ö¼À È½¼ö Ãâ·Â¿ë (°ö¼Á È½¼ö´Â NÀÇ Á¦°ö)
figure(1)
subplot(211)
stem(n,x);
xlabel('n')
ylabel('x[n]')
subplot(212)
stem(f_hat,abs(Xk))
xlabel('frequency axis')
ylabel('absolute of X[k]')