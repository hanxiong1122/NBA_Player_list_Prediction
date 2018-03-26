function [ z ] = kernel_test_league( i,j )
%calulate the gaussian kernel of plaer i in the training dataset and j in the testing
    %dataset

    global leagueTest
    global train
    
    sigma = 50;
    
    v=train(i,:)-leagueTest(j,:);
    z=exp(-((v*v')/(sigma^2)));

end

