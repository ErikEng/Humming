[s1, Fs1] = audioread('melody_1.wav');
[s2, Fs2] = audioread('melody_2.wav');
[s3, Fs3] = audioread('melody_3.wav');
%%
sound(s3,Fs3)
%%
plot(s1(1000:1200))
ylabel('pressure')
xlabel('sample')
%%
[frIsequence1] = GetMusicFeatures(s1,Fs1,0.03);
[frIsequence2] = GetMusicFeatures(s2,Fs2,0.03);
[frIsequence3] = GetMusicFeatures(s3,Fs3,0.03);

P1=frIsequence1(1,:);
R1=frIsequence1(2,:);
I1=frIsequence1(3,:);
P2=frIsequence2(1,:);
R2=frIsequence2(2,:);
I2=frIsequence2(3,:);
P3=frIsequence3(1,:);
R3=frIsequence3(2,:);
I3=frIsequence3(3,:);
%%
t1 = 0:(length(P1)+1)*(0.03/2)/(length(P1)-1):(length(P1)+1)*(0.03/2);
t2 = 0:(length(P2)+1)*(0.03/2)/(length(P2)-1):(length(P2)+1)*(0.03/2);
t3 = 0:(length(P3)+1)*(0.03/2)/(length(P3)-1):(length(P3)+1)*(0.03/2);
%% Pitch 
ax1 = subplot(3,1,1)
plot(t1,P1)
xlabel('Time in seconds')
ylabel('Pitch in Hz') % on the logarithmic scale 
title('Pitch calculated for song 1')
ax2 = subplot(3,1,2)
plot(t2,P2)
xlabel('Time in seconds')
ylabel('Pitch in Hz')
title('Pitch calculated for song 2')
ax3 = subplot(3,1,3)
plot(t3,P3)
xlabel('Time in seconds')
ylabel('Pitch in Hz')
title('Pitch calculated for song 3')
gca=[ax1 ax2 ax3]
%set(gca, 'YScale', 'log')
%set(gca, 'YLim', [100 300]);
%% Intensity  
ax1 = subplot(3, 1, 1);
plot(t1,I1)
xlabel('Time in seconds')
ylabel('Intensity in W/m2') % in the logarithmic scale
title('Intensity calculated for song 1')
ax2 = subplot(3, 1, 2);
plot(t2,I2)
xlabel('Time in seconds')
ylabel('Intensity in W/m2') % in the logarithmic scale
title('Intensity calculated for song 2')
ax3 = subplot(3, 1, 3);
plot(t3,I3)
xlabel('Time in seconds')
ylabel('Intensity in W/m2') % in the logarithmic scale
title('Intensity calculated for song 3')
%set([ax1 ax2 ax3], 'YScale','log');
%% Check noise not noise
ax1 = subplot(2, 1, 1);
plot(t1,I1)
xlabel('Time in seconds')
ylabel('Intensity(logarithmic scale) in W/m2') % in the logarithmic scale
title('Intensity calculated for song 1')
ax2=subplot(2,1,2)
plot(t1,P1)
xlabel('Time in seconds')
ylabel('Pitch(logarithmic scale) in Hz') % in the logarithmic scale
title('Pitch calculated for song 2')
set([ax1 ax2], 'YScale','log');
set([ax2], 'YLim', [100 300])
%% Mean to detect noise
ax1 = subplot(3,1,1)
plot(t1,R1, 'b')
mr= mean(R1)
hold on 
plot(t1, ones(length(t1))*mr, 'r')
hold off
xlabel('Time in seconds')
ylabel('Correlation') 
title('Correlation and its mean value')
legend('Correlation between adjacent pitch periods', 'The mean value')

ax2 = subplot(3,1,2)
plot(t1,log(I1))
mi= mean(log(I1))
hold on 
plot(t1, ones(length(t1))*mi, 'r')
hold off
xlabel('Time in seconds')
ylabel('log(Intensity) in W/m2') 
title('Log(Intensity) and its mean value')
legend('log(Intensity)', 'The mean value')

ax3 = subplot(3,1,3)
plot(t1,log(P1))
mp= mean(log(P1))
st5 = mean(log(P1)) + 0.5*std(log(P1));
st1 = mean(log(P1)) - std(log(P1));
hold on 
plot(t1, ones(length(t1))*mp, 'r')
hold on
plot(t1, ones(length(t1))*st5, 'g')
hold on
plot(t1, ones(length(t1))*st1, 'b')
hold off
xlabel('Time in seconds')
ylabel('Log(Pitch) in Hz') 
title('Log(Pitch), its mean value and boudaries defined at mean+0.5*std and at mean-std')
legend('log(Pitch)', 'The mean value')

%% Test Extractor 

frIsequence15= zeros(size(frIsequence1));
frIsequence15(1,:)=frIsequence1(1,:).*1.5;
frIsequence15(2,:)=frIsequence1(2,:);
frIsequence15(3,:)=frIsequence1(3,:);

[P_estim12,minP1,maxP1]=Postprocess(frIsequence1,t1);
[P_estim152,minP15,maxP15]=Postprocess(frIsequence15,t1);
[P_estim22,minP2,maxP2]=Postprocess(frIsequence2,t2);
[P_estim32,minP3,maxP3]=Postprocess(frIsequence3,t3);


%% Test first way of extracting
% figure()
% plot(t1, P_estim11, 'r')
% hold on 
% plot(t1, P_estim151, 'g')
% hold off 
% legend('Song1', 'Song1*1.5')
% xlabel('Time in second')
% ylabel('Pitch of the semitone extracted')
% title('Pitch of the semitone extracted for song 1 and song 1*1.5')
% 
% maxsamp =max( length(P_estim21), length(P_estim11));
% [dist, P_estim11_idx, P_estim21_idx] = dtw(P_estim11, P_estim21, maxsamp);
% 
% P1_align = P_estim11(:,P_estim11_idx);
% P2_align = P_estim21(:,P_estim21_idx);
% 
% figure()
% plot(P1_align, 'r')
% hold on
% plot(P2_align, 'g')
% hold off
% legend('Song1', 'Song2')
% xlabel('Time in second')
% ylabel('Pitch of the semitone extracted')
% title('Pitch of the semitone extracted for song 1 and song 2')
%% Test second way of extraction 
figure()
plot(t1, P_estim12, 'r')
hold on
plot(t1,P_estim152, 'g')
hold off
legend('Song1', 'Song1*1.5')
xlabel('Time in second')
ylabel('Semitone extracted')
title('Semitone extracted for song 1 and song*1.5')

n =max( length(P_estim22), length(P_estim12));
[dist, P_estim12_idx, P_estim22_idx] = dtw(P_estim12, P_estim22, n);

P12_align = P_estim12(:,P_estim12_idx);
P22_align = P_estim22(:,P_estim22_idx);

figure()
plot(P12_align, 'r')
hold on
plot(P22_align, 'g')
hold off
legend('Song1', 'Song2')
xlabel('Sample (Semitone) number')
ylabel('Semitone extracted')
title('Semitone extracted for song 1 and song 2')

figure()
plot(t3,P_estim32, 'g')
xlabel('Time in second')
ylabel('Semitone extracted')
title('Semitone extracted for song 3')

%% Calculate mean distance between the song 1 and song 2
disp ('Mean distance between song 1 and song 2');
mean(sqrt((P12_align-P22_align).^2))
disp('Summed distance between song 1 and song 2');
sum(sqrt((P12_align-P22_align).^2))
%%
%%Song 1  VS song 3

n =max( length(P_estim32), length(P_estim12));
[dist, P_estim12_idx, P_estim32_idx] = dtw(P_estim12, P_estim32, n);

P12_3_align = P_estim12(:,P_estim12_idx);
P32_1_align = P_estim32(:,P_estim32_idx);

disp ('Mean distance between song 1 and song 3');
mean(sqrt((P12_3_align-P32_1_align).^2))
disp('Summed distance between song 1 and song 3');
sum(sqrt((P12_3_align-P32_1_align).^2))
%%
%Song 2 vs song 3
n =max( length(P_estim32), length(P_estim22));
[dist, P_estim22_idx, P_estim32_idx] = dtw(P_estim22, P_estim32, n);

P22_3_align = P_estim22(:,P_estim22_idx);
P32_2_align = P_estim32(:,P_estim32_idx);

disp ('Mean distance between song 2 and song 3');
mean(sqrt((P22_3_align-P32_2_align).^2))
disp('Summed distance between song 2 and song 3');
sum(sqrt((P22_3_align-P32_2_align).^2))
%%
disp ('Mean distance between song 1 and song 1.5');
mean(sqrt((P_estim12-P_estim152).^2))
disp('Summed distance between song 1 and song 1.5');
sum(sqrt((P_estim12-P_estim152).^2))

%% After noise filtering:

P1=log(frIsequence1(1,:));
R1=frIsequence1(2,:);
I1=log(frIsequence1(3,:));
    
meanI = mean(I1);
meanR = mean(R1);
noise = zeros(1, length(t1));
for i=1:length(noise)
    if ((I1(i) < meanI) & (R1(i) < meanR))|(P1(i) < mean(P1) - std(P1))|(P1(i) > mean(P1) + 0.5*std(P1)) ;
        noise(i) = 1;
    end 
end
P1_un = P1(find(noise==0));

P2=log(frIsequence2(1,:));
R2=frIsequence2(2,:);
I2=log(frIsequence2(3,:));
    
meanI = mean(I2);
meanR = mean(R2);
noise = zeros(1, length(t2));
for i=1:length(noise)
    if ((I2(i) < meanI) & (R2(i) < meanR))|(P2(i) < mean(P2) - std(P2))|(P2(i) > mean(P2) + 0.5*std(P2)) ;
        noise(i) = 1;
    end 
end
P2_un = P2(find(noise==0));

P3=log(frIsequence3(1,:));
R3=frIsequence3(2,:);
I3=log(frIsequence3(3,:));
    
meanI = mean(I3);
meanR = mean(R3);
noise = zeros(1, length(t3));
for i=1:length(noise)
    if ((I3(i) < meanI) & (R3(i) < meanR))|(P3(i) < mean(P3) - std(P3))|(P3(i) > mean(P3) + 0.5*std(P3)) ;
        noise(i) = 1;
    end 
end
P3_un = P3(find(noise==0));


ax1 = subplot(3,1,1)
plot(P1_un)
hold on
plot(P1)
hold off
xlabel('Time in seconds')
ylabel('log(Pitch) filtered in Hz') % on the logarithmic scale 
title('Pitch filtered for song 1')
ax2 = subplot(3,1,2)
plot(P2_un)
hold on
plot(P2)
hold off
xlabel('Time in seconds')
ylabel('log(Pitch) filtered in Hz')
title('Pitch filtered for song 2')
ax3 = subplot(3,1,3)
plot(P3_un)
hold on
plot(P3)
hold off
xlabel('Time in seconds')
ylabel('log(Pitch) filtered in Hz')
title('Pitch filtered for song 3')
%gca=[ax1 ax2 ax3]
%set(gca, 'YScale', 'log')
%set(gca, 'YLim', [100 300]);
