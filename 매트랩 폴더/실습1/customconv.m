function [num,result] = customconv(n1,n2,x1,x2)

n3 = n1(1) + n2(1); 
%x1 ��ȣ�� x2 ��ȣ�� ���� �ð��� ����.
%(convolution �� ��ȣ�� ���� �ð�)

n4 = n1(length(n1)) + n2(length(n2));
%convolution �� ��ȣ�� ���̸� �ǹ�

num = linspace(n3,n4,n4-n3+1);
% x���� �����ϴ� linspace (1����)

X1 = [x1, zeros(1,length(x2))];
% �Ʒ��� �ڵ忡�� ����� ���� �� ������ �����ֱ� ���� 
% x1��ȣ�� �߰������� x2���̸�ŭ zero padding ��.

%X2 = (x2, zeros(1.length(x1)));


for i = 1:1:length(x1) %x1�� ���̸�ŭ �ڿ������� convolution �ݺ�����
    fX2 = fliplr(x2);
    RfX2 = [zeros(1,length(x1)-i),fX2,zeros(1,i)]; %zeros�Լ��� ���� �������� x2 ��ȣ shift ����
    X1X2 = [X1; RfX2];
    prodx = prod(X1X2);
    sumx = sum(prodx);
    y(1,i) = sumx; %y �迭�� convolution ��� ����

end

for j = 1:1:length(x2)-1 %shift�����ִ� x2�� ��ȣ�� �߸��� �������� �����ϴ� for��
    TfX2 = fliplr(x2);
    TRfX2 = [TfX2(1,1+j:end),zeros(1,length(x1)+j)]; %������ x2�� ��ȣ�� �߸��� �ϸ鼭 shift ����
    TX1X2 = [X1; TRfX2];
    Tprodx = prod(TX1X2);
    Tsumx = sum(Tprodx);
    y(length(x1)+j) = Tsumx; %���� for������ �Էµ� y �ٷ� ���� �迭���� convolution ��� ����

end
result = fliplr(y); 
%�ڿ������� convolution�� �����Ͽ� ����� �����Ǿ� �ٽ� ������� ������Ű�� ����� return�Ѵ�. 