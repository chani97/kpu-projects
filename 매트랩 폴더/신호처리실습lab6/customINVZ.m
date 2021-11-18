function z = customINVZ(zero,pole,axis) % 입력 (분자, 분모, 축)
z = 0;

for i = 1:length(pole)
    z = z + zero(i)*pole(i).^axis; %z변환 역변환
end
end