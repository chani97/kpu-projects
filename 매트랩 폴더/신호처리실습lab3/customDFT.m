function [f_hat , Xk, N_mult] = customDFT(x)
x_len = length(x);         %��ȣ x �� ����
nk = 0:1:(x_len-1);   %dft ���Ŀ��� k�� n�� �� ���� - 0���� ���� �ʿ�.
Xk = zeros(1,x_len);
f_hat = linspace(-0.5,0.5-(1/x_len),x_len);
N_mult = 0;

for k=1 : x_len
    for n=1:x_len
    dftx(n) = x(n)*exp(-1i*2*pi*(nk(k)/x_len)*nk(n)); %DFT ���� �״�� ����
    N_mult=N_mult+1; %���� Ƚ�� ���
    end
    %���ļ� �������� Xk�� ����ִ� �ڵ� (��� ��Ʈ)
    %�ڵ尡 ���� �� �ε����� �������� �����Ƿ� �ٽ� �����´�.
    if(x_len/2 + k <= x_len)        
        Xk(x_len/2 + k)  = sum(dftx);
    else
        Xk(-x_len/2 + k) = sum(dftx);       %������Ʈ
    end
end