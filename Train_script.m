%Train HMMs 1 to 10
%% Class 1: RickRoll
[obsData, lData, testData, lTest] = GetData('Class1')
h1 = TrainClass(7,obsData,lData)
%Class 2: Countdown 
[obsData, lData, testData, lTest] = GetData('Class2')
h2 = TrainClass(7,obsData,lData)
%% Class 3: Con te partiro
[obsData, lData, testData, lTest] = GetData('Class3')
h3 = TrainClass(7,obsData,lData)
%% Class 4: Bear necessities
[obsData, lData, testData, lTest] = GetData('Class4')
h4 = TrainClass(6,obsData,lData)
%% Class 5: Hellfire
[obsData, lData, testData, lTest] = GetData('Class5')
h5 = TrainClass(5,obsData,lData)
%% Class 6: Havanna
[obsData, lData, testData, lTest] = GetData('Class6')
h6 = TrainClass(7,obsData,lData)
%% Class 7: Under the sea 
[obsData, lData, testData, lTest] = GetData('Class7')
h7 = TrainClass(6,obsData,lData)
%% Class 8:Du gamla 
[obsData, lData, testData, lTest] = GetData('Class8')
h8 = TrainClass(6,obsData,lData)
%% Class 9: Imperial march 
[obsData, lData, testData, lTest] = GetData('Class9')
h9 = TrainClass(6,obsData,lData)
%% Class 10: Twinkle little star
[obsData, lData, testData, lTest] = GetData('Class10')
h10 = TrainClass(5,obsData,lData)