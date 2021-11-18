clc;
clear;

n1 = linspace(-5,5,11);
n2 = linspace(0,5,6); %n1과 n2의 시작점,끝점 지정 후 간격을 1로 조절한다.

A = 1;
theta = 0;
f1 = 0.05;
x1 = A*cos(2*pi*f1*n1+theta);   %x1 신호인 cos파형과 주파수가 f1, n1길이인 배열 생성.
x2 = [1,2,3,4,5,6];
[num1,result1] = customconv(n1,n2,x1,x2);   % x1*x2 진행
[num2,result2] = customconv(n2,n1,x2,x1);   % x2*x1 진행
result1
result2
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
hold on
stem(num1,result1,'blue', 'm-d')
stem(num2,result2,'red','-o')
xlabel('n')
ylabel('y[n]')
legend('x1*x2','x2*x1')
grid on
hold off
