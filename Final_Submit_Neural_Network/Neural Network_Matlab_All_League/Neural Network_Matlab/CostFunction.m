function [J grad] = CostFunction(nn_params, input_layer_size, hidden_layer_size, num_labels, X, y, lambda)
%In this function, we try to characterize the cost function and the return
%for this function is the cost as well as the gradient update.

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% m means the number of samples in our training set X.
m = size(X, 1);
         
% We initialize our cost function and the gradient matrix. 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

%Forward process in our NN.
a1 = [ones(m, 1), X];          % a1 is the input layer, and we add 1 in front in our logistic regression. 
z2 = a1 * Theta1';             % We then use the Theta_1 to transfer a1 to z1.
a2 = sigmoid(z2);              % Then we use sigmoid funciton to calculate the value of each row in the matrix z2.
a2 = [ones(m, 1), a2];         % Then we also add 1 in front of our features in our logistic regresstion.     
z3 = a2 * Theta2';             % We use Theta_2 to transfer a2 into z3.
a3 = sigmoid(z3);              % We use again the sigmoid function to get our final result a3.

y_new = zeros(m, num_labels);
for i = 1 : m
    if y(i) == 1
        y_new(i, :) = [0, 1];
    end
    if y(i) == 0
        y_new(i, :) = [1, 0];
    end
end

%Our cost function is as follows.
J = 1.0 / m * (-sum(sum((y_new .* log(a3) + (1 - y_new) .* log(1 - a3)))) + lambda / 2.0 * (sum(sum(Theta1(:, 2: end) .^ 2)) + sum(sum(Theta2(:, 2: end) .^ 2))));


%Backward Propagation to get the gradient.
delta3 = a3 - y_new;
delta2 =  delta3 * Theta2 .*sigmoidGradient([zeros(size(z2, 1), 1) ,z2]);
delta2 = delta2(:, 2:end);
Theta2_grad = Theta2_grad+ delta3' * a2;
Theta1_grad = Theta1_grad+ delta2' * a1;

Theta1_grad = 1 / m * (Theta1_grad + lambda * [zeros(size(Theta1, 1), 1), Theta1(:, 2:end)]);
Theta2_grad = 1 / m * (Theta2_grad + lambda * [zeros(size(Theta2, 1), 1), Theta2(:, 2:end)]);



% Unroll the gradients we get.
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end