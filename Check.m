% Question 1
clear;
addpath ('@GaussD');
q = [0.75 ; 0.25];
A = [0.99 0.01; 0.03 0.97];

b1 = GaussD('Mean', 0, 'StDev', 1);
b2 = GaussD('Mean', 3, 'StDev', 2);
B = [b1 ; b2]
%%
addpath ('@MarkovChain');
T = 5
S=zeros(1,T)
MC = MarkovChain(q,A);
%% Check Markov

T = 10000;
Freqs_S1 = zeros(1,200);
Freqs_S2 = zeros(1,200);
for j=1:200
    S = rand(MC,T)
    S1 = ones(1,10000);
    S2 = ones(1,10000)*2;
    Freq_S1 = sum(S == S1)/10000;
    Freq_S2 = sum(S == S2)/10000;
    Freqs_S1(1,j)=Freq_S1;
    Freqs_S2(1,j)=Freq_S2;
end 

Freq_glob1 = sum(Freqs_S1)/200
Freq_glob2 = sum(Freqs_S2)/200

%% Check HMM
%addpath('@HMM');
T=10000;
H = HMM(MC,B)
%%
Mu = 0;
Var = 0;
for j = 1 : 50
    [X, ~] = rand(H, T);
    Mu = Mu + mean(X, 2);
    Var = Var + var(X, 0, 2);
end

Mu_glob = Mu/50
Var_glob = Var/50

%% HMM behaviour

T=500;
H = HMM(MC,B);
[X, S] = rand(H,T);

plot(X)
title('500 contiguous samples Xt drawn from the HMM');
xlabel('Time')
ylabel('Xt')
%% HMM Behaviour 2
T=500;

b1_1 = GaussD('Mean', 0, 'StDev', 1);
b2_1 = GaussD('Mean', 0, 'StDev', 2);
B_1 = [b1_1 ; b2_1]
H = HMM(MC,B_1);
[X, S] = rand(H,T);

plot(X)
title('500 contiguous samples Xt drawn from the HMM');
xlabel('Time')
ylabel('Xt')

%% Finite
T=500;
q       = [0.75;0.25];
A = [0.83 0.01 0.16; 0.03 0.85 0.12];
B_1    = GaussD('Mean',1,'StDev',1);
B_2    = GaussD('Mean',2,'StDev',3);
B = [B_1 ; B_2];
MC_1      = MarkovChain(q,A);
H_1    = HMM(MC_1,B);
[X,S]       = rand(H_1,T);
plot(X)
title('500 contiguous samples Xt drawn from the HMM');
xlabel('Time')
ylabel('Xt')
%% 
q       = [0.75;0.25];
A       = [0.99 0.01;0.03 0.97];
B_1    = GaussD('Mean',[10 25],'Covariance',[2 1;1 4]);
B_2    = GaussD('Mean',[0 5],'StDev',[1 1]);
B = [B_1 ; B_2];
MC      = MarkovChain(q,A);
H    = HMM(MC,B);
[X,S]       = rand(H,T);
plot(X)
title('500 contiguous samples Xt drawn from the HMM');
xlabel('Time')
ylabel('Xt')