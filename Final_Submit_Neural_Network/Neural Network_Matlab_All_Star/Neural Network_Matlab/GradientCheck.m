function GradientCheck(lambda)
% We do the gradient check by this function.

if ~exist('lambda', 'var') || isempty(lambda)
    lambda = 0;
end

%Since the finite difference method is slow, we do not want to check the
%result for all our data, therefore, we only test a small set of data just
%to verify our accuracy of NN forward propagation process.
InputLayer = 3;
HiddenLayer = 5;
LabelNums = 2;
m = 5;

% We first create some small set of random data.
Theta1 = GradientCheckInitializeWeights(HiddenLayer, InputLayer);
Theta2 = GradientCheckInitializeWeights(LabelNums, HiddenLayer);
% Reusing GradientCheckInitializeWeights to generate X
X  = GradientCheckInitializeWeights(m, InputLayer - 1);
y  = 1 + mod(1:m, LabelNums)';

% Unroll parameters
NNParameters = [Theta1(:) ; Theta2(:)];

% Short hand for cost function
costFunc = @(p) CostFunction(p, InputLayer, HiddenLayer, ...
                               LabelNums, X, y, lambda);

[cost, grad] = costFunc(NNParameters);
FND_Gradient = FinteDifferenceMethod(costFunc, NNParameters);

% Visually examine the two gradient computations.  The two columns
% you get should be very similar. 
% disp([FND_Gradient grad]);

% Evaluate the norm of the difference between two solutions.  
% If you have a correct implementation, and assuming you used EPSILON = 0.0001 
% in FiniteDifferenceMethod.m, then diff below should be less than 1e-9
diff = norm(FND_Gradient-grad)/norm(FND_Gradient+grad);

fprintf('The difference between NN and the Finite Different Method is  %g\n' , diff);

end