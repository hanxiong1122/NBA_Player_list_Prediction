% Perceptron main program for predicting all star players.
 
clear
load allstartrain      %Load the training dataset
load allstartest          %Load the testing dataset

allstar= allstartrain;
allstar(:,1:5)=[];     %clear the dataset (delete the columns that are not features for training)

[players, numoffeature]=size(allstar);


%initialize the parameters (weight vector 'w' and b) to be zero
w = zeros(1,numoffeature);
b = 0;
%set the learningrate
learningrate = 0.01;

T = 37; %Times of passing over the data


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Trainning 

for n = 1:T
for i = 1: players    
    label = allstartrain(i,3);
    if label == 0
        label = -1;  %change the label 0 to -1 for the update of parameters
    end
    if label ~= classify(allstar(i,:),w, b); %call 'classify' function
        %update of w and b when there is a mistake
        w = w + learningrate * label * allstar(i,:);
        b = b + learningrate * label;
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Testing 

allstarTest= allstartest;
allstarTest(:,1:8)=[];
allstarTest(:,2)=[];       %clear the testing data (delete the columns that are not features for testing)

[num, lengh] = size(allstarTest);  

error = 0;

for i = 1: num    
    label = allstartest(i,4);   
    
    if label == 0
        label = -1;
    end
    
    if label ~= classify(allstarTest(i,:),w, b);  % call 'clssify' function
        error = error +1;
    end
  
end
%Accuracy for predicting the correct label for each player
Iteration(n) =n;
Accuracy(n) = 1- error/num;

fprintf('\nNumber of Iteration: %i', n );


end


% plot(Iteration, Accuracy)
fprintf('\nFinal Testing Set Accuracy: %f\n', Accuracy(T));


%Accuracy for predicting the all star players
%which is caculated as follows:
%Predicting all star players accuracy = total number of players predicted
%to be all star who is truely an all star player/total number of true
%allstar players in test dataset


AllStarAccuracy = AccuracyCalc(w,b,allstartest);
fprintf('\nFinal All Star Players Prediction Accuracy: %f\n', AllStarAccuracy);
