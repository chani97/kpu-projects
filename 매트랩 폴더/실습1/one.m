clear;
clc;

n1 = linspace(0,15,16);
n2 = linspace(0,5,6);
A=1;
B = 0;
f1 = 0.1;
f2 = 0.05;
x1 = A*cos(2*pi*f1*n1+B);
x2 = (0.5).^n2;
%(x1*x2)*x3 과정
[num1,result1] = customconv(n1,n2,x1,x2);
[num2,result2] = customconv(num1,n3,result1,x3);

%x1*(x2*x3) 과정
[num3, result3] = customconv(n2,n3,x2,x3);
[num4, result4] = customconv(n1,num3,x1,result3);

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
subplot(211)
stem(num2,result2)
grid on;
subplot(212)
stem(num4, result4)
grid on;