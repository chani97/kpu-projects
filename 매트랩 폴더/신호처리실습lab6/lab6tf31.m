clc;
clear;

zero = roots([1,5]); %zero �� ��
pole = roots([1,2,5]); % pole �� ��


[z,p,k] = residue([1,5],[1,2,5]); %�κкм�, �ظ� ����.
axis = linspace(0,10,100); %time - domain axis
invl = customINVL(z,p,axis);
freq_axis = linspace(-1.5*pi,1.5*pi,100); %freq-domain axis
resp = customFRL(zero,pole,freq_axis);

figure(1)
hold on
plot(real(zero), imag(zero), 'bo','MarkerSize', 15); % zero �� o ���·� ǥ��
plot(real(pole), imag(pole), 'rx', 'MarkerSize', 15); %pole �� x ���·� ǥ��
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

