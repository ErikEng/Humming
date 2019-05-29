function t= GetT(frIsequence)
t = 0:(length(frIsequence(1,:))+1)*(0.03/2)/(length(frIsequence(1,:))-1):(length(frIsequence(1,:))+1)*(0.03/2);
end 