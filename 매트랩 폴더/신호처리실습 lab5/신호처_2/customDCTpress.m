function [mat, comp_rate] = customDCTpress(thrsh , m_in) %thrsh - �Ӱ谪, m_in �Է� �迭
absm_in = abs(m_in);
[r, c] = size(absm_in);

[fr, fc] = find(absm_in < 0.001);   %�����ϱ� �� 0.001���� ���� ���� 0���� ����.
clen1 = length(fc);
nZ1 = c * r -clen1; %0�� �ƴ� �迭 ���� (������)
 
[fr, fc] = find(absm_in < 255*thrsh); %uint8 �������� �Ӱ谪�� ���� ���ϴ� �� 0���� ����.
clen2 = length(fc);
nZ2 = c * r - clen2; %0�� �ƴ� �迭 ���� (���� ��)

k = 1;

for j = 1:c
    for l = 1:r
        if( l == fr(k) && j == fc(k))
            mat(l,j) = 0; %�Ӱ谪�� �ɸ��� �迭�� 0���� ����.
            k = k + 1;
            if(k>length(fc)) %�� ���̺��� 1 �� Ŀ���� �迭 ������ �����ֱ� ���� 1�� �ٿ���.
                k = k -1;
            end
        else
            mat(l,j) = m_in(l,j); % �Ӱ谪�� �ɸ��� ���� �迭�� �״�� ���.
        end
    end
end

comp_rate = nZ2 / nZ1; % ����� ǥ��.

