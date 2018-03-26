% Written by Hanxiong Wang
% SVMcgSearch, this function use to find the best parameter for svm model
% by grid search
function [bestacc,bestc,bestg,cg] = SVMcgSearch(ker,train_inst,train_label,test_inst,test_label,cmin,cmax,gmin,gmax,cstep,gstep,epsilon)
%% X:c Y:g cg:acc build the grid
[X,Y] = meshgrid(cmin:cstep:cmax,gmin:gstep:gmax);
[m,n] = size(X);
cg = zeros(m,n); % pair of points

%% record acc with different c & g,and find the bestacc with the smallest c
bestc = 0;
bestg = 0;
bestacc = 0;
basenum = 2;%used for large-scale search, we did not use here
%%
%loop all the iteration to find the best c and best gamma if thers is RBF kernel used
for i = 1:m
    for j = 1:n        
        model = svmTrainSMOwhx(ker,train_inst,train_label,X(i,j),Y(i,j),epsilon);% Build the model and find the accuracy
        [~,accuracy,~] = svmPredictwhx(ker,model,test_inst,test_label);    
        cg(i,j) = accuracy;    
        if cg(i,j) > bestacc
            bestacc = cg(i,j);
            bestc = X(i,j);
            bestg = Y(i,j);
            %bestc = basenum^X(i,j);
            %bestg = basenum^Y(i,j);
        end

        if ( cg(i,j) == bestacc && bestc > X(i,j) )    
            bestacc = cg(i,j);
            bestc = X(i,j);
            bestg = Y(i,j);
            %bestc = basenum^X(i,j);
            %bestg = basenum^Y(i,j);
        end
        
    end
end

