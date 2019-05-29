function [P_estim2,minP, maxP]=Postprocess(frIsequence,t1)
    
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
    
    P_estim2 = 12*log(P/minP)/log(2)+1;
    P_estim2(ind_noise)=0.5*rand(1,length(ind_noise));

%     p0=minP;
%     semitones =[];
%     while p0 <maxP 
%         for k=1:12
%             semitone = p0+(k-1)*(log(2)/12);
%             semitones = [semitones,semitone];
%         end
%         p0=p0+log(2);
%     end 
% 
%     P_estim1 = zeros(1,length(P));
%     for i=1:length(P)
%         if ismember(i,ind_noise)
%             P_estim1(i) = 0.05*rand(1,1);
%         else
%             dist = semitones - P(i);
%             d_min = min(dist);
%             min_ind = find(dist==d_min);
%             semi_ind= find(semitones==semitones(min_ind));
%             P_estim1(i) = semi_ind ;
%         end
%     end 


end 