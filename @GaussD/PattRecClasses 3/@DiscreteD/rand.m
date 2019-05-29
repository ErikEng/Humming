function R=rand(pD,nData)
%R=rand(pD,nData) returns random scalars drawn from given Discrete Distribution.
%
%Input:
%pD=    DiscreteD object
%nData= scalar defining number of wanted random data elements
%
%Result:
%R= row vector with integer random data drawn from the DiscreteD object pD
%   (size(R)= [1, nData]
%
%----------------------------------------------------
%Code Authors: Zaineb Amor 
%----------------------------------------------------

if numel(pD) > 1
    error('Method works only for a single DiscreteD object');
end;

R = zeros(1, nData);
rnd = rand(1,nData)
cdf = cumsum(pD.ProbMass);
[bincounts,ind]= histc(rnd,cdf);
R(1,:)=ind+1; 

end 
