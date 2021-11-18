clc;
clear;

t1 = -5;
t2 = 5;
N = 4096;
fs = 20;
[t, pt] = custompulse(t1,t2,N,fs); % 임펄스열 생성 -- 3.1
[ft, fpt] = myfun_SA(t,pt);

figure(1)
subplot(211)
plot(t,pt)
xlabel('t[sec]')
ylabel('p(t)')
grid on

subplot(212)
plot(ft,abs(fpt))
xlabel('f[Hz]')
ylabel('|p(t)|')
grid on