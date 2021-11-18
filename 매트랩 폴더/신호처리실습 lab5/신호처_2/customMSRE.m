function msre = customMSRE(x1, x2)


for j = 1:256
    matsum = [x1(j,:);x2(j,:)]; %x1�� x2 �迭 ��ħ
    dif = diff(matsum); %�迭 ���ֱ�
    sresult = sum(dif.^2); %���ذ� ������ ����.
end
sumresult = sum(sresult);   %�� ������
msre = sqrt((1/(256*256))*sumresult);   % �迭x��*y�� ����(256*256) * ���� �� �� ������ = RMSE