clc;
clear;

t = linspace(0,49,50);

sq_wave50 = t >= 0;
[f_hat50, Xk50, N_mult50] = customDFT(sq_wave50);
[tf_hat50, tXk50, tN_mult50] = customDTFT(sq_wave50);

sq_wave30 = t < 30;
[f_hat30, Xk30, N_mult30] = customDFT(sq_wave30);
[tf_hat30, tXk30, tN_mult30] = customDTFT(sq_wave30);

sq_wave10 = t < 10;
[f_hat10, Xk10, N_mult10] = customDFT(sq_wave10);
[tf_hat10, tXk10, tN_mult10] = customDTFT(sq_wave10);

sq_wave1 = t < 1;
[f_hat1, Xk1, N_mult1] = customDFT(sq_wave1);
[tf_hat1, tXk1, tN_mult1] = customDTFT(sq_wave1);


subplot(421)
stem(t,sq_wave50)
xlabel('time axis')
ylabel('x[n]')

subplot(422)
hold on
plot(tf_hat50, abs(tXk50))
stem(f_hat50, abs(Xk50))
xlabel('frequency axis')
ylabel('absolute of Xk')
legend('DTFT', 'DFT')
hold off

subplot(423)
stem(t,sq_wave30)
xlabel('time axis')
ylabel('x[n]')

subplot(424)
hold on
plot(tf_hat30, abs(tXk30))
stem(f_hat30, abs(Xk30))
xlabel('frequency axis')
ylabel('absolute of Xk')
legend('DTFT', 'DFT')
hold off

subplot(425)
stem(t,sq_wave10)
xlabel('time axis')
ylabel('x[n]')

subplot(426)
hold on
plot(tf_hat10, abs(tXk10))
stem(f_hat10, abs(Xk10))
xlabel('frequency axis')
ylabel('absolute of Xk')
legend('DTFT', 'DFT')
hold off
subplot(427)
stem(t,sq_wave1)
xlabel('time axis')
ylabel('x[n]')

subplot(428)
hold on
plot(tf_hat1, abs(tXk1))
stem(f_hat1, abs(Xk1))
xlabel('frequency axis')
ylabel('absolute of Xk')
legend('DTFT', 'DFT')
hold off