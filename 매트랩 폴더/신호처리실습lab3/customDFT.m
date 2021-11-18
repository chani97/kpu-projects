function [f_hat , Xk, N_mult] = customDFT(x)
x_len = length(x);         %신호 x 의 길이
nk = 0:1:(x_len-1);   %dft 수식에서 k와 n이 될 변수 - 0부터 시작 필요.
Xk = zeros(1,x_len);
f_hat = linspace(-0.5,0.5-(1/x_len),x_len);
N_mult = 0;

for k=1 : x_len
    for n=1:x_len
    dftx(n) = x(n)*exp(-1i*2*pi*(nk(k)/x_len)*nk(n)); %DFT 수식 그대로 적용
    N_mult=N_mult+1; %곱셈 횟수 기록
    end
    %주파수 영역으로 Xk를 집어넣는 코드 (양수 파트)
    %코드가 없을 때 인덱스가 뒤집혀서 나오므로 다시 뒤집는다.
    if(x_len/2 + k <= x_len)        
        Xk(x_len/2 + k)  = sum(dftx);
    else
        Xk(-x_len/2 + k) = sum(dftx);       %음수파트
    end
end