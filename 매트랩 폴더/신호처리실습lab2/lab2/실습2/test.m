clc;
clear;

t1 = -5;
t2 = 5;
N = 4096;
fs = 15;
[t, pt] = custompulse(t1,t2,N,fs); % 임펄스열 생성 -- 3.1

[F, X] = myfun_SA(t,pt);    % 임펄스열의 크기 스펙트럼
X = abs(X);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
r = 20*pi;
xt = r*sinc((r*t)/(2*pi)); % 싱크함수 생성 -- 3.2

[Ft, Xt] = myfun_SA(t, xt); %xt의 크기 스펙트럼
Xt = abs(Xt);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
yt = prod([xt; pt]);    % 표본화 진행 -- 3.3

[Ft, Yt] = myfun_SA(t, yt); % 표본화된 신호의 크기 스펙트럼
Yt = abs(Yt); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(321) %321 = 임펄스열 (시간 축)
stem(t, pt);
xlim([-1 1]);
ylim([0 1.2]);
grid on;
subplot(322);   %322 = 임펄스열의 크기 스펙트럼
plot(F,X)
xlim([-30 30]);
ylim([0 0.5]);
grid on;
subplot(323)   %323 = 싱크 펑션 생성 (시간 축)
plot(t, xt);
xlim([-1 1]);
ylim([-20 80]);
grid on;
subplot(324);   % 싱크 펑션의 크기 스펙트럼
plot(Ft, Xt);
xlim([-30 30]);
ylim([0 8]);
grid on;
subplot(325);   % 싱크 펑션의 표본화 (시간 축)
plot(t, yt);
xlim([-1 1]);
ylim([-20 80]);
grid on;
subplot(326);   % 표본화된 싱크 펑션의 크기 스펙트럼
plot(Ft, Yt);
xlim([-30 30]);
grid on;