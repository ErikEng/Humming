%Train HMMs 1 to 10
%% Class 1: RickRoll
[obsData, lData, testData, lTest] = GetData('Class1')
h1 = TrainClass(7,obsData,lData)
%%
%%Class 2 bamse 
[obsData, lData, testData, lTest] = GetData('Class2')
h2 = TrainClass(7,obsData,lData)
%% Class 3: Con te partiro
[obsData, lData, testData, lTest] = GetData('Class3')
h3 = TrainClass(7,obsData,lData)
%% Class 4: helan går
[obsData, lData, testData, lTest] = GetData('Class4')
h4 = TrainClass(6,obsData,lData)
%% Class 5: Hellfire
[obsData, lData, testData, lTest] = GetData('Class5')
h5 = TrainClass(5,obsData,lData)
%% Class 6: bulls on parade %trying to open .ds file 
[obsData, lData, testData, lTest] = GetData('Class6')
h6 = TrainClass(7,obsData,lData)
%% Class 7: måsen
[obsData, lData, testData, lTest] = GetData('Class7')
h7 = TrainClass(6,obsData,lData)
%% Class 8:Du gamla 
[obsData, lData, testData, lTest] = GetData('Class8')
h8 = TrainClass(6,obsData,lData)
%% Class 9: Imperial march %iutofbounds
[obsData, lData, testData, lTest] = GetData('Class9')
h9 = TrainClass(6,obsData,lData)
%% Class 10: Twinkle little star
[obsData, lData, testData, lTest] = GetData('Class10')
h10 = TrainClass(5,obsData,lData)
%%
hmms = {h1, h2, h3, h4,  h6, h7, h8, h10}
testHmm = load("hmms8.mat")
hmm = testHmm.hmms
testh1 = hmm(1) 

%% Temp testing

TestClass = 'Class1';
testFile = '4.wav';
path_to_file = strcat(TestClass,'/',testFile)
[sTest, fsTest] = audioread(path_to_file);
[frIsequence] = GetMusicFeatures(sTest,fsTest,0.03);
t = GetT(frIsequence);
[frIsequenceOut] = Postprocess(frIsequence,t);
h1 = hmms{1};
h2 = hmms{2};
h3 = hmms{3};
h4 = hmms{4};
h5 = hmms{5};
h7 = hmms{6};
h8 = hmms{7};
h10 = hmms{8};
lP = logprob([h1, h2, h3, h4, h5, h7, h8, h10],frIsequenceOut);
[C, i] = max(lP);
disp(i) 

