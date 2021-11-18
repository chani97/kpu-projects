function resp = customFRZ(zero,pole,axis)

zero1 = zeros(1,length(zero));
pole1 = zeros(1, length(pole));

for r = 1:length(zero)
    for c = 1:length(axis)
       z(r,c) = exp(1i * axis(c)) - zero(r); %영점(zero)의 차 구하기. laplace 와는 다르게 exp가 붙어야 함.
       zero1(r,c) = sqrt(real(z(r,c)).^2  + imag(z(r,c)).^ 2); %실수 제곱 허수 제곱 합의 제곱근으로 거리 구하기.
    end
end

if(r > 1) 
    zero1 = prod(zero1); % 영점이 두개 이상인 경우. 열끼리 곱해준다.
end

for rp = 1:length(pole)
    for cp = 1:length(axis)
       p(rp,cp) = exp(1i * axis(cp)) - pole(rp); %극점(pole)의 차 구하기.
       pole1(rp,cp) = sqrt(real(p(rp,cp)).^2  + imag(p(rp,cp)).^ 2); %실수 제곱 허수 제곱 합의 제곱근으로 거리 구하기.
    end
end

if(rp > 1) 
    pole1 = prod(pole1); % 영점이 두개 이상인 경우. 열끼리 곱해준다.
end

resp = zero1./pole1;