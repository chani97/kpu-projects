clear;
clc;

t1 = -5;
t2 = 5;
N = 4096;
f_s = 20;
tau = 20 * pi;
[impulse_t, impulse_p] = custompulse(t1, t2, N, f_s);
t = impulse_t;
x_t = tau * sinc((tau * t)/(2 * pi)); %싱크 펑션 생성
y_in = prod([x_t; impulse_p]); % 샘플링 진행
%prod 함수 이용하여 곱셈 연산 진행

%cutoff 주파수가 fc인 5차 버터워스 필터 코드
fc=8;
[z, p, k] = buttap(5);
[num, den] = zp2tf(z,p,k);
[num, den] = lp2lp(num, den, 2*pi*fc);
[num_d, den_d] = bilinear(num, den, 1/abs(t(2)-t(1)));

y_out = filter(num_d, den_d, y_in);


%myfun_SA 적용 스펙트럼 구하기.
[f0, X0] = myfun_SA(impulse_t, impulse_p);
X0 = abs(X0);
[f1, X1] = myfun_SA(t, y_in);
X1 = abs(X1);
[f2, X2] = myfun_SA(t, y_out);
X2 = abs(X2);

figure (1)  
subplot(221)
  plot(t, y_in)
  xlabel('t[sec]')
  ylabel('Before reconstruction y(t)')
  xlim([-1,1])
  grid on
  subplot(222)
  plot(t, y_out)
  xlabel('t[sec]')
  ylabel('After reconstruction y(f)')
  xlim([-1,1])
  grid on
subplot(223)
  plot(f1, X1)
  xlabel('f[Hz]')
  ylabel('Before reconstruction |Y(f)|')
  xlim([-30,30])
  grid on
subplot(224)
  plot(f2, X2)
  xlabel('1[Hz]')
  ylabel('After reconstruction |Y(f)|')
  xlim([-30,30])
  grid on