clc;
clear;

theta=linspace(0,2*pi,1000);
x= 10*cos(theta)+5;
y= 10*sin(theta)+10;
plot(x,y,'r');
grid on;
title('exercise1');
xlabel('x');
ylabel('y');


