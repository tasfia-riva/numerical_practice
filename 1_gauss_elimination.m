
% gauss-elimination method

A=input('Enter your co-efficient matrix: ');
B=input('Enter your sorce vector: ');
N=length(B);
x=zeros(N,1);
Aug=[A B];

for j=1:N-1
    for i=j+1:N
      m = Aug(i,j)/Aug(j,j);
      Aug(i,:)=Aug(i,:)-(m*Aug(j,:));
    end
end

% Back substitution

x(N)=Aug(N,N+1)/Aug(N,N);

for k=N-1:-1:1
    x(k)=(Aug(k,N+1)-Aug(k,k+1:N)*x(k+1:N))/Aug(k,k);
end
x