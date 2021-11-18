function [xn, yn] = make_circle(x,y,r)
theta = linspace(0,2*pi,1000);
xn = r * cos(theta) + x;
yn = r * sin(theta) + y;