clc;
clear;

k = [1:6];
thpmf = 1/6*ones(1,length(k));
thcdf = cumsum(thpmf);

thavg = 1/6*sum(k)
thvar = 1/6*sum((k-thavg).^2)

count = [];
samnum = 100000;
urand = rand(samnum , 1);

idx = (urand < thcdf(1));
count(1) = sum(idx);

for lp = 1:length(thcdf)-1
    idx = (urand >= thcdf(lp)) & (urand < thcdf(lp+1));
    count(lp+1) = sum(idx);
end;

empmf = count./samnum;
emcdf = cumsum(empmf);
emavg = sum(k.*empmf)
emvar = sum((k-emavg).^2.*empmf)

figure(1)

subplot(2,1,1)
stem(k,empmf,'b*'); hold on;
stem(k,thpmf,'ro');
legend('empiricla pmf' , 'theoretical pmf');
grid on;
title('pmf');
xlabel('k');
ylabel('P[X=K]');

subplot(2,1,2)
stem(k , emcdf , 'b*'); hold on;
stem(k ,thcdf , 'ro');
legend('empirical cdf' , 'theroretical cdf' , 'location' , 'northwest');
grid on;
title('cdf');
xlabel('k');
ylabel('P[X<=k]');

