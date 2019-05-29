function h = TrainClass(nStates,obsData,lData)

B = MakeB(nStates);
h = MakeLeftRightHMM(nStates,B,obsData,lData);

end 
