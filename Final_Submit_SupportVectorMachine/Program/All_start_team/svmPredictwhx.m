% Written by hanxiong Wang
%% Predict the testingdata

function [predicted_label,accuracy,decision_value] = svmPredictwhx(ker,svm,test_inst,test_label)

train_inst = svm.train_inst;
train_label = svm.train_label;
i_sv = svm.i_sv;
a = svm.a;
gamma = svm.gamma;
%%
%-------------calculate the intercept b----------%
tmp = (a'.*train_label')*kernelwhx(ker,train_inst,train_inst(i_sv,:),gamma);  % 
tmp = tmp';
b = 1./train_label(i_sv)-tmp;
b = mean(b);% 
tmp =  (a'.*train_label')*kernelwhx(ker,train_inst,test_inst,gamma);  % 
tmp = tmp';
%-------calculate the decision value and make the prediction-------%
decision_value = tmp + b;
predicted_label = sign(tmp+b);  %  
%-------calculate the accuracy--------------------------------------%
if nargin < 3
    accuracy =[] ;
else
    correct_num =0;
    for i =1: length(test_label)
         if test_label(i)==predicted_label(i)
            correct_num = correct_num+1;
         end
    end
    accuracy = correct_num/length(test_label);
end