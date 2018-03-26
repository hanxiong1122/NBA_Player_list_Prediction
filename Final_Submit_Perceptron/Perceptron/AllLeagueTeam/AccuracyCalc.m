function [ accuracy ] = AccuracyCalc( w,b,leaguetest )
%Caculate the accuracy for predicting all league team players
%Select the 100(total num of all league team players in test dataset) 
%players with largest distances values as the predicted all league team players
%Count the number of players among those 100 predicted players who are true
%all league players in the testing dataset, denoted by "correct".
%Accuracy = correct/total num of all league team players


leagueTest= leaguetest;
leagueTest(:,1:8)=[];
leagueTest(:,2)=[];

testsize = 3260;


dist = zeros(2,testsize);   %Initialize a matrix to record the distance and the true label


for i = 1:testsize
    distance = dot(leagueTest(i,:),w)+b; 
    dist(1,i)= distance;          %The first row of the matrix records the distance value
    dist(2,i)= leaguetest(i,5);  %The second row of the matrix records the ture lable
end

% save('dist', 'dist');

correct = 0;
numofallleague = 100;              %Total number of true all league team players in the test dataset

for j = 1:numofallleague*2
    [~,index] = max(dist(1,:));  %Find the index of the lagest distance value 
    dist(1,index) = -1000;       %Set the alreday chosen player's distance value to a very small value
    if leaguetest(index,5)==1   %Check if the player is truely all league team player
        correct = correct +1;
    end 
end

accuracy = correct/numofallleague;
