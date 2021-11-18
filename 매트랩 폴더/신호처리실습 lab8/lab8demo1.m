clc;
clear;
close all;

z1 = roots(1);
p1 = roots([1,2,2,1]);
circle = linspace(-pi, pi, 500);
t_axis = linspace(0,2,500);
resp1 = freqs(1,[1,2,2,1],t_axis);


[numd, dend] = bilinear(1,[1,2,2,1],5);
[z2, p2, k] = tf2zp(numd, dend);
resp2 = freqz(numd,dend,t_axis/5);

[numd2, dend2] = bilinear(1,[1,2,2,1],10);
[z3, p3, k2] = tf2zp(numd2, dend2);
resp3 = freqz(numd2,dend2,t_axis/10);

l1 = [1, zeros(1,49)];
l2 = [1, zeros(1,99)];
l3 = [1, zeros(1,149)];
i_resp1 = filter(numd2,dend2, l1);
i_resp2 = filter(numd2,dend2, l2);
i_resp3 = filter(numd2,dend2, l3);

figure(1) %pole-zero plot of analog, digital system
subplot(221) %모든 pole이 좌평면에 위치, 안정
hold on
plot(real(z1), imag(z1), 'o', 'MarkerSize', 15)
plot(real(p1), imag(p1), 'x', 'MarkerSize', 15)
plot(exp(1i*circle))
xlabel('Real')
ylabel('Imagine')
grid on
hold off

subplot(223) %223,224는 digital system, 모든 pole 이 단위원 내에 위치, 안정
hold on
plot(real(z2), imag(z2), 'o', 'MarkerSize', 15)
plot(real(p2), imag(p2), 'x', 'MarkerSize', 15)
plot(exp(1i*circle))
xlabel('Real')
ylabel('Imagine')
grid on
hold off

subplot(224)
hold on
plot(real(z3), imag(z3), 'o', 'MarkerSize', 15)
plot(real(p3), imag(p3), 'x', 'MarkerSize', 15)
plot(exp(1i*circle))
xlabel('Real')
ylabel('Imagine')
grid on
hold off

figure(2) %frequency response of analog, digital system
hold on
plot(t_axis, abs(resp1))
plot(t_axis, abs(resp2))
plot(t_axis, abs(resp3))
legend('butter', 'discretized, 5Hz', 'discretized, 10Hz')
grid on
hold off

figure(3) %output of digital system
subplot(311)
stem(i_resp1)
grid on
subplot(312)
stem(i_resp2)
grid on
subplot(313)
stem(i_resp3)
grid on

