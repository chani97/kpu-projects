function s = customINVL(z,p,a) % �Է� (����, �и�, ��)
s = 0;

for i = 1:length(p)
    s = s + z(i)* exp(p(i)*a); %���ö� ����ȯ
end
end