clc;
clear;

n1 = linspace(-5,5,11);
n2 = linspace(-5,5,11); %n1,n2 시작점 -5, 끝점 5, 11칸으로 나눠 간격 1로 조절.

x1 = [0,0,0,0,0,1,1,1,0,0,0];
x2 = [0,0,0,1,1,1,1,1,0,0,0]; %x1,x2 신호입력.
[num, result] = customconv(n1,n2,x1,x2);
result
subplot(311)
stem(n1,x1)
xlabel('n');
ylabel('x1[n]')
grid on
subplot(312)
stem(n2,x2)
xlabel('n');
ylabel('x2[n]')
grid on
subplot(313)
stem(num,result)
xlabel('n');
ylabel('y[n]')
grid on
