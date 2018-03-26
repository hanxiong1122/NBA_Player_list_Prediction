%Kernelized Perceptron algorithm for training
%Predict all star players
%the training result: vector 'alpha' and 'b' are saved in 'kernelresult*'
clear
load allstartrain
load kernel50    %pre-caculated gaussian kernel. See 'KernelPreCalc.m' for detail.
                 %Did not upload this file because its size is 1.2GB

allstar= allstartrain;
allstar(:,1:5)=[];

global K          %pre-caculated gaussian kernel

[players, numoffeature]=size(allstar);
[num,~]=size(K);


%parameter initialization
b = 0;
alpha = zeros(1,num);
%update value of b 
learningrate = 0.5;

T = 20;     % num of times passing over the training dataset

for n = 1:T
    n
error = 0;
for i = 1:players
    
    label = allstartrain(i,3);
    j=allstartrain(i,1);
     
    if label == 0
        label = -1;
    end
    if label ~= kernelclassify(j,alpha,b) %call 'kernelclassify' function
        %update of alpha and b
        alpha(j) = alpha(j)+label;
        b = b + learningrate*label;
        error = error +1;
    end
end





error
%accuracy on the training dataset
accuracy_train = 1- error/players
A(n,:)=alpha;
B(n)=b;
Accuracy(n)=accuracy_train;

end

save('kernelresult50','A','B','Accuracy')
