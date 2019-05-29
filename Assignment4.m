
%% Check backward 
%addpath ('@MarkovChain')
%addpath ('@GaussD')
%addpath ('@HMM')
q = [1; 0];
A = [0.9, 0.1, 0; 0, 0.9, 0.1];
b1 = GaussD('Mean', 0, 'StDev', 1); 
b2 = GaussD('Mean', 3, 'StDev', 2);
B = [b1, b2];
MC = MarkovChain(q, A);
x = [-0.2, 2.6, 1.3]; 
[pX, scale] = prob(B, x);
c = [1, 0.1625, 0.8266, 0.0581];
betaHat = backward(MC, pX, c)




