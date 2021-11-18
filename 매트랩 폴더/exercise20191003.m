clc;
clear;

thpmf = [];
thcdf = [];

k = [0:1:20];
n = 20;
p = 0.2; %¼º°øÈ®·ü
a = n*p

for lp = 1:length(k)
    thpmf(lp) = ((a^k(lp))/factorial(k(lp)))*exp(-a)
end;

thcdf = cumsum(thpmf);

thavg = 1/p
thvar = (1-p)/(p^2)

count  = [];
samnum = 100000;
urand = rand(samnum, 1);

idx = (urand <= thcdf(1));
count(1)  = sum(idx);

for lp = 1:length(thcdf)-1
    idx = (urand >= thcdf(lp)) & (urand <= thcdf(lp+1));
    count(lp+1) = sum(idx);
end;

empmf = count./samnum;
emcdf = cumsum(empmf);
emavg = sum(k.*empmf)
emvar = sum((k-emavg).^2.*empmf)


figure(1)
subplot(2,1,1)
stem(k,empmf,'b*'); hold on;
stem(k,thpmf, 'ro');
legend('empirical pmf' , 'theoretical pmf');
grid on;
title('pmf');
xlabel('k');
ylabel('P[X+k]');

subplot(2,1,2)
stem(k , emcdf , 'b*'); hold on;
stem(k ,thcdf , 'ro');
legend('empirical cdf' , 'theroretical cdf' , 'location' , 'northwest');
grid on;
title('cdf');
xlabel('k');
ylabel('P[X<=k]');