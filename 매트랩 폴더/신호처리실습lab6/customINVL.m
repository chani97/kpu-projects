function s = customINVL(z,p,a) % 입력 (분자, 분모, 축)
s = 0;

for i = 1:length(p)
    s = s + z(i)* exp(p(i)*a); %라플라스 역변환
end
end