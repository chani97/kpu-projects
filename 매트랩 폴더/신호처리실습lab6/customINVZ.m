function z = customINVZ(zero,pole,axis) % �Է� (����, �и�, ��)
z = 0;

for i = 1:length(pole)
    z = z + zero(i)*pole(i).^axis; %z��ȯ ����ȯ
end
end