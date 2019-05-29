function S=rand(mc,T)
%S=rand(mc,T) returns a random state sequence from given MarkovChain object.
%
%Input:
%mc=    a single MarkovChain object
%T= scalar defining maximum length of desired state sequence.
%   An infinite-duration MarkovChain always generates sequence of length=T
%   A finite-duration MarkovChain may return shorter sequence,
%   if END state was reached before T samples.
%
%Result:
%S= integer row vector with random state sequence,
%   NOT INCLUDING the END state,
%   even if encountered within T samples
%If mc has INFINITE duration,
%   length(S) == T
%If mc has FINITE duration,
%   length(S) <= T
%
%---------------------------------------------
%Code Authors:
%---------------------------------------------

S=zeros(1,T);%space for resulting row vector
nS=mc.nStates;

finite = finiteDuration(mc);
S(1,1)  = rand(DiscreteD(mc.InitialProb),1); 
for i=2:T
    probDistTransit = DiscreteD(mc.TransitionProb(S(1,i-1),:));
    S(1,i) = rand(probDistTransit,1); %draw random state from distribution 
    if (S(1,i)==nS+1) && (finite)  % if finite and reached the END state 
        S(1,i)  = 0; % do not count that state
        index   = find(S~=0);
        S       = S(1,index);
        break;
    end
end
    
end



