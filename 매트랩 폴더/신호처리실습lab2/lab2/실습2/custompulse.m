function [result_t, result_p] = custompulse(t1,t2,N,fs)

time = 1 / fs;  %���ļ��� �ð����� ����
result_t = [t1:time:t2];    %t1�� t2 ���̸� �ð����� ����

limp = length(result_t);    %���޽��� ���� ����

blank = N - limp;       % 0���� ��� ���� ����
one_pad = fix(blank/(limp - 1));
% 1�� ä�� ���� ����. t1=0, t2 =10, N = 100, fs = 1�̶� ���������� limp = 10,
% blank = 90 �̹Ƿ� ���� �����ֱ� ���� blank�� limp -1 �� ������. fix �Լ� ����Ͽ�
% ���� �ʰ��� ���ɼ��� �����.

count = 1;  %1�� ä��� ������ �޾��� ���� ����, 1�� �ʱ�ȭ.
  
result_t = [t1 : (time/(one_pad + 1)) : (t2 - time)];
% t1���� t2 - time ����
% ���޽� ������ ��Ȱ�� �����ϱ� ���� ������ ����.

for i = 1:length(result_t)
    if(count == 1)
        result_p(i) = 1;      % t1�� ���޽��� �߻��ϹǷ� �ʱ⵵ 1�� �����Ѵ�.
    else
        result_p(i) = 0;
    end
    count = count+1;
    if(count == (one_pad+2))
         % one_pad + 1 ��°�� �ε����� 1�� ä�� �����̴�. 
         %count �ʱ�ȭ ���� 1�̹Ƿ� 1�� �� ���� one_pad + 2�� ��.

        count = 1; %count ���� �ʱ�ȭ
    end
end

blank1 = N - length(result_t);  %result_t �� 17��° �ٿ��� �޶������Ƿ� ���ο� ���� ����.
%�ð��࿡ �߰��� ������ ���� ����. ������ �����ϰ� ����
t_add = linspace((t2-time+(time/(one_pad + 1))),t2,blank1); 
%��� ��ȣ�� �߰������� ������ 0 ����.
p_add = zeros(1,length(t_add));
%�迭 ��ġ��
result_t = [result_t,t_add];
result_p = [result_p,p_add];
end