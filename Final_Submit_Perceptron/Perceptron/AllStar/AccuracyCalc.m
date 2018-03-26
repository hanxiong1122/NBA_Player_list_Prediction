function [ accuracy ] = AccuracyCalc( w,b,allstartest )
%Caculate the accuracy for predicting all star players
%Select the 173(total num of all star players) players with largest distances 
%values as the predicted all star players
%Count the number of players among those 173 predicted players who are true
%all star players in the testing dataset, denoted by "correct".
%Accuracy = correct/total num of all star players


allstarTest= allstartest;
allstarTest(:,1:8)=[];
allstarTest(:,2)=[];

testsize = 3260;


dist = zeros(2,testsize);   %Initialize a matrix to record the distance and the true label


for i = 1:testsize
    distance = dot(allstarTest(i,:),w)+b; 
    dist(1,i)= distance;          %The first row of the matrix recods the distance value
    dist(2,i)= allstartest(i,4);  %The second row of the matrix records the ture lable
end

% save('dist', 'dist');

correct = 0;
numofallstar = 173;              %Total number of true all star players in the test dataset

for j = 1:numofallstar*2
    [~,index] = max(dist(1,:));  %Find the index of the lagest distance value 
    dist(1,index) = -1000;       %Set the alreday chosen player's distance value to a very small value
    if allstartest(index,4)==1   %Check if the player is truely all star player
        correct = correct +1;
    end 
end

accuracy = correct/numofallstar;
