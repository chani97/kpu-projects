function [f_hat, Xk, N_mult] = customFFT(x)
N_mult = 0; %곱셈 횟수 기록
xlen = length(x);
f_hat = linspace(-0.5,0.5-(1/xlen), xlen); %DFT와 동일.
Xk = zeros(1,xlen);
l = log2(xlen); %이진화 위한 변수

for k = 1:1:xlen-1 %매트랩 배열 index는 1부터 시작.
    bin(k,:) = dec2bin(k-1,l); %dec2bin -> 10진수를 2진수로 변환해주는 함수.
    flipbin = fliplr(bin); %bit 뒤집어 주기. FFT위한 x[n] 재배열.
    f = bin2dec(flipbin); %뒤집은 비트를 다시 10진수로 변환.
    W(k) = cos((2*pi*(k-1))/xlen) - 1i*sin((2*pi*(k-1))/xlen); %회전 인자에 대한 수식.
end
