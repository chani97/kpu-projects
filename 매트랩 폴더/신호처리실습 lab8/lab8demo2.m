clear
clc;

t = linspace(1500,5500,10000);
[a, b, c] = buttap(7);
[z, p] = zp2tf(a, b, c);

[bpz, bpp] = lp2bp(z, p, 3000*2*pi, 2000*2*pi); % 2*pi*f = w 주파수를 각속도로 맞춰주기 위함
[hpz, hpp] = lp2hp(z, p, 4000*2*pi);
[dbpz, dbpp] = bilinear(bpz, bpp, 50000);   %bpf discretization
[dhpz, dhpp] = bilinear(hpz, hpp, 50000);   %hpf discretization

bpresp = freqs(bpz, bpp, t*2*pi);   %bpf frequency responce (analog)
dbpresp = freqz(dbpz, dbpp, t*2*pi./50000); %bpf frequency responce (digital)
hpresp = freqs(hpz, hpp, t*2*pi); %hpf frequency responce (analog)
dhpresp = freqz(dhpz, dhpp, t*2*pi./50000); %hpf frequency responce (digital)

figure(1)
hold on
grid on
plot(t, abs(dbpresp))
plot(t, abs(bpresp))
plot(t, abs(hpresp)) 
plot(t, abs(dhpresp))
hold off