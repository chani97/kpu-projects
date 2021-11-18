clc;
clear;
close all;

img = myfun_LoadImage('lena.raw', 256, 256); %이미지 불러오기
dctimg = dct2(img); %2차원 dct 진행
adctimg = uint8(abs(dctimg)); %절대값 씌워 음수 없애고 uint8 함수로 0~255까지로 제한.
udctimg = uint8(abs(idct2(dctimg))); %inv-dct 진행.

%%% threshold 값 지정.
th1 = 0.001;
th2 = 0.01; %쓰는 문턱값
th3 = 0.05;
th4 = 0.1; %쓰는 문턱값
th5 = 0.25; %쓰는 문턱값
th6 = 0.5; %쓰는 문턱값

%%% threshold 값 변경해 가면서 압축 %%%

[mat1, comp1] = customDCTpress(th1 , dctimg);
[mat2, comp2] = customDCTpress(th2 , dctimg);
[mat3, comp3] = customDCTpress(th3 , dctimg);
[mat4, comp4] = customDCTpress(th4 , dctimg);
[mat5, comp5] = customDCTpress(th5 , dctimg);
[mat6, comp6] = customDCTpress(th6 , dctimg);

%%% 압축 완료된 배열들 uint8 로 0~255로 제한.
umat1 = uint8(abs(mat1));
umat2 = uint8(abs(mat2));
umat3 = uint8(abs(mat3));
umat4 = uint8(abs(mat4));
umat5 = uint8(abs(mat5));
umat6 = uint8(abs(mat6));

%%% 압축 완료된 배열들 inv-dct 후 uint8로 복원
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

%%% threshold 값과 압축률 그래프 위한 배열
thr_mat = [th1,th2,th3,th4,th5,th6];
comp_mat = [comp1,comp2,comp3,comp4,comp5,comp6];

%%% threshold 값에 따른 RMSE 값 추출하기
MSRE1 = customMSRE(img, uidct1);
MSRE2 = customMSRE(img, uidct2);
MSRE3 = customMSRE(img, uidct3);
MSRE4 = customMSRE(img, uidct4);
MSRE5 = customMSRE(img, uidct5);
MSRE6 = customMSRE(img, uidct6);

%%% RMSE 값 배열.
msre_mat = [MSRE1,MSRE2,MSRE3,MSRE4,MSRE5,MSRE6];

%%% 압축된 배열의 절대값 씌운 후 uint8 진행
figure(1)
subplot(221)
imshow(umat2)
subplot(222)
imshow(umat4)
subplot(223)
imshow(umat5)
subplot(224)
imshow(umat6)

%%% 압축된 배열 복원. 221~224로 갈수록 threshold 값 커짐 3-2
figure(2)
subplot(221)
imshow(uidct2)
subplot(222)
imshow(uidct4)
subplot(223)
imshow(uidct5)
subplot(224)
imshow(uidct6)

%%% 압축률과 RMSE 그래프.  (지금 RMSE 마지막 값이 다르게 나옴!!) 3-3
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


