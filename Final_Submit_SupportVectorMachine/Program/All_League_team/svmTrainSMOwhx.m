%written by Hanxiong Wang
%---Build the svm model by SMO algorithm
function svm = svmTrainSMOwhx(ker,X,Y,C,gamma,tol)

if nargin < 6
    tol = 1e-6; %Set the tolerance for SMO algorithm if it is not input
end

epsilon = 1e-3; % tolerance to find support vector 
kerMatrix = kernelwhx(ker,X,X,gamma); % kernel matrix

disp('smo start')        
model = smomodifiedwhxbeta(X,Y,kerMatrix,C,tol);
disp('smo end')

a= model.alpha; % all the coefficient of each trainning data
i_sv = find(abs(a)>epsilon); % find the support vector
 
%%
%---------record the information of support vector machine
svm.a = a ;
svm.i_sv = i_sv;      
svm.train_inst = X;
svm.train_label = Y;
svm.gamma=gamma;
svm.c =C;
