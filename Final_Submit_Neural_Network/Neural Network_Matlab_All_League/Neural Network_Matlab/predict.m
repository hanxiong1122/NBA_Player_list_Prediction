function p = predict(Theta1, Theta2, X)
%We use this function to get our prediction of the label 0 and 1 in our
%test set.


% m is the size of the input sample matrix X.
m = size(X, 1);
%num_labels = size(Theta2, 1);

% We initialize our output predicting matrix p first.
p = zeros(size(X, 1), 1);

h1 = sigmoid([ones(m, 1) X] * Theta1');
h2 = sigmoid([ones(m, 1) h1] * Theta2');
[dummy, p] = max(h2, [], 2);  % We compare each row of the 2 columns, and find the bigger one.

%Our output p above is the column number 1 and 2, which corresponding to
%label 0 and 1, thus we reduce 1 to p so that we get the predicting label.
p = p - 1;


end