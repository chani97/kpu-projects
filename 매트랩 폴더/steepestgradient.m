clc;
clear all;
close all;

figure(1)
[x1_plot,x2_plot] = meshgrid([-1:0.1:5],[-1:0.1:5]);
fx_plot = (x1_plot-2).^2 + 2.*(x2_plot-2).^2;
contour(x1_plot, x2_plot, fx_plot);
xlabel('x1');
ylabel('x2');
hold on;
colorbar;

iter=0;
tol = 10^(-6);
x = [0;0];
fx =(x(1)-2).^2 + 2.*(x(2)-2).^2;

Gf = [ 2*x(1) - 4, 4*x(2) - 8];
norm_Gf = norm(Gf);

figure(1)
plot( x(1), x(2), 'r*');
hold on;
grid on;

fprintf('iter     x1        x2         lGfl      f(x)\n')
fprintf('----  ---------  ---------  --------  ----------\n')
fprintf('%3i %12.6f %12.6f %12.6f %12.6f\n', iter, x(1), x(2),norm_Gf,fx)

while (norm_Gf > tol)
    
    iter = iter +1;
    ds = 0.0001;
    s_range = [0:ds:100];
    x_next = [x(1) - Gf(1).*s_range ; x(2) - Gf(2).*s_range];
    fx_next = (x_next(1,:)-2).^2 + 2.*(x_next(2,:)-2).^2;
    
    idx = find( fx_next == min(fx_next) );
    
    x_prev = x;
    
    x= [x_next(1,idx) ; x_next(2,idx)];
    fx = fx_next(idx);
    Gf = [ 2*x(1) - 4, 4*x(2) - 8];
    norm_Gf = norm(Gf);
    
    figure(1)
    plot(x(1),x(2),'r*');
    hold on;
    plot([x_prev(1),x(1)],[x_prev(2),x(2)], 'r-');
    hold on;
    
    fprintf('%3i %12.6f %12.6f %12.6f %12.6f\n', iter, x(1), x(2),norm_Gf,fx)
    
end