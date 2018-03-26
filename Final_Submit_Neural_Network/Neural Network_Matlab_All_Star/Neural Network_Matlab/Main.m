% Final Project
% Neural Network main program for implement of predicting all star player.

clear ; close all; clc

% Setup the parameters you will use for this exercise
InputLayer  = 23;     % This is the number of features that we are using.

HiddenLayer = 46*2;   % This is the dimension of the hidden layer.

LabelNums = 2;             % We output the result as 2 labels (0 and 1). 
                            % Actually you can output only 1 label, which is 
                            % enough for our problem, but in order for
                            % further generalize to multiple features, I
                            % use "LabelNums" to represent the dim of the
                            % output layers.

% We first load train our data.
load('allstar_train_X.mat');              % This is our traing set for 23 features data for all samples.
load('allstar_train_y.mat');              % This is our label for each sample. 


% Then load our testing data.
load('TestX.mat');          % This is our testing samples with 23 features data. 
load('Testy.mat');          % This is the labels for our testing samples
m = size(X, 1);

% Below we normalized our data.
meanX = mean(X, 1);
stdX = std(X, 1);

for i = 1: size(X, 1)
    X(i, :) = (X(i, :) - meanX) ./ stdX;
end

for i = 1: size(TestX, 1)
    TestX(i, :) = (TestX(i, :) - meanX) ./ stdX;
end



% We then initialize our transition matrix between each layer. 
Theta_1_Initialized = randInitializeWeights(InputLayer, HiddenLayer);
Theta_2_Initialized = randInitializeWeights(HiddenLayer, LabelNums);


% we then unroll parameters to record the initialized theta_1 and theta_2
% matrix.
NNParameters_Initialized = [Theta_1_Initialized(:) ; Theta_2_Initialized(:)];

% Before we use the Neual Newwork, we would double check whether we make
% the derivative correct. So we compare our NN result with the finite
% difference method to compare them on a small testing set, if the
% difference is small between them, we are then confident to use NN.
lambda = 2;
GradientCheck(lambda);



%Then we start training our data.
fprintf('\nTraining Neural Network... \n')

%Initialize the regulization parameter lambda and max iteration times.
lambda = 0;
options = optimset('MaxIter', 50);

% Create "short hand" for the cost function to be minimized
costFunction = @(p) CostFunction(p, InputLayer, HiddenLayer, LabelNums, X, y, lambda);
[nn_parameters, cost] = fmincg(costFunction, NNParameters_Initialized, options);

% Keepudating our matrix Theta_1 and Theta_2 from fmincg function.
Theta1 = reshape(nn_parameters(1:HiddenLayer * (InputLayer + 1)), HiddenLayer, (InputLayer + 1));

Theta2 = reshape(nn_parameters((1 + (HiddenLayer * (InputLayer + 1))):end), LabelNums, (HiddenLayer + 1));


             
             
 
% Then after training our data, let's start testing our result.    
% First let's testing the accuracy of predictng the 0 and 1, which means we compare our results
% with the label in the Testy and get the result.
predict_label = predict(Theta1, Theta2, TestX);
fprintf('\nTesting Set Accuracy: %f\n', mean(double(predict_label == Testy)) * 100);


% Second let's testing the accuracy of predicting all league/all star players. This
% means we know the number of all league/all star players are in the Testy first (say m), then we
% output the top m results that is labelled 1 in our predicting result,
% then compare our m data with the m true all league/all star players data, and get
% the accuracy result.
Testy_predict=Testy(1:3260);
rate = prediction(Theta1, Theta2, TestX, Testy_predict);
fprintf('\nPredicting all star player Accuracy: %f\n', rate * 100);



