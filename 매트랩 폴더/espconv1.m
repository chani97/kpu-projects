clc;
clear;

x1 = input('ù��° ��ȣ �Է�: ');
x1min = input('ù��° ��ȣ�� �ּ� n�� �Է�: ');
x1max = input('ù��° ��ȣ�� �ִ� n�� �Է�: ');
x2 = input('�ι�° ��ȣ �Է�: ');
x2min = input('�ι�° ��ȣ�� �ּ� n�� �Է�: ');
x2max = input('�ι�° ��ȣ�� �ִ� n�� �Է�: ');

ymin = x1min + x2min;
ymax = x1max + x2max;
ylen = length(x1)+length(x2)-1;
yn = linspace(ymin,ymax,ylen);

X1 = [x1,zeros(1,length(x2))];
X2 = [x2,zeros(1,length(x1))];

for i = 1:length(x1)+length(x2)-1
    Y(i) = 0;
    X2S = [zeros(1,i),x2, zeros(1,length(X1)-i)];
    for j = 1:length(x2)
        if((i-j+1)>0)
            flipX2 = fliplr(X2S);
            X1X2 = [X1;flipX2];
            prodX = prod(X1X2);
            Y(i) = sum(prodX);
        else
        end
    end
end

plot(1)
disp(Y)
stem(ylen,Y)
xlabel('n')
ylabel('y(n)')
title('���')
grid on;

        
