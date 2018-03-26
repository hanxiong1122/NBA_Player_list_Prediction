function g = sigmoid(z)
%Caucluate the sigmoid function.


g = 1.0 ./ (1.0 + exp(-z));
end