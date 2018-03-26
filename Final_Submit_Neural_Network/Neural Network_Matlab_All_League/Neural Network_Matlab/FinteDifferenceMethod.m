function numgrad = FiniteDifferenceMethod(J, theta)
% We use the Finite Different Method to calculate the gradient for our
% checking NN gradient purpose.

numgrad = zeros(size(theta));
range = zeros(size(theta));
e = 1e-4;
for p = 1:numel(theta)
    % Set perturb vector
    range(p) = e;
    change1 = J(theta - range);
    change2 = J(theta + range);
    % Compute Numerical Gradient
    numgrad(p) = (change2 - change1) / (2*e);
    range(p) = 0;
end

end