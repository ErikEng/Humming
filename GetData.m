function [obsData, lData, testData, lTest] = GetData(ClassName)
%Init
obsData = [];
lData=[];
testData=[];
lTest=[];
%Get the files and partition them
Files=dir(ClassName);
TrueFiles = Files(3:length(Files),:)
crossVal = cvpartition(15,'HoldOut',0.3);
idx = crossVal.test;
trainFiles = TrueFiles(~idx,:);
testFiles  = TrueFiles(idx,:);

% Store the training sequences 
for k=1:length(trainFiles)
    disp(trainFiles(k).name);
    path_to_file = strcat(ClassName,'/',trainFiles(k).name);
    [s, fs] = audioread(path_to_file);
    [frIsequence] = GetMusicFeatures(s,fs,0.03);
    t = GetT(frIsequence);
    [frIsequenceOut] = Postprocess(frIsequence,t);
    %plot(frIsequenceOut(1,:))
    %hold on
    obsData = [obsData frIsequenceOut];
    lData = [lData size(frIsequenceOut,2)];
end
for k=1:length(testFiles)
    %disp('TestData');
    disp(testFiles(k).name);
    path_to_file = strcat(ClassName,'/',testFiles(k).name);
    [s, fs] = audioread(path_to_file);
    [frIsequence] = GetMusicFeatures(s,fs,0.03);
    t = GetT(frIsequence);
    [frIsequenceOut] = Postprocess(frIsequence,t);
    testData = [testData frIsequenceOut];
    lTest = [lTest size(frIsequenceOut,2)];
end

end 