clc;
clear;

zero = roots([1,5]); %zero 의 해
pole = roots([1,2,5]); % pole 의 해


[z,p,k] = residue([1,5],[1,2,5]); %부분분수, 해를 구함.
axis = linspace(0,10,100); %time - domain axis
invl = customINVL(z,p,axis);
freq_axis = linspace(-1.5*pi,1.5*pi,100); %freq-domain axis
resp = customFRL(zero,pole,freq_axis);

figure(1)
hold on
plot(real(zero), imag(zero), 'bo','MarkerSize', 15); % zero 는 o 형태로 표시
plot(real(pole), imag(pole), 'rx', 'MarkerSize', 15); %pole 은 x 형태로 표시
xlabel('Real')
ylabel('Imagine')
hold off
grid on

figure(2)
subplot(211)
plot(axis,invl)
xlabel('t[s]')
ylabel('h(t)')
subplot(212)
plot(freq_axis,abs(resp))
xlabel('Freq [rad/sec]')
ylabel('absolute of Frequency response')
ylim([0.5,1.5])

