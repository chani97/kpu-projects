clear;
clc;

n1 = linspace(0,15,16);
n2 = linspace(0,5,6);
A=1;
theta = 0;
f1 = 0.1;
x1 = A*cos(2*pi*f1*n1+theta);
x2 = (0.5).^n2;
%x1을 5만큼 shift 하는 역할
x3 = 0;
for i= 1:1:length(x1)
    if(i+5) > length(x1)
        x3(i) = 0;
    else
        x3(i) = x1(i+5);
    end
end

%x1*x2
[num1,result1] = customconv(n1,n2,x1,x2);

%5만큼 shift된 x1*x2 -> (x3*x2)
[num2, result2] = customconv(n1,n2,x3,x2);
result1
result2
figure(1)
subplot(311)
stem(n1, x1)
grid on;
subplot(312)
stem(n2,x2)
grid on;
subplot(313)
stem(num1,result1)
grid on;

figure(2)
subplot(311)
stem(n1,x3)
grid on;
subplot(312)
stem(n2, x2)
grid on;
subplot(313)
stem(num2,result2)
grid on;