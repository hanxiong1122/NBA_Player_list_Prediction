% Written by Hanixong Wang

clear
%%
%--load player's data and All league team label for trainning and testing-%
load('AllLeagueRandperm.mat');
load('AllLeagueTest');
%%
%----------transfer the data into training part and tesing part----------%
train_label = cell2mat(M2(:,5));
train_label = (train_label - 0.5)*2;
train_inst = cell2mat(M2(:,[9,(11:1:34)]));

test_label = cell2mat(leagueTest(:,5));
test_label = (test_label - 0.5)*2;
test_inst = cell2mat(leagueTest(:,[9,(11:1:34)]));
%%
%------------normalize the data------------------------------------------%
[train_inst,pstrain] = mapminmax(train_inst');
pstrain.ymin = 0;
pstrain.ymax = 1;
[train_inst,pstrain] = mapminmax(train_inst,pstrain);

[test_inst,pstest] = mapminmax(test_inst');
pstest.ymin = 0;
pstest.ymax = 1;
[test_inst,pstest] = mapminmax(test_inst,pstest);

train_inst = train_inst';
test_inst = test_inst';

test2_inst = test_inst(1:3260,:);
test2_label = test_label(1:3260,:);
%%
%------------initialize some parameter in c-SVM method-------------------%

epsilon =1e-4; % tolerance for SMO algorithm
kerType =2;    % kernel type, 1 for linear kernel, 2 for Radial Basis Function(RBF) kernel
 
cmin  = 0.1;   % start point for c
cmax  = 1.5;   % end point for c
cstep = 0.1;   % stepsize for c

gmin = 0.1;    % start point for gamma
gmax = 1;      % end point for gamma
gstep = 0.05;  % stepsize for gamma 

%%
%----------build the model and predict the testing data-----------------%
% SVMcgSearch is trying to find the best c and gamma(for RBF kernel)
[bestacc,bestc,bestg,cg] = SVMcgSearch(kerType,train_inst,train_label,...
test_inst,test_label,cmin,cmax,gmin,gmax,cstep,gstep,epsilon);


% Now train the data by the best c and gamma we find
model = svmTrainSMOwhx(kerType,train_inst,train_label,bestc,bestg,epsilon);

% predict the test data and record the dicision value meanwhile
[predicted_label,Accuracy_raw,decision_value] = svmPredictwhx(kerType,model,test_inst,test_label);

% sort the decision value so that we can define the possible All start
% player in the real pool
[value, order] = sort(decision_value(1:3260,:),'descend');
%%
%------------------------result----------------------------------------%
total_one_num = 0;
correct_one_num = 0;
correct_one_num2 = 0;

% get the real number of all star players in the test data in the pool
for i=1:length(test_label(1:3260,:))
    if (test_label(i)==1)
        total_one_num = total_one_num + 1;
    end
end

% get the correct number in the pool
for i=1:total_one_num
    if (test_label(order(i)) ==1)
        correct_one_num = correct_one_num +1;
    end
end

% get the correct number in the new large pool(we double the amount of the pool)
for i=1:total_one_num*2
    if (test_label(order(i)) ==1)
        correct_one_num2 = correct_one_num2 +1;
    end
end

% pool accurate
Accuracy_pool = correct_one_num/total_one_num;
% large pool accurate
Accuracy_largepool = correct_one_num2/total_one_num;

switch kerType
    case 1
        save All_league__Lin_test bestc Accuracy_raw Accuracy_pool Accuracy_largepool
    case 2
        save All_league__Rbf_test bestc bestg Accuracy_raw Accuracy_pool Accuracy_largepool
end