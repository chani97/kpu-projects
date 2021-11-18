function resp = customFRZ(zero,pole,axis)

zero1 = zeros(1,length(zero));
pole1 = zeros(1, length(pole));

for r = 1:length(zero)
    for c = 1:length(axis)
       z(r,c) = exp(1i * axis(c)) - zero(r); %����(zero)�� �� ���ϱ�. laplace �ʹ� �ٸ��� exp�� �پ�� ��.
       zero1(r,c) = sqrt(real(z(r,c)).^2  + imag(z(r,c)).^ 2); %�Ǽ� ���� ��� ���� ���� ���������� �Ÿ� ���ϱ�.
    end
end

if(r > 1) 
    zero1 = prod(zero1); % ������ �ΰ� �̻��� ���. ������ �����ش�.
end

for rp = 1:length(pole)
    for cp = 1:length(axis)
       p(rp,cp) = exp(1i * axis(cp)) - pole(rp); %����(pole)�� �� ���ϱ�.
       pole1(rp,cp) = sqrt(real(p(rp,cp)).^2  + imag(p(rp,cp)).^ 2); %�Ǽ� ���� ��� ���� ���� ���������� �Ÿ� ���ϱ�.
    end
end

if(rp > 1) 
    pole1 = prod(pole1); % ������ �ΰ� �̻��� ���. ������ �����ش�.
end

resp = zero1./pole1;