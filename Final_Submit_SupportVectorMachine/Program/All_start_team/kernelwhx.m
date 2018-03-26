% Written By Hanxiong Wang
function kel = kernelwhx(ker,X,Y,gamma)
%%%linear kernel%%%%%%%%
switch ker
    case 1
        disp('linear kernel')
        kel = X*Y';
%%%%%%%%%%%%%%%%%%%%%%%%
    case 2
        disp('RBF kernel')
 n1sq = sum(X'.^2,1);
   n1 = size(X',2);
        if isempty(Y');
            D = (ones(n1,1)*n1sq')' + (ones(n1,1)*n1sq') -2*(X)*X';
        else
            n2sq = sum(Y'.^2,1);
            n2 = size(Y',2);
            D = (ones(n2,1)*n1sq)' + (ones(n1,1)*n2sq) -2*X*Y';
        end;
 kel = exp(-D*gamma);
end