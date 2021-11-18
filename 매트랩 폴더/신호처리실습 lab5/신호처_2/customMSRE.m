function msre = customMSRE(x1, x2)


for j = 1:256
    matsum = [x1(j,:);x2(j,:)]; %x1과 x2 배열 합침
    dif = diff(matsum); %배열 빼주기
    sresult = sum(dif.^2); %빼준값 제곱후 더함.
end
sumresult = sum(sresult);   %다 더해줌
msre = sqrt((1/(256*256))*sumresult);   % 배열x축*y축 개수(256*256) * 더한 값 의 제곱근 = RMSE