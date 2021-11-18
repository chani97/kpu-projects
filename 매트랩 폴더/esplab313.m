clc;
clear;

n1 = linspace(0,15,16);
n2 = linspace(-5,5,11); %n1과 n2의 시작점,끝점 지정 후 간격을 1로 조절한다.

A = 1;
theta = 0;
f = 0.1;
x1 = A*cos(2*pi*f*n1+theta); %x1 신호인 cos파형과 n1길이인 배열을 생성.
x2 = n2 == 0; %조건문을 통해 n2가 0일 때 1의 출력을 갖는 임펄스 함수를 생성.
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

