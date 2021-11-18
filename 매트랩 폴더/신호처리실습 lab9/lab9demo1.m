clc;
clear;
close all;

[classic, cfs] = audioread('Audio_Classic01_11sec.wav'); %classic
c_axis = linspace(0,11,length(classic)); %linspace 1sec.
[f1, cXf] = myfun_SA(c_axis, classic);
figure('Name', 'classic')
subplot(211)
plot(c_axis, classic)
xlim([0,11])
xlabel('second')
ylabel('classic 11sec, time axis')
subplot(212)
plot(f1, abs(cXf))
xlim([0,5000])
xlabel('Frequency axis')
ylabel('|X(f)|')
%sound(classic, cfs);


[piano, pfs] = audioread('Audio_Piano01_10sec.wav'); %piano
p_axis = linspace(0,10,length(piano)); %linspace 1sec.
[f2, pXf] = myfun_SA(p_axis, piano);
figure('Name', 'piano')
subplot(211)
plot(p_axis, piano)
xlim([0,10])
xlabel('second')
ylabel('piano 10sec, time axis')
subplot(212)
plot(f2, abs(pXf))
xlim([0,5000])
xlabel('Frequency axis')
ylabel('|X(f)|')
%sound(piano, pfs);

[pop, popfs] = audioread('Audio_Pop01_15sec.wav'); %pop
pop_axis = linspace(0,15,length(pop)); %linspace 1sec.
[f3, popXf] = myfun_SA(pop_axis, pop);
figure('Name', 'pop')
subplot(211)
plot(pop_axis, pop)
xlim([0,15])
xlabel('second')
ylabel('pop 15sec, time axis')
subplot(212)
plot(f3, abs(popXf))
xlim([0,5000])
xlabel('Frequency axis')
ylabel('|X(f)|')
%sound(pop, popfs);

[song, sfs] = audioread('Audio_Song_Female01_10sec.wav'); %song
song_axis = linspace(0,10,length(song)); %linspace 1sec.
[f4, songXf] = myfun_SA(song_axis, song);
figure('Name', 'song')
subplot(211)
plot(song_axis, song)
xlim([0,10])
xlabel('second')
ylabel('song 15sec, time axis')
subplot(212)
plot(f4, abs(songXf))
xlim([0,5000])
xlabel('Frequency axis')
ylabel('|X(f)|')
%sound(song, sfs);

[voicef, vffs] = audioread('Audio_Voice_Female01_8sec.wav'); %voice_female
voicef_axis = linspace(0,8,length(voicef)); %linspace 1sec.
[f5, voicefXf] = myfun_SA(voicef_axis, voicef);
figure('Name', 'voice_female')
subplot(211)
plot(voicef_axis, voicef)
xlim([0,8])
xlabel('second')
ylabel('voice, female, 8sec, time axis')
subplot(212)
plot(f5, abs(voicefXf))
xlim([0,5000])
xlabel('Frequency axis')
ylabel('|X(f)|')
%sound(voicef, vffs);

[voicem, vmfs] = audioread('Audio_Voice_Male01_11sec.wav'); %voice_male
voicem_axis = linspace(0,11,length(voicem)); %linspace 1sec.
[f6, voicemXf] = myfun_SA(voicem_axis, voicem);
figure('Name', 'voice_male')
subplot(211)
plot(voicem_axis, voicem)
xlim([0,11])
xlabel('second')
ylabel('voice, female, 8sec, time axis')
subplot(212)
plot(f6, abs(voicemXf))
xlim([0,5000])
xlabel('Frequency axis')
ylabel('|X(f)|')
%sound(voicem, vmfs);