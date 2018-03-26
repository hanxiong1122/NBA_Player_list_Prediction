% Perceptron main program for predicting all league team players.
 
clear
load leaguetrain         %Load the training dataset
load leaguetest          %Load the testing dataset

league= leaguetrain;
league(:,1:5)=[];     %clear the dataset (delete the columns that are not features for training)

[players, numoffeature]=size(league);


%initialize the parameters (weight vector 'w' and b) to be zero
w = zeros(1,numoffeature);
b = 0;
%set the learningrate
learningrate = 0.01;

T = 39; %Times of passing over the data


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Trainning 

for n = 1:T
for i = 1: players    
    label = leaguetrain(i,4);
    if label == 0
        label = -1;  %change the label 0 to -1 for the update of parameters
    end
    if label ~= classify(league(i,:),w, b); %call 'classify' function
        %update of w and b when there is a mistake
        w = w + learningrate * label * league(i,:);
        b = b + learningrate * label;
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Testing 

leagueTest= leaguetest;
leagueTest(:,1:8)=[];
leagueTest(:,2)=[];       %clear the testing data (delete the columns that are not features for testing)

[num, lengh] = size(leagueTest);  

error = 0;

for i = 1: num    
    label = leaguetest(i,5);   
    
    if label == 0
        label = -1;
    end
    
    if label ~= classify(leagueTest(i,:),w, b);  % call 'clssify' function
        error = error +1;
    end
  
end
%Accuracy for predicting the correct label for each player
Iteration(n) =n;
Accuracy(n) = 1- error/num;

fprintf('\nNumber of Iteration: %i', n );
fprintf('\nTesting Accuracy: %f\n', Accuracy(n));


end


fprintf('\nFinal Testing Set Accuracy: %f\n', Accuracy(T));


%Accuracy for predicting the all league team players
%which is caculated as follows:
%Predicting all league team players accuracy = total number of players predicted
%to be all league team player who is truely an all league team player/total number of true
%all league team players in test dataset


AllLeagueTeamAccuracy = AccuracyCalc(w,b,leaguetest);
fprintf('\nFinal All League Team Players Prediction Accuracy: %f\n', AllLeagueTeamAccuracy);
