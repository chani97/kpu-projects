clc;
clear;

z = roots([1,-0.3]);
p = roots([1,0.3,0.36,0.108]);
axis = linspace(0,20,21);
freq_axis = linspace(-1*pi,pi,500);
[zero, pole, k] = residue([1,-0.3],[1,0.3,0.36,0.108]);
invz = customINVZ(zero,pole,axis);
rspz = customFRZ(z,p,freq_axis);

figure(1)
subplot(211)
stem(axis,invz)
xlabel('n')
ylabel('h[n]')

subplot(212)
plot(freq_axis, abs(rspz))
xlim([-1*pi,pi])
ylim([0,2])
xlabel('Omega [rad/sec]')
ylabel('Absolute of H(omega)')

figure(2)
hold on
plot(exp(1i * freq_axis)) % 단위원을 그림, 극점이 단위원 내부인지 외부인지 판별하기 위함.
plot(real(z), imag(z), 'o', 'MarkerSize', 15); %영점의 위치
plot(real(p), imag(p), 'x', 'MarkerSize', 15); %극점의 위치
xlabel('real axis')
ylabel('imagine axis')
hold off
grid on