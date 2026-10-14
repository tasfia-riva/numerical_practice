% fixed point iteration
% root finding method

clc
clear 

f=@(x)1-x^2;
x0=1;
tol=1e-6;
max_iter=200;

for n=1:max_iter
    x1=f(x0);
    fprintf('%2d\t %f\n', n, x1);
    if abs(x1-x0)<=tol
        fprintf('\n Converged after %d iteration.',n);
        fprintf('\n Approximate solution: x= %f\n', x1);
        break
    end
    x0=x1;
end
if n==max_iter
    fprintf('Maximum iteration number has reached')
end