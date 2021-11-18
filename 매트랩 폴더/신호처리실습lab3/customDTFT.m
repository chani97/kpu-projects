function [f_hat, Xk, N_mult] = customDTFT(x)
N = 1024;
x_len = length(x);
f_hat = linspace(-0.5,0.5-(1/N), N);
Xk = zeros(1,N);
N_mult = 0;

for k = 1:N         % 1024개 값 생성
    for n= 1:x_len
         dtftx(n) = x(n)*exp(-1i*2*pi*((k-1)/N)*n);
       N_mult=N_mult+1; 
    end
     if(N/2 + k <= N)        
        Xk(N/2 + k)  = sum(dtftx);
    else
        Xk(-N/2 + k) = sum(dtftx);      
     end
end