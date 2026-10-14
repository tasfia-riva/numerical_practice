% gauss-seidel method for solving system of linear equation

A = input ('Enter the coefficient matrix A: ');
B = input ('Enter the constant matrix B: ');
tol= input('\n Enter the tolerance of error: ');

N=length(B);
n=500;
P = zeros(N,1);
x=zeros(N,1);
y=zeros(N,1);

for j=1:n
    for i= 1:N
        x(i)=(B(i)/A(i,i))-(A(i,[1:i-1,i+1:N])*P([1:i
            1,i+1:N]))/A(i,i);
        P(i)=x(i);
    end
    if norm(y-x)/norm(y)<tol
        break
    end
    y=x;
end