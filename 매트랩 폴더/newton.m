clc;
clear all;

x = 0;
fx = x^4 - 14*x^3 + 60*x^2 - 70*x;
dx = 4*x^3 - 42*x^2 + 120*x - 70;
ddx = 12*x^2 - 84*x +120;
k = 0;

fprintf('k      x      fx     dx  ddxx  \n');
fprintf('%3i  %3.6f %3.6f %3.6f  \n',k, x, fx, dx, ddx);

while (dx/ddx~=0)
    k = k+1;
    x = x-(dx/ddx);
    fx = x^4 - 14*x^3 + 60*x^2 - 70*x;
    dx = 4*x^3 - 42*x^2 + 120*x - 70;
    ddx = 12*x^2 - 84*x +120;
    
    fprintf('%3i  %12.6f %12.6f %12.6f %12.6f  \n',k, x, fx, dx, ddx);
end