%Claculate Gaussian kernel for all the players in the training dataset
%save the result in K (numofplayers*numofplayers) matrix

load trainning_orig

global train

train = trainningdata;
train(:,1:8)=[];
train(:,2)=[];

[num,feature] = size(train);

K = zeros(num,num);

for i=1:num
    for j=i:num
        K(i,j)= kernel(i,j); %call the kernel function
        K(j,i)= K(i,j);      %kernel of i and j is the same of j and i
    end
    if mod(i,100)==0
        i
    end
end

save('kernel50', 'K')

