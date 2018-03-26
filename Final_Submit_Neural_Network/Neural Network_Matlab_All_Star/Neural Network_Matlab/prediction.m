function rate = prediction(Theta1, Theta2, X, Testy_predict)
% In this fucntion, we try to output our estimation of the all league/ all
% star player and calculate the accuracy of the number of all league/ all
% star player we get.

m = size(X, 1); 
%num_labels = size(Theta2, 1);

total_1=sum(Testy_predict);  % This is the number of players we want to output,
                             % for example, you can output the exact number
                             % of players or you can enlarge the pool we
                             % output, the larger you make, the more
                             % accuracy you will get, since more and more
                             % players you predict will match the players
                             % from the true all star/ all league players.
                             
total_2=sum(Testy_predict);  % This is the number of true all star / all league players.

% We initialize our data first.
p = zeros(size(X, 1), 1);

h1 = sigmoid([ones(m, 1) X] * Theta1');
h2 = sigmoid([ones(m, 1) h1] * Theta2');
[dummy, p] = max(h2, [], 2);


% We only consider the first 3260 row since all the data after 3260 rows
% are the replicate data, which will not be useful in this prediction.
h2=h2(1:3260,:);
p = p - 1;
p=p(1:3260);


result=[h2,p];                    % We append the matrix h2 and p
id=find(result(:,3)==0);          % We grasp the row that we estimate to be 0.
result(id,2)=-1;                  % We make the second column of all the row with label 0 to be -1, and the reason is that
                                  % when we order the number of column 2,
                                  % we want all these with label 0 to be
                                  % far at the back, because we do not want
                                  % to select them.
                                                                            
                                            
[alpha,beta]=sort(result(:,2),'descend'); % Beta record the index of the result such that the second column in h2 is in descend order

beta_allstar=beta(1:total_1);             % We grasp the first total_1 number of data, which is our prediction of all star/all league.

check_label_1=Testy_predict(beta_allstar);% We get the corresponding row label that we predict from the true all star/all league data.
true_number=sum(check_label_1);           % We check how many of them are predicted to be all star/all league.
rate=true_number/total_2;                 % We get the accuracy.


end