%%setup forward
%addpath ('@MarkovChain')
%addpath ('@GaussD')
A = [0.9 0.1 0; 0 0.9 0.1];
q = [1;0];
b1 = GaussD('Mean', 0, 'StDev', 1);
b2 = GaussD('Mean', 3, 'StDev', 2);
B=[b1; b2];
x = [-0.2 2.6 1.3];
pX = prob([b1 b2], x);
MC = MarkovChain(q,A);

[alfaHat, c] = forward(MC, pX);
disp(alfaHat)
disp(c)
%%
%addpath ('@HMM')
hmm = HMM(MC,B);
logP2 = logprob(hmm, x); 
disp(logP2)
