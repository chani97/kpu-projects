function [num,result] = customconv(n1,n2,x1,x2)

n3 = n1(1) + n2(1); 
%x1 신호와 x2 신호의 시작 시간을 더함.
%(convolution 된 신호의 시작 시간)

n4 = n1(length(n1)) + n2(length(n2));
%convolution 된 신호의 길이를 의미

num = linspace(n3,n4,n4-n3+1);
% x축을 지정하는 linspace (1단위)

X1 = [x1, zeros(1,length(x2))];
% 아래의 코드에서 행렬을 합할 때 차원을 맞춰주기 위해 
% x1신호에 추가적으로 x2길이만큼 zero padding 함.

%X2 = (x2, zeros(1.length(x1)));


for i = 1:1:length(x1) %x1의 길이만큼 뒤에서부터 convolution 반복해줌
    fX2 = fliplr(x2);
    RfX2 = [zeros(1,length(x1)-i),fX2,zeros(1,i)]; %zeros함수를 통해 왼쪽으로 x2 신호 shift 구현
    X1X2 = [X1; RfX2];
    prodx = prod(X1X2);
    sumx = sum(prodx);
    y(1,i) = sumx; %y 배열에 convolution 결과 저장

end

for j = 1:1:length(x2)-1 %shift시켜주는 x2의 신호가 잘리는 시점부터 진행하는 for문
    TfX2 = fliplr(x2);
    TRfX2 = [TfX2(1,1+j:end),zeros(1,length(x1)+j)]; %반전된 x2의 신호를 잘리게 하면서 shift 구현
    TX1X2 = [X1; TRfX2];
    Tprodx = prod(TX1X2);
    Tsumx = sum(Tprodx);
    y(length(x1)+j) = Tsumx; %윗쪽 for문에서 입력된 y 바로 다음 배열부터 convolution 결과 저장

end
result = fliplr(y); 
%뒤에서부터 convolution을 진행하여 결과가 반전되어 다시 원래대로 반전시키며 결과를 return한다. 