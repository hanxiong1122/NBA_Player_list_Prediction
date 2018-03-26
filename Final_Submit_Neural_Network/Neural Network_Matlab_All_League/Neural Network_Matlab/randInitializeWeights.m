function W = randInitializeWeights(LayerIn, LayerOut)
% We get the initialized weight for Theta_1 and Theta_2.

% Initialize the data first.
W = zeros(LayerOut, 1 + LayerIn);

% The number epsilon_init is chosen to be \frac{\sqrt(t)}{sqrt(LayerIn+LayerOut)}
epsilon_init = 0.2284;

% We get the random matrix.
W = rand(LayerOut, 1 + LayerIn) * 2 * epsilon_init - epsilon_init;

end