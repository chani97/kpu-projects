clc;
clear;
close all;

n = (log10(10000-1)/(2*log10(2)));  %n 구하기
N = ceil(n);    %최소차수 N
[z,p,k] = buttap(N);    %N차 버터워스필터
circle = linspace(-pi, pi, 500);
t_axis = linspace(0,2,500);
[zf,pf] = zp2tf(z,p,k);
f_resp = freqs(zf,pf,t_axis);
dB = 10 * log10(abs(f_resp).^2);


hz_axis = linspace(0,5000,10000);
[lpz, lpp] = lp2lp(zf,pf,300); %low-pass -> low pass (cutoff freq = 300hz)
lp_resp = freqs(lpz,lpp,hz_axis);
lpdB = 10*log10(abs(lp_resp).^2);

%low pass -> band pass 
%center freq -> (1000 + 300) / 2  bandwidth -> 1000-300
[bpz, bpp] = lp2bp(zf,pf,650,700); 
bp_resp = freqs(bpz,bpp,hz_axis);
bpdB = 10 * log10(abs(bp_resp).^2);

%low pass -> band pass
%center freq -> (1000 + 2000) / 2 bandwidth -> 2000 - 1000
[bpz2, bpp2] = lp2bp(zf,pf,1500,1000); 
bp_resp2 = freqs(bpz2,bpp2,hz_axis);
bpdB2 = 10 * log10(abs(bp_resp2).^2);

%low pass -> band pass
%center freq -> (2000 + 4000) / 2 bandwidth -> 4000 - 2000
[bpz3, bpp3] = lp2bp(zf,pf,3000,2000); 
bp_resp3 = freqs(bpz3,bpp3,hz_axis);
bpdB3 = 10 * log10(abs(bp_resp3).^2);

%low pass -> high pass
[hpz, hpp] = lp2hp(zf,pf,4000); 
hp_resp = freqs(hpz,hpp,hz_axis);
hpdB = 10 * log10(abs(hp_resp).^2);

figure(1)
subplot(221)
hold on
plot(exp(1i*circle))
plot(real(z),imag(z), 'o', 'MarkerSize', 15)
plot(real(p),imag(p), 'x', 'MarkerSize', 15)
xlabel('Real')
ylabel('Imagine')
hold off
grid on

subplot(222)
plot(t_axis, dB)
xlabel('w[rad/sec]')
ylabel('[dB]')
grid on

figure(2)
hold on
plot(hz_axis, lpdB)
plot(hz_axis, bpdB)
plot(hz_axis, bpdB2)
plot(hz_axis, bpdB3)
plot(hz_axis, hpdB)
xlabel('[Hz]')
ylabel('[dB]')
legend('LPF', 'BPF1', 'BPF2', 'BPF3', 'HPF')
ylim([-30,10])
hold off
grid on