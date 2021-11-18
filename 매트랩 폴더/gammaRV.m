clc;
clear all;

a = 1;
b = 6;

samnum = 100000;
X = (b-a)*rand(samnum,1) + a;

binnum = 100;
[counts, bin_centers] = hist(X,binnum);
dx = bin_centers(2)-bin_centers(1);

empdf = counts./samnum./dx;
emcdf = cumsum(empdf.*dx);

emavg = sum(bin_centers.*empdf.*dx)
emvar = sum((bin_centers - emavg).^2.*empdf.*dx)

thpdf = 1/(b-a).*ones(1,length(bin_centers));
thcdf = (bin_centers - a)./(b-a);

thavg = (a*b)/2
thvar = (b-a)^2/12

figure(1)
subplot(2,1,1)
bar(bin_centers, empdf, 'b'); hold on;
plot(bin_centers, thpdf, 'r-', 'Linewidth' , 2);
legend('Empirical PDF','Theoretical PDF','Location','Northwest');
grid on;
xlabel('x');
ylabel('PDF');

subplot(2,1,2)
bar(bin_centers, emcdf, 'b'); hold on;
plot(bin_centers, thcdf, 'r-', 'Linewidth' , 2);
legend('Empirical CDF','Theoretical CDF','Location','Northwest');
grid on;
xlabel('x');
ylabel('CDF');