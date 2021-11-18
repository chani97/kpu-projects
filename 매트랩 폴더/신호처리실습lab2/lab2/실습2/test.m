clc;
clear;

t1 = -5;
t2 = 5;
N = 4096;
fs = 15;
[t, pt] = custompulse(t1,t2,N,fs); % ���޽��� ���� -- 3.1

[F, X] = myfun_SA(t,pt);    % ���޽����� ũ�� ����Ʈ��
X = abs(X);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
r = 20*pi;
xt = r*sinc((r*t)/(2*pi)); % ��ũ�Լ� ���� -- 3.2

[Ft, Xt] = myfun_SA(t, xt); %xt�� ũ�� ����Ʈ��
Xt = abs(Xt);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
yt = prod([xt; pt]);    % ǥ��ȭ ���� -- 3.3

[Ft, Yt] = myfun_SA(t, yt); % ǥ��ȭ�� ��ȣ�� ũ�� ����Ʈ��
Yt = abs(Yt); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(321) %321 = ���޽��� (�ð� ��)
stem(t, pt);
xlim([-1 1]);
ylim([0 1.2]);
grid on;
subplot(322);   %322 = ���޽����� ũ�� ����Ʈ��
plot(F,X)
xlim([-30 30]);
ylim([0 0.5]);
grid on;
subplot(323)   %323 = ��ũ ��� ���� (�ð� ��)
plot(t, xt);
xlim([-1 1]);
ylim([-20 80]);
grid on;
subplot(324);   % ��ũ ����� ũ�� ����Ʈ��
plot(Ft, Xt);
xlim([-30 30]);
ylim([0 8]);
grid on;
subplot(325);   % ��ũ ����� ǥ��ȭ (�ð� ��)
plot(t, yt);
xlim([-1 1]);
ylim([-20 80]);
grid on;
subplot(326);   % ǥ��ȭ�� ��ũ ����� ũ�� ����Ʈ��
plot(Ft, Yt);
xlim([-30 30]);
grid on;