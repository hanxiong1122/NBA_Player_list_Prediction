function [ z ] = kernel_test( i,j )
%calulate the gaussian kernel of webpage i in the training dataset and j in the testing
    %dataset

    global allstarTest
    global train
    
    sigma = 50;
    
    v=train(i,:)-allstarTest(j,:);
    z=exp(-((v*v')/(sigma^2)));

end

