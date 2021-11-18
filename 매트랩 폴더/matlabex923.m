clear;
clc;

t = linspace(0, 2.5 ,100);
f = 1;
y = cos(2*pi*f*t);

figure(1)
plot(t,y);
grid on;

data = [t ; y ];
fid = fopen('sine_wave.txt','w');
fprintf(fid, '%f %f\n', data);
fclose(fid);
clear;

d = load('sine_wave.txt');

x = d(:,1);
y1 = d(:,2);
y2 = y1;

id = find(y1<0);
y2(id) = 0.5*y1(id);
id = find(y1>=0);
y2(id) = 2*y1(id);

figure(2)
plot(x, y1, x, y2, '-*');
grid on;
legend('original sine wave', 'multiplied sine wave');