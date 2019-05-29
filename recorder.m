fs = 22050; % of sample frequency
nobits = 16; % of bits per sample
nochannels = 1; % of channels (mono)
recording = audiorecorder (fs, nobits, nochannels);
get (recording);
recording = audiorecorder;
disp ('Start talking');
recordblocking(recording, 3);
disp ('End of Recording');

%play(recording);
w1 = getaudiodata(recording);
%pause(3);
filename = '15Cl.wav';
audiowrite(filename,w1,8000)
%[s1, Fs1] = audioread('15.wav'); 
%sound(s1, Fs1)
