clc;
clear all;
close all;

V=[1:0.5:5];
sigma=1;

X_num=10^7;


for k=1:length(V)
    
    X=zeros(1,X_num);
    
    
    
    data_gen=rand(1,X_num);
    indexa=find(data_gen<0.5);
    indexb=find(data_gen>=0.5);
    
    X(indexa)=-V(k);
    X(indexb)=V(k);
    
    N=sigma.*randn(1,X_num);
    
    rcv=X+N;
    
    
    
    
    
    error_num=0;
    estimate=zeros(1,X_num);
    
    
    
    
    indexc=find(rcv<0);
    indexd=find(rcv>=0);
    estimate(indexc)=-V(k);
    estimate(indexd)=V(k);
    
    error_num=sum(estimate~=X);
    
    
 
    error_prob(k)=error_num/X_num;
    
end


V_theo=[1:0.01:5];
theo_err_prob = (1/2).*erfc(V_theo/(sqrt(2)*sigma));


figure(1)
semilogy(V_theo,theo_err_prob,'b-');hold on;
semilogy(V,error_prob,'ro');
grid on;
title('Error Probability');
ylabel('P_e');
xlabel('V(voltage)');
legend('Theory','Simulation');



