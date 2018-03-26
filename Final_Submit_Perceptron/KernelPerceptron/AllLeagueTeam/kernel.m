function [ z ] = kernel( i,j )
    %calulate the gaussian kernel of player i and j in the training
    %dataset
    
global train
    
 
    
    sigma = 50;
    
    v=train(i,:)-train(j,:);
    z=exp(-((v*v')/(sigma^2)));
    
end

