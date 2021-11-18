clc;
clear;

n1 = linspace(0,15,16);
n2 = linspace(-5,5,11); %n1�� n2�� ������,���� ���� �� ������ 1�� �����Ѵ�.

A = 1;
theta = 0;
f1 = 0.1;
f2 = 0.05;
x1 = A*cos(2*pi*f1*n1+theta); %x1 ��ȣ�� cos������ ���ļ��� f1, n1������ �迭 ����.
x2 = A*cos(2*pi*f2*n2+theta); %x2 ��ȣ�� cos������ ���ļ��� f2, n2������ �迭 ����.
[num,result] = customconv(n1,n2,x1,x2);
result
subplot(311)
stem(n1,x1)
xlabel('n')
ylabel('x1[n]')
grid on
subplot(312)
stem(n2,x2)
xlabel('n')
ylabel('x2[n]')
grid on
subplot(313)
stem(num,result)
xlabel('n')
ylabel('y[n]')
grid on