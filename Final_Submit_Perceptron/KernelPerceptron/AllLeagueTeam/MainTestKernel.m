%Kernelized Perceptron algorithm for testing
%Test the prediction of all league team players
%Use the training result generated from 'MainKernel.m'
%calculate the testing accuracy
clear
load testdata
load kernelresult50_2
load trainning_orig

global train

train = trainningdata;
train(:,1:8)=[];
train(:,2)=[];

global leagueTest


leagueTest= testingdata1;
leagueTest(:,1:5)=[];

alpha = A(10,:);
b = B(10);
m = length(alpha);

[numoftest, ~] = size(leagueTest);    %testing sample size

error = 0;
duplicate = 31;
dist = zeros(2,numoftest);

for i = 1:numoftest
    i
    label = testingdata1(i,4);
    distance = b;
    for k=1:m 
        distance = distance + alpha(k)*kernel_test_league(k,i); %call the 'kernel_test_league' function
        dist(1,i)= distance;          %The first row of the matrix recods the distance value
        dist(2,i)= testingdata1(i,4);  %The second row of the matrix records the ture lable
    end
      if label == 0
         label = -1;
        if distance>=0;  
            error = error +1;
        end
      end
      if label ==1
        numoftest = numoftest+duplicate;
        if distance<0;  
            error = error +duplicate + 1;
            
        end
      end
    
    error
end



%accuracy on the testing dataset
accuracy = 1- error/numoftest;

fprintf('\nFinal Testing Set Accuracy: %f\n', accuracy);

%Accuracy for predicting the all league team players
%which is caculated as follows:
%Predicting all star players accuracy = total number of players predicted
%to be all star who is truely an all star player/total number of true
%allstar players in test dataset

% save('dist2', 'dist');

% load dist2
correct = 0;
numofleague = 100;              %Total number of true all league team players in the test dataset

for j = 1:numofleague*2
    [~,index] = max(dist(1,:));  %Find the index of the lagest distance value 
    dist(1,index) = -100000;       %Set the alredy chosen player's distance value to a very small value
    if testingdata1(index,4)==1   %Check if the player is truely all league team player
        correct = correct +1;
    end 
end

accuracy_pool = correct/numofallstar;
fprintf('\nFinal All League Team Players Prediction Accuracy: %f\n: %f\n', accuracy_pool);