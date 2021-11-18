clc;
clear;
z1 = -5;
p1 = [-1+2i, -1-2i];
z2 = -5;
p2 = [2i,-2i];
z3 = -5;
p3 = [1+2i,1-2i]; %zero, pole 3개씩 지정.
axis = linspace(0,10,100);

[tfz1, tfp1] = zp2tf(z1,p1,1); %전달함수 형태로 만들기. 상수 이득 없으므로 세번째 인자 1.
[tfz2, tfp2] = zp2tf(z2,p2,1);
[tfz3, tfp3] = zp2tf(z3,p3,1);

[zero1, pole1, k1] = residue(tfz1,tfp1);
[zero2, pole2, k2] = residue(tfz2,tfp2);
[zero3, pole3, k3] = residue(tfz3,tfp3); %부분분수 해 구하기. 분자는 zero, 분모는 pole에 해당.

s1 = customINVL(zero1,pole1,axis);
s2 = customINVL(zero2,pole2,axis);
s3 = customINVL(zero3,pole3,axis);

figure(1)
subplot(311)
plot(axis,s1)
xlabel('t[sec]')
ylabel('h(t) of System#1') %수렴

subplot(312)
plot(axis,s2)
xlabel('t[sec]')
ylabel('h(t) of System#2') %진동


subplot(313)
plot(axis,s3)
xlabel('t[sec]')
ylabel('h(t) of System#3') %발산



