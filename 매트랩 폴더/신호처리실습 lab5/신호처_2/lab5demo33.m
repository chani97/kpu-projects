clc;
clear;
close all;

img = myfun_LoadImage('lena.raw', 256, 256); %�̹��� �ҷ�����
dctimg = dct2(img); %2���� dct ����
adctimg = uint8(abs(dctimg)); %���밪 ���� ���� ���ְ� uint8 �Լ��� 0~255������ ����.
udctimg = uint8(abs(idct2(dctimg))); %inv-dct ����.

%%% threshold �� ����.
th1 = 0.001;
th2 = 0.01; %���� ���ΰ�
th3 = 0.05;
th4 = 0.1; %���� ���ΰ�
th5 = 0.25; %���� ���ΰ�
th6 = 0.5; %���� ���ΰ�

%%% threshold �� ������ ���鼭 ���� %%%

[mat1, comp1] = customDCTpress(th1 , dctimg);
[mat2, comp2] = customDCTpress(th2 , dctimg);
[mat3, comp3] = customDCTpress(th3 , dctimg);
[mat4, comp4] = customDCTpress(th4 , dctimg);
[mat5, comp5] = customDCTpress(th5 , dctimg);
[mat6, comp6] = customDCTpress(th6 , dctimg);

%%% ���� �Ϸ�� �迭�� uint8 �� 0~255�� ����.
umat1 = uint8(abs(mat1));
umat2 = uint8(abs(mat2));
umat3 = uint8(abs(mat3));
umat4 = uint8(abs(mat4));
umat5 = uint8(abs(mat5));
umat6 = uint8(abs(mat6));

%%% ���� �Ϸ�� �迭�� inv-dct �� uint8�� ����
midct1 = idct2(mat1);
uidct1 = uint8(midct1);
midct2 = idct2(mat2);
uidct2 = uint8(midct2);
midct3 = idct2(mat3);
uidct3 = uint8(midct3);
midct4 = idct2(mat4);
uidct4 = uint8(midct4);
midct5 = idct2(mat5);
uidct5 = uint8(midct5);
midct6 = idct2(mat6);
uidct6 = uint8(midct6);

%%% threshold ���� ����� �׷��� ���� �迭
thr_mat = [th1,th2,th3,th4,th5,th6];
comp_mat = [comp1,comp2,comp3,comp4,comp5,comp6];

%%% threshold ���� ���� RMSE �� �����ϱ�
MSRE1 = customMSRE(img, uidct1);
MSRE2 = customMSRE(img, uidct2);
MSRE3 = customMSRE(img, uidct3);
MSRE4 = customMSRE(img, uidct4);
MSRE5 = customMSRE(img, uidct5);
MSRE6 = customMSRE(img, uidct6);

%%% RMSE �� �迭.
msre_mat = [MSRE1,MSRE2,MSRE3,MSRE4,MSRE5,MSRE6];

%%% ����� �迭�� ���밪 ���� �� uint8 ����
figure(1)
subplot(221)
imshow(umat2)
subplot(222)
imshow(umat4)
subplot(223)
imshow(umat5)
subplot(224)
imshow(umat6)

%%% ����� �迭 ����. 221~224�� ������ threshold �� Ŀ�� 3-2
figure(2)
subplot(221)
imshow(uidct2)
subplot(222)
imshow(uidct4)
subplot(223)
imshow(uidct5)
subplot(224)
imshow(uidct6)

%%% ������� RMSE �׷���.  (���� RMSE ������ ���� �ٸ��� ����!!) 3-3
figure(3)
subplot(211)
semilogy(thr_mat, comp_mat)
xlabel('Threshold')
ylabel('Compression Rate')
grid on
subplot(212)
plot(thr_mat, msre_mat)
xlabel('Threshold')
ylabel('RMSE')
grid on


