% jacobi method for system of linear equations Ax=B

A = input ('Enter the coefficient matrix A: ');
B = input ('Enter the constant matrix B: ');
tol= input('\n Enter the tolerance of error: ');

N=length(B);
n=50;
P = zeros(N,1);
x=zeros(N,1);

for j=1:n
    for i= 1:N
        x(i)=(B(i)/A(i,i))-(A(i,[1:i-1,i+1:N])*P([1:i
            1,i+1:N]))/A(i,i);
    end
    if norm(x-P)/norm(x)<tol
        break
    end
    P=x;
end