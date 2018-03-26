%Duplicate player records with label 1 to achieve balanced data

clear
% load trainning_original
load testing_original

data1 = cell2mat(testingdata(:,4));
data2 = cell2mat(testingdata(:,5));
data3 = cell2mat(testingdata(:,6));

[players, features] = size(data1);





% 
% %Duplicate All star team players 16 times
duplicate=16;
for i = 1: players
    if data1(i) == 1
        for j=1:duplicate
            testingdata = [testingdata;testingdata(i,:)];
        end
    end
end

allstarTest = testingdata;
save('AllstarTeamTest', 'allstarTest');
% 
% 
% 
% 
% %Duplicate All league players 32 times
% duplicate=32;
% for i = 1: players
%     if data2(i) == 1
%         for j=1:duplicate
%             testingdata = [testingdata;testingdata(i,:)];
%         end
%     end
% end
% 
% leagueTest = testingdata;
% save('AllLeagueTest', 'leagueTest');

% 
% 
%Duplicate All defensive players 42 times
% duplicate=42;
% for i = 1: players
%     if data3(i) == 1
%         for j=1:duplicate
%             testingdata = [testingdata;testingdata(i,:)];
%         end
%     end
% end
% 
% defensiveTest = testingdata;
% save('AllDefensiveTest', 'defensiveTest'); 