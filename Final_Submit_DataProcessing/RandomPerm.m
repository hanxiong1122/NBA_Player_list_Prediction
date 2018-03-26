%Randomly permute the data with duplicated player records


clear


% %Randomly Permute Allstar data
% load AllstarTeamDuplicated
% [playernum, featurenum]= size(allstar);
% 
% p = randperm(playernum);
% 
% for i = 1:playernum
%     i
%     M1(p(i),:)= allstar(i,:);
% end
% 
% save ('AllstarTeamRandperm', 'M1');

% %Randomly Permute AllLeague data
% load AllLeagueDuplicated
% [playernum, featurenum]= size(league);
% 
% p = randperm(playernum);
% 
% for i = 1:playernum
%     i
%     M2(p(i),:)= league(i,:);
% end
% 
% save ('AllLeagueRandperm', 'M2');

%Randomly Permute AllDefensive data
load AllDefensiveDuplicated
[playernum, featurenum]= size(defensive);

p = randperm(playernum);

for i = 1:playernum
    i
    M3(p(i),:)= defensive(i,:);
end

save ('AllDefensiveRandperm', 'M3');

