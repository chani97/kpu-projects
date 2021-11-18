clc;
clear;

 x = linspace( 0, 2, 10000 ) ;
tau = 0.3 ;
y1 = zeros( 1, length(x)) ;
y1(find(abs(x - round(x)) <= tau)) = 1 ;

f = 5 ;
y = cos( 2*pi*f*x + pi*y1 ) ;
figure(1)
subplot(211)
plot( x, y1 ) ;
grid on ;
ylim([0 1.1]) ;
subplot(212)
plot( x, y ) ;
grid on ;