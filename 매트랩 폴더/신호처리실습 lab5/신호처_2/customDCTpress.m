function [mat, comp_rate] = customDCTpress(thrsh , m_in) %thrsh - 임계값, m_in 입력 배열
absm_in = abs(m_in);
[r, c] = size(absm_in);

[fr, fc] = find(absm_in < 0.001);   %압축하기 전 0.001보다 작은 값을 0으로 만듬.
clen1 = length(fc);
nZ1 = c * r -clen1; %0이 아닌 배열 개수 (압축전)
 
[fr, fc] = find(absm_in < 255*thrsh); %uint8 기준으로 임계값을 넘지 못하는 값 0으로 만듬.
clen2 = length(fc);
nZ2 = c * r - clen2; %0이 아닌 배열 개수 (압축 후)

k = 1;

for j = 1:c
    for l = 1:r
        if( l == fr(k) && j == fc(k))
            mat(l,j) = 0; %임계값에 걸리는 배열을 0으로 만듬.
            k = k + 1;
            if(k>length(fc)) %열 길이보다 1 더 커질때 배열 차수를 맞춰주기 위해 1을 줄여줌.
                k = k -1;
            end
        else
            mat(l,j) = m_in(l,j); % 임계값에 걸리지 않은 배열은 그대로 통과.
        end
    end
end

comp_rate = nZ2 / nZ1; % 압축률 표현.

