% Successive_over_relaxation (SOR) method 
% solving system of linear equation

% to find the optimum value of ω and solving the system with optimum ω

A=input("Enter the co-efficient matrix: ");
b=input("Enter the value of the vector b: ");
x_0= input("Enter the inital guess:" );

D=diag(diag(A));
L=tril(A,-1);
U=triu(A,1);
count=0;
T_j = inv(D)*(L+U);
p = max(abs(eig(T_j)));
w = 2/(1+sqrt(1-p^2));
err = inf;

while(err>10^-6)
    x_1=inv(D+w*L)*((w*b)-(w*U+(w-1)*D)*x_0);
    err=norm(x_1-x_0)/norm(x_1);
    count=count+1;
    x_0=x_1;
end

% To solve Ax = b given an initial approximation x(0) with given ω

w = 1.1 ;

D=diag(diag(A));
L=tril(A,-1);
U=triu(A, 1);
count = 0;
err = inf;
x_1=x_0 ;

while(err > 10^-6)
    x_1=(1-w)*x_0+ w*inv(D)*(B-(L*x_1 + U*x_0));
    err = norm(x_1- x_0)/norm(x_1);
    count = count+1;
    x_0 = x_1;
end

