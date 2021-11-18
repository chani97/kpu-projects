clear;
clc;

n1 = linspace(0,15,16);
n2 = linspace(0,5,6);
n3 = linspace(0,10,11);
A=1;
theta = 0;
f1 = 0.1;
f2 = 0.05;
x1 = A*cos(2*pi*f1*n1+theta);
x2 = A*cos(2*pi*f2*n2+theta);
x3 = (-1).^n3;
%(x1*x2)*x3 과정
[num1,result1] = customconv(n1,n2,x1,x2);
[num2,result2] = customconv(num1,n3,result1,x3);

%x1*(x2*x3) 과정
[num3, result3] = customconv(n2,n3,x2,x3);
[num4, result4] = customconv(n1,num3,x1,result3);
result2
result4
figure(1)
subplot(311)
stem(n1, x1)
grid on;
subplot(312)
stem(n2,x2)
grid on;
subplot(313)
stem(n3,x3)
grid on;

figure(2)
hold on
stem(num2,result2,'blue','m-d')
stem(num4, result4,'red', '-o')
grid on;
hold off