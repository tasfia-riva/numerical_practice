% finite difference method
% Problem parameters
L  = 1;          % Length 
N  = 7;        % Total nodes
Y0 = 0;        % Left boundary 
Y1 = 1;        % Right boundary 

dx = L/(N-1);

Ni = N - 2;      % Number of internal nodes

% Initialize matrix and RHS
A = zeros(Ni, Ni);
B = zeros(Ni, 1);

% Build coefficient matrix using loop
for i = 1:Ni
    A(i,i) = -(3*dx*dx) -2;                 % Main diagonal
    
    if i > 1
        A(i,i-1) = 1;            % Lower diagonal
    end
    
    if i < Ni
        A(i,i+1) = 1;            % Upper diagonal
    end
end

% Apply boundary conditions and buid the RHS vector
B(1)  = -(4*dx*dx)-Y0;
B(2:Ni-1)= -(4*dx*dx);
B(Ni)= -(4*dx*dx)-Y1;

% Solve system gaussian elimination
n=length(B);
Y_internal=zeros(n,1);
Aug=[A B];

for j=1:n-1
    for i=j+1:n
      m = Aug(i,j)/Aug(j,j);
      Aug(i,:)=Aug(i,:)-(m*Aug(j,:));
    end
end

% Back substitution

Y_internal(n)=Aug(n,n+1)/Aug(n,n);

for k=n-1:-1:1
    Y_internal(k)=(Aug(k,n+1)-Aug(k,k+1:n)*Y_internal(k+1:n))/Aug(k,k);
end

% Full solution vector
Y = zeros(N,1);
Y(1)   = Y0;
Y(N)   = Y1;
Y(2:N-1) = Y_internal;

% Spatial grid
x = linspace(0,L,N);

% Plot result
plot(x,Y,'-o','LineWidth',2)
xlabel('x')
ylabel('y')
title('Solution of the differential equation')
grid on