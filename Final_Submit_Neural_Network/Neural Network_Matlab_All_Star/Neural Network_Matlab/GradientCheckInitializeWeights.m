function W = GradientCheckInitializeWeights(LayerOut, LayerIn)
%We use this to generate small random data matrix for the gradient check
%purpose.

% Set W to zeros
W = zeros(LayerOut, 1 + LayerIn);

% Initialize W using "sin", this ensures that W is always of the same
% values and will be useful for debugging
W = reshape(sin(1:numel(W)), size(W)) / 10;

end