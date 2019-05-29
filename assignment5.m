
%Todos
%1 create training- and testing set (we can use the usual 70-30 i think)
%2 init and train one L-R HMM for each class (on the training set) 
%3 test classifier on test set and count num of misclassifications (for
%higher acc you can repeat this crossval several times
%4 See if you can figure out why the missclassified examples were wrong
%5 Demo. either using audiorecorder or by calling DrawCharacter, and then
%shows the classification of the input and plots the log-likelihoods of the
%various classes for comparison. If the demo involves audio, it should
%play back each recorded sound, so that one can be sure there is no
%distortion or other sound issues.
%6 Play with demo and estimate performance
%7 prep to describe and demonstrate system
%8 At presentation: introduce probl, describe design, -test perfo, and do
%live demo

%%
%train Test partition
[s1, Fs1] = audioread('melody_1.wav'); 
[s2, Fs2] = audioread('melody_2.wav');
[s3, Fs3] = audioread('melody_3.wav');

%start with 12 sources, maybe change later 
data = [s1, Fs1;s2, Fs2; s3, Fs3] %todo generate data to import
crossVal = cvpartition(size(data,1),'HoldOut',0.3);
idx = crossVal.test;

trainData = data(~idx,:);
testData  = data(idx,:);

%%
%initiation and training 
numSongs = 5 %todo change this to be defined by how many folders there are in the song database
numStates = t; %what should this be?
N = 1 %what should this be
avgStateDuration = 0.1 %Our prior for how long each state is, ie how long each tone is?
q = zeros(numStates); 
q(1) = 1; %defined to start at state 1
A = zeros(t, N+1) 
for a=1:N
    A(a, a) = avgStateDuration
    A(a, a+1) = 1 - A(a, a) %might have mixed up column vs row here)
end

%all the output probability distributions for
%different states can be initialized with the same parameters for all states.
%The first step in the Baum-Welch iteration will then use the training data
%to calculate more correct output probability parameters for each state.
%For example, in a discrete HMM, all elements of the output probability
%matrix B can be uniformly initialized as
%bjm = 1/M, j = 1 . . . N, m = 1 . . . M (6.24)
numSongs = 4 %todo change this to the number of songs it can be. used for prior
bPrior = 1/numSongs;  %not sure if this is a reasonable prior, but it doesn't have to be perfect
B = ones(t, N+1)*bPrior 


%Hints: 
%1. Use consistent naming of files. Ex put files in same class in the same
%folder. Use matlab dir command
%2. decide suitable num of states. 
%" A useful rule of thumb is that each model should have at least one state 
% for each distinct regime you expect in your feature series, including silences for audio.
%Gradual transitions between different behaviours, such
%as diphthongs, pitch slides, or many pen paths, will likely require more than
%one state to be modelled well.
%Try out diff amount of states to see what works best
%3. Form of HMM output distr? Normal or not? 
%if multimodal or skewed, then multi-compnent GMM is probably best
%5 For the testing, it may be convenient to store all your trained HMM
%instances in a single array, e.g., as hmms(1)=h1; %HMM for the first class hmms(2)=h2; %HMM for the next class
%6. lP=logprob(hmms,xtest) When you are done you can save your trained system to disk using the
%MatLab command save.

%Common problems
%1. Things won't work right away. inf or NaNs are common. 
%1 solution:These problems are often due to problematic features or models, or a
%combination of features and models that do not work well together, as the
%EM-algorithm can be quite sensitive to such issues
%2. Unreasonable or undef values. These must be resolved before demonstration
%3. NaNs. Big problem, aim to figure out the source of them any time they
%appear often in Gaussian or GMM output distr, usually if there's only 1
%sample and therefore no vaation. 
%Most common from feature with no variation. some models can deal with such
%features, but not this one, so such features should be discarded. 
%If your features are generally scalar and discrete in nature, it is probably
%advisable to switch to use DiscreteD output distributions instead
%A simple but somewhat inelegant workaround is to add a bit of random noise to the
%features: small enough so that the features remain substantially the same
%in the big picture, but big enough to ensure there always is some variation.
%4. inf logprobs. caused by unprecendented data

%can also be due to too many hmm states or gmm components
