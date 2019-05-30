%%
%hmms = {h1, h2, h3, h4,  h6, h7, h8, h10}
testHmm = load("HMMS_trial1.mat")
hmm = testHmm.HMMS;
testh1 = hmm(1) ;

%% Temp testing
fs = 22050; % of sample frequency
nobits = 16; % of bits per sample
nochannels = 1; % of channels (mono)
recording = audiorecorder (fs, nobits, nochannels);
get (recording);
recording = audiorecorder;
disp ('Star t talking');
recordblocking(recording, 3);
disp ('End of Recording');
w1 = getaudiodata(recording);
%pause(3);
filename = 'demo.wav';
audiowrite(filename,w1,8000);

%TestClass = 'Class1';
%testFile = '4.wav';
%path_to_file = strcat(TestClass,'/',testFile)
[sTest, fsTest] = audioread('demo.wav');
[frIsequence] = GetMusicFeatures(sTest,fsTest,0.03);
t = GetT(frIsequence);
[frIsequenceOut] = Postprocess(frIsequence,t);
h1 = hmm{1};
h2 = hmm{2};
h3 = hmm{3};
h4 = hmm{4};
h5 = hmm{5};
h6 = hmm{6};
h7 = hmm{7};
h8 = hmm{8};
h9 = hmm{9};
h10 = hmm{10};
lP = logprob([h1, h2, h3, h4, h5, h6, h7, h8, h9,h10],frIsequenceOut);
[C, i] = max(lP);
disp(i) 

