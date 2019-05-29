function [frIsequenceOut,minP, maxP]=Postprocess(frIsequence,t1)
    
    frIsequenceOut = zeros(size(frIsequence));
    P=log(frIsequence(1,:));
    R=frIsequence(2,:);
    I=log(frIsequence(3,:));
    
    meanI = mean(I);
    meanR = mean(R);
    noise = zeros(1, length(t1));
    for i=1:length(noise)
        if ((I(i) < meanI) & (R(i) < meanR))|(P(i) < mean(P) - std(P))|(P(i) > mean(P) + 0.5*std(P)) ;
            noise(i) = 1;
        end 
    end
    
    ind_noise = find(noise==1);
    minP = min(P(find(noise==0)));    
    maxP = max(P(find(noise==0)));
    
    P_estim = 12*log(P/minP)/log(2)+1;
    P_estim(ind_noise)=0.5*rand(1,length(ind_noise));
    
    frIsequenceOut(1,:) = P_estim;
    frIsequenceOut(2,:) = R;
    frIsequenceOut(3,:) = I;
 
end 