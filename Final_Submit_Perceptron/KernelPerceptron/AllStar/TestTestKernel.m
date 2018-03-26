%Kernelized Perceptron algorithm for testing
%Test the prediction of all star players
%Use the training result generated from 'MainKernel.m'
%calculate the testing accuracy
clear 
load testdata
load kernelresult50
load trainning_orig

global train

train = trainningdata;
train(:,1:8)=[];
train(:,2)=[];

global allstarTest


allstarTest= testingdata1;
allstarTest(:,1:5)=[];

alpha = A(10,:);
b = B(10);
m = length(alpha);


[numoftest, ~] = size(allstarTest);    %testing sample size

error = 0;
duplicate = 15;
dist = zeros(2,numoftest);


for i = 1:numoftest
    i
    label = testingdata1(i,3);
    distance = b;
    for k=1:m 
        distance = distance + alpha(k)*kernel_test(k,i); %call the 'kernel_test' function
        dist(1,i)= distance;          %The first row of the matrix recods the distance value
        dist(2,i)= testingdata1(i,3);  %The second row of the matrix records the ture lable
    end
      if label == 0
         label = -1;
        if distance>=0;  % call 'classify' function
            error = error +1;
        end
      end
      if label ==1
        numoftest = numoftest+duplicate;
        if distance<0; % call 'classify' function
            error = error +duplicate + 1;
            
        end
      end
    error
end



%accuracy on the testing dataset
accuracy = 1- error/numoftest;

fprintf('\nFinal Testing Set Accuracy: %f\n', accuracy);



%Accuracy for predicting the all star players
%which is caculated as follows:
%Predicting all star players accuracy = total number of players predicted
%to be all star who is truely an all star player/total number of true
%allstar players in test dataset

% save('dist1', 'dist');

% load dist1
correct = 0;
numofallstar = 173;              %Total number of true all star players in the test dataset

for j = 1:numofallstar*2
    [~,index] = max(dist(1,:));  %Find the index of the lagest distance value 
    dist(1,index) = -100000;       %Set the alreday chosen player's distance value to a very small value
    if testingdata1(index,3)==1   %Check if the player is truely all star player
        correct = correct +1;
    end 
end

accuracy_pool = correct/numofallstar;
fprintf('\nFinal All Star Players Prediction Accuracy: %f\n: %f\n', accuracy_pool);