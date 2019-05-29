clear;
%addpath ('Datasets/cifar-10-batches-mat/');

%Store data for training, evaluation and test:
[trainX, trainY, trainy] = LoadBatch('Datasets/cifar-10-batches-mat/data_batch_1.mat');
[evalX, evalY, evaly] = LoadBatch('Datasets/cifar-10-batches-mat/data_batch_2.mat');
[testX, testY, testy] = LoadBatch('Datasets/cifar-10-batches-mat/test_batch.mat');

%Init W and b: 
[d,N]= size(trainX);
[K,N]= size(trainY);

W= randn(K,d)*0.01;
b= randn(K,1)*0.01;
lambda = 0;

% Run EvaluateClassifier on a subset of the training data 
P = EvaluateClassifier(trainX(:, 1:100), W, b);

% Debug and check gradient computations

[ngrad_b, ngrad_W] = ComputeGradsNumSlow(trainX(:,1:20 ), trainY(:,1:20), W, b, lambda, 1e-6);
P = EvaluateClassifier(trainX(:,1:20), W, b);
[grad_W, grad_b] = ComputeGradients(trainX(:, 1:20 ), trainY(:,1:20),P, W, lambda);

diff_b = mean(abs(grad_b - ngrad_b)./max(eps, abs(grad_b) + abs(ngrad_b)))
diff_W = mean(mean(abs(grad_W - ngrad_W)./max(eps, abs(grad_W) + abs(ngrad_W))))

% Experiment
GDparams = [100, 0.01, 20];
trainJ = zeros(1, GDparams(3));
evalJ = zeros(1, GDparams(3));
for i = 1 : GDparams(3)
    trainJ(i) = ComputeCost(trainX, trainY, W, b, lambda);
    evalJ(i) = ComputeCost(evalX, evalY, W, b, lambda);
    [W, b] = MiniBatchGD(trainX, trainY, GDparams, W, b, lambda);
end

trainAcc = ComputeAccuracy(trainX, trainy, W, b);
disp(['Accuracy computed on the training data:' num2str(trainAcc*100) '%'])
testAcc = ComputeAccuracy(testX, testy, W, b);
disp(['Accuracy computed on the test data:' num2str(testAcc*100) '%'])

figure()
plot(1 : GDparams(3), trainJ, 'g')
hold on
plot(1 : GDparams(3), evalJ, 'r')
hold off
xlabel('Epoch');
ylabel('Loss');
legend('Training loss', 'Validation loss');


for i = 1 : 10
im = reshape(W(i, :), 32, 32, 3);
s_im{i} = (im - min(im(:))) / (max(im(:)) - min(im(:)));
s_im{i} = permute(s_im{i}, [2, 1, 3]);
end
figure()
montage(s_im, 'size', [1, 10])

%% Functions written 
% LoadBatch
function [X, Y, y] = LoadBatch(filename)
%Input: filename 
%Output: X is dxN 
%        Y is KxN
%        y is 1xN
data_im = load(filename);
X = double(data_im.data')/255; 
y = double(data_im.labels') + 1;

k = length(unique(y));
n = length(y);
Y = zeros(k, n);
for i = 1 : n
    Y(y(i), i) = 1;
end

end
%EvaluateClassifier
function P = EvaluateClassifier(X, W, b)
% Input: X : dxN
%        W : Kxd
%        b : Kx1
% Output: P : KxN

b = repmat(b, 1, size(X, 2));
s = W*X + b;
den = ones(10,1)*(sum(exp(s), 1));
P= exp(s)./den;
end
%Compute Accuracy 
function acc = ComputeAccuracy(X, y, W, b)
% Input: X : dxN
%        y : 1xN
%        W : Kxd
%        b : Kx1
% 
% Output: acc : 1x1

P = EvaluateClassifier(X, W, b);
[prop, index] = max(P); % If A is a matrix, then max(A) is a row vector containing the maximum value of each column.
acc = length(find(y - index == 0))/length(y);
end
%ComputeCost
function J = ComputeCost(X, Y, W, b, lambda)
% Input: X : dxN
%        Y : KxN
%        W : Kxd
%        b : Kx1
%        lambda : Kx1
% Output: J : 1x1

P = EvaluateClassifier(X, W, b);
loss = sum(diag(-log(Y'*P)))/size(X, 2);  %to get the loss between the predicton and the corresponding label
reg = lambda*sum(sum(W.^2));
J = loss + reg;

end
%ComputeGradients
function [grad_W, grad_b] = ComputeGradients(X, Y, P, W, lambda)
% Input: X : dxN
%        Y : KxN
%        W : Kxd
%        b : Kx1
%        lambda : Kx1
% Output: grad_W : Kxd
%         grad_b : Kx1

[K,d] = size(W);
[d,N] = size(X);
grad_W = zeros(K,d);
grad_b = zeros(K,1);

for i = 1:N
    g = -Y(:, i)'*(diag(P(:, i)) - P(:, i)*P(:, i)')/(Y(:, i)'*P(:, i));
    grad_b = grad_b + g';
    grad_W = grad_W + g'*X(:, i)';
end


grad_b = grad_b/N;
grad_W = 2*lambda*W + grad_W/N;


end
%MiniBatchGD
function [Wstar, bstar] = MiniBatchGD(X, Y, GDparams, W, b, lambda)
%Input: X: d*N
%     : Y: K*N
%     : GDparams: 3*1       
%     : W: K*d
%     : b: K*1
%     : lambda: 1*1
%Output: Wstar: K*d
%        bstar: K*1

n_batch = GDparams(1);
eta = GDparams(2);
n_epochs = GDparams(3);
[d,N] = size(X)

for j = 1 : N/n_batch
    j_start = (j - 1)*n_batch + 1;
    j_end = j*n_batch;
    inds = j_start : j_end;
    Xbatch = X(:, inds);
    Ybatch = Y(:, inds);
    
    P = EvaluateClassifier(Xbatch, W, b);
    [grad_W, grad_b] = ComputeGradients(Xbatch, Ybatch, P, W, lambda);
    
    W = W - eta*grad_W;
    b = b - eta*grad_b;
end

Wstar = W;
bstar = b;

end