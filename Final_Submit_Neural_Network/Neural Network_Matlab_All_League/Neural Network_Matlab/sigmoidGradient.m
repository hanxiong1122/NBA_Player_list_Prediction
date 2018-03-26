function g = sigmoidGradient(z)
% Get the gradient we need from sigmoid funcion.

g = zeros(size(z));
g = sigmoid(z) .* (1 - sigmoid(z));

end