clc;
clear;

n1 = linspace(0,15,16);
n2 = linspace(-5,5,11); %n1�� n2�� ������,���� ���� �� ������ 1�� �����Ѵ�.

A = 1;
theta = 0;
f = 0.1;
x1 = A*cos(2*pi*f*n1+theta); %x1 ��ȣ�� cos������ n1������ �迭�� ����.
x2 = n2 == 0; %���ǹ��� ���� n2�� 0�� �� 1�� ����� ���� ���޽� �Լ��� ����.
[num,result] = customconv(n1,n2,x1,x2);
x1
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

