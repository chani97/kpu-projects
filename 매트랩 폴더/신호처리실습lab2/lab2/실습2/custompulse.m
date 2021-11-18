function [result_t, result_p] = custompulse(t1,t2,N,fs)

time = 1 / fs;  %주파수를 시간으로 변경
result_t = [t1:time:t2];    %t1과 t2 사이를 시간으로 나눔

limp = length(result_t);    %임펄스열 개수 지정

blank = N - limp;       % 0으로 비울 개수 지정
one_pad = fix(blank/(limp - 1));
% 1로 채울 개수 지정. t1=0, t2 =10, N = 100, fs = 1이라 가정했을때 limp = 10,
% blank = 90 이므로 숫자 맞춰주기 위해 blank를 limp -1 로 나눈다. fix 함수 사용하여
% 만약 초과할 가능성에 대비함.

count = 1;  %1을 채우는 순서를 받아줄 변수 생성, 1로 초기화.
  
result_t = [t1 : (time/(one_pad + 1)) : (t2 - time)];
% t1부터 t2 - time 까지
% 임펄스 간격을 원활히 제공하기 위해 간격을 생성.

for i = 1:length(result_t)
    if(count == 1)
        result_p(i) = 1;      % t1은 임펄스가 발생하므로 초기도 1을 대입한다.
    else
        result_p(i) = 0;
    end
    count = count+1;
    if(count == (one_pad+2))
         % one_pad + 1 번째의 인덱스는 1을 채울 차례이다. 
         %count 초기화 값이 1이므로 1을 더 더해 one_pad + 2가 됨.

        count = 1; %count 변수 초기화
    end
end

blank1 = N - length(result_t);  %result_t 가 17번째 줄에서 달라졌으므로 새로운 변수 만듬.
%시간축에 추가로 더해줄 공간 생성. 간격은 동일하게 유지
t_add = linspace((t2-time+(time/(one_pad + 1))),t2,blank1); 
%출력 신호에 추가적으로 더해줄 0 생성.
p_add = zeros(1,length(t_add));
%배열 합치기
result_t = [result_t,t_add];
result_p = [result_p,p_add];
end