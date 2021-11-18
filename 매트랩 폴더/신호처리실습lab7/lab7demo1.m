clc;
clear;
close all;
[z1,p1,k] = buttap(5); %z1 zero, p1 pole
circle = linspace(-pi, pi, 500);
t_axis = linspace(0,2,500); %time_axis
[zf1, pf1] = zp2tf(z1,p1,k); %전달함수 만들기. freq_response
f_resp1 = freqs(zf1,pf1,t_axis); %
butterdb = 10 * log10(abs(f_resp1).^2);

[z2,p2,k] = cheb1ap(5, 10); %z1 zero, p1 pole
[zf2, pf2] = zp2tf(z2,p2,k); %전달함수 만들기. freq_response
f_resp2 = freqs(zf2,pf2,t_axis); %
cheb1db = 10 * log10(abs(f_resp2).^2);

[z3,p3,k] = cheb2ap(5, 30); %z1 zero, p1 pole
[zf3, pf3] = zp2tf(z3,p3,k); %전달함수 만들기. freq_response
f_resp3 = freqs(zf3,pf3,t_axis); %
cheb2db = 10 * log10(abs(f_resp3).^2);

[z4,p4,k] = ellipap(5,10,30); %z1 zero, p1 pole
[zf4, pf4] = zp2tf(z4,p4,k); %전달함수 만들기. freq_response
f_resp4 = freqs(zf4,pf4,t_axis); %
elldb = 10 * log10(abs(f_resp4).^2);

figure(1)       % figure 1 == butterworth
subplot(221)
hold on
plot(exp(1i * circle))
plot(real(z1),imag(z1), 'o', 'MarkerSize', 15) %zero plot
plot(real(p1),imag(p1), 'x', 'MarkerSize', 15) %pole plot
xlabel('Real')
ylabel('Imagine')
hold off
grid on
subplot(222)
plot(t_axis, butterdb)
xlabel('w[rad/sec]')
ylabel('[dB]')
grid on

figure(2)       % figure 2 == chebyshev - 1
subplot(221)
hold on
plot(exp(1i * circle))
plot(real(z2),imag(z2), 'o', 'MarkerSize', 15) %zero plot
plot(real(p2),imag(p2), 'x', 'MarkerSize', 15) %pole plot
xlabel('Real')
ylabel('Imagine')
hold off
grid on
subplot(222)
plot(t_axis, cheb1db)
xlabel('w[rad/sec]')
ylabel('[dB]')
grid on

figure(3)       % figure 3 == chebyshev - 2
subplot(221)
hold on
plot(exp(1i * circle))
plot(real(z3),imag(z3), 'o', 'MarkerSize', 15) %zero plot
plot(real(p3),imag(p3), 'x', 'MarkerSize', 15) %pole plot
xlabel('Real')
ylabel('Imagine')
hold off
grid on
subplot(222)
plot(t_axis, cheb2db)
xlabel('w[rad/sec]')
ylabel('[dB]')
grid on

figure(4)       % figure 3 == elliptic
subplot(221)
hold on
plot(exp(1i * circle))
plot(real(z4),imag(z4), 'o', 'MarkerSize', 15) %zero plot
plot(real(p4),imag(p4), 'x', 'MarkerSize', 15) %pole plot
xlabel('Real')
ylabel('Imagine')
hold off
grid on
subplot(222)
plot(t_axis, elldb)
xlabel('w[rad/sec]')
ylabel('[dB]')
grid on

