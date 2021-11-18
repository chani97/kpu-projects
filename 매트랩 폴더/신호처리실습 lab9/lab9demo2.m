clc;
clear;
close all;
circle = linspace(-pi,pi, 360);

[piano, pfs] = audioread('Audio_Piano01_10sec.wav');
p_axis = linspace(0,10,length(piano)); %linspace 1sec.
[f2, pXf] = myfun_SA(p_axis, piano);
f = linspace(0,pfs/2, pfs); %butterworth 함수의 결과, 대역통과의 경우 차수 n/2. f/fs 이므로 pfs/2 사용
[n1, d1] = butter(7,500/(pfs/2), 'low'); %ch1 lpf 7차
ch1 = freqz(n1,d1, length(f));

[n2, d2] = butter(6,[500/(pfs/2), 1500/(pfs/2)],'bandpass'); %ch2 bpf, 12차
ch2 = freqz(n2,d2, length(f));

[n3, d3] = butter(6,[1500/(pfs/2), 2500/(pfs/2)],'bandpass'); %ch3 bpf, 12차
ch3 = freqz(n3,d3, length(f));

[n4, d4] = butter(6,[2500/(pfs/2), 3500/(pfs/2)],'bandpass'); %ch4 bpf, 12차
ch4 = freqz(n4,d4, length(f));

[n5, d5] = butter(10,3500/(pfs/2), 'high'); %ch5 bpf, 10차
ch5 = freqz(n5,d5, length(f));

%%%%%%%%%%%%%%%%%%%%%%channel%%%%%%%%%%%%%%%%%%%%%%%
figure(1)
hold on
plot(f,abs(ch1))
plot(f,abs(ch2))
plot(f,abs(ch3))
plot(f,abs(ch4))
plot(f,abs(ch5))
xlim([0,5000])
ylim([0,1.4])
grid on
xlabel('Frequency axis')
ylabel('|H(f)|')
legend('ch1','ch2','ch3','ch4','ch5')


%%%%%%%%%%%%%%%%%%%zero-pole plot%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(2)
subplot(321)
hold on
z1 = roots(n1);
p1 = roots(d1);
plot(exp(1i*circle))
plot(real(z1), imag(z1), 'bo', 'Markersize', 15)
plot(real(p1), imag(p1), 'rx', 'Markersize', 15)
xlabel('real')
ylabel('imagine')
legend('ch1')
hold off

subplot(322)
hold on
z2 = roots(n2);
p2 = roots(d2);
plot(exp(1i*circle))
plot(real(z2), imag(z2), 'bo', 'Markersize', 15)
plot(real(p2), imag(p2), 'rx', 'Markersize', 15)
xlabel('real')
ylabel('imagine')
legend('ch2')
hold off

subplot(323)
hold on
z3 = roots(n3);
p3 = roots(d3);
plot(exp(1i*circle))
plot(real(z3), imag(z3), 'bo', 'Markersize', 15)
plot(real(p3), imag(p3), 'rx', 'Markersize', 15)
xlabel('real')
ylabel('imagine')
legend('ch3')
hold off

subplot(324)
hold on
z4 = roots(n4);
p4 = roots(d4);
plot(exp(1i*circle))
plot(real(z4), imag(z4), 'bo', 'Markersize', 15)
plot(real(p4), imag(p4), 'rx', 'Markersize', 15)
xlabel('real')
ylabel('imagine')
legend('ch4')
hold off

subplot(325)
hold on
z5 = roots(n5);
p5 = roots(d5);
plot(exp(1i*circle))
plot(real(z5), imag(z5), 'bo', 'Markersize', 15)
plot(real(p5), imag(p5), 'rx', 'Markersize', 15)
xlabel('real')
ylabel('imagine')
legend('ch5')
hold off



[classic, cfs] = audioread('Audio_Classic01_11sec.wav');
[pop, popfs] = audioread('Audio_Pop01_15sec.wav'); %pop
[song, sfs] = audioread('Audio_Song_Female01_10sec.wav'); %song
[voicef, vffs] = audioread('Audio_Voice_Female01_8sec.wav'); %voice_female
[voicem, vmfs] = audioread('Audio_Voice_Male01_11sec.wav'); %voice_male

%%%%%%%%%%%%%%%%%%%%%%%%%%%%filtered piano%%%%%%%%%%%%%%%%%%%%%%%%%
fil1 = filter(n1,d1,piano);
p_axis = linspace(0,10,length(piano));
[freq1, sch1] = myfun_SA(p_axis, fil1);
%sound(fil1,pfs);

fil2 = filter(n2,d2,piano);
[freq2, sch2] = myfun_SA(p_axis, fil2);
%sound(fil2,pfs);

fil3 = filter(n3,d3,piano);
[freq3, sch3] = myfun_SA(p_axis, fil3);
%sound(fil3,pfs);

fil4 = filter(n4,d4,piano);
[freq4, sch4] = myfun_SA(p_axis, fil4);
%sound(fil4,pfs);

fil5 = filter(n5,d5,piano);
[freq5, sch5] = myfun_SA(p_axis, fil5);
%sound(fil5,pfs);

figure(3)
%%%%%%%%%%%%%%%%%%%%time axis%%%%%%%%%%%%%%%%%%%%%
subplot(521)
plot(p_axis, fil1)
xlabel('time axis')
ylabel('ch1 piano')

subplot(523)
plot(p_axis, fil2)
xlabel('time axis')
ylabel('ch2 piano')

subplot(525)
plot(p_axis, fil3)
xlabel('time axis')
ylabel('ch3 piano')

subplot(527)
plot(p_axis, fil4)
xlabel('time axis')
ylabel('ch4 piano')

subplot(529)
plot(p_axis, fil5)
xlabel('time axis')
ylabel('ch5 piano')

%%%%%%%%%%%%%%%%%frequency axis%%%%%%%%%%%%%%%%%%%%
subplot(522)
plot(freq1, abs(sch1))
xlim([0,5000])
xlabel('Frequency axis')
ylabel('ch1')

subplot(524)
plot(freq2, abs(sch2))
xlim([0,5000])
xlabel('Frequency axis')
ylabel('ch2')

subplot(526)
plot(freq3, abs(sch3))
xlim([0,5000])
xlabel('Frequency axis')
ylabel('ch3')

subplot(528)
plot(freq4, abs(sch4))
xlim([0,5000])
xlabel('Frequency axis')
ylabel('ch4')

subplot(5 ,2 ,10)
plot(freq5, abs(sch5))
xlim([0,5000])
xlabel('Frequency axis')
ylabel('ch5')

%%%%%%%%%%%%%%%%%%%%%mixing%%%%%%%%%%%%%%%%%%%%%%%%%
c1 = 1;
c2 = 5;
c3 = 4;
c4 = 2;
c5 = 1;
w = 1;

cg = fil1*c1 + fil2*c2 + fil3*c3 + fil4*c4 + fil5*c5; %channel gain
c0 = sqrt(sum(piano.^2)/sum(cg.^2));
mix = c0*cg;
out = mix*w;
[freq0, fout] = myfun_SA(p_axis, out);

figure(4)
subplot(211)
hold on
plot(p_axis, piano, 'red') %input piano
plot(p_axis, out, 'black') %mixed output of piano
hold off
xlabel('time axis')
ylabel('Piano')
legend('piano','mixed piano')

subplot(212)
hold on
plot(f2, abs(pXf), 'red')
plot(freq0, abs(fout), 'black')
xlim([0,5000])
xlabel('Frequency axis')
ylabel('|X(f)|')
legend('input', 'output')

%sound(out,pfs);