function B = MakeB(nStates)
B = [];
for k=0:nStates-1
b = GaussD('Mean', k, 'StDev', 0.5); 
B =[B, b];
end