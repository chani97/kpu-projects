function [f_hat, Xk, N_mult] = customFFT(x)
N_mult = 0; %���� Ƚ�� ���
xlen = length(x);
f_hat = linspace(-0.5,0.5-(1/xlen), xlen); %DFT�� ����.
Xk = zeros(1,xlen);
l = log2(xlen); %����ȭ ���� ����

for k = 1:1:xlen-1 %��Ʈ�� �迭 index�� 1���� ����.
    bin(k,:) = dec2bin(k-1,l); %dec2bin -> 10������ 2������ ��ȯ���ִ� �Լ�.
    flipbin = fliplr(bin); %bit ������ �ֱ�. FFT���� x[n] ��迭.
    f = bin2dec(flipbin); %������ ��Ʈ�� �ٽ� 10������ ��ȯ.
    W(k) = cos((2*pi*(k-1))/xlen) - 1i*sin((2*pi*(k-1))/xlen); %ȸ�� ���ڿ� ���� ����.
end
