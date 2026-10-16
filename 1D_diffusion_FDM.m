% 1D diffusion solution for slab geometry using FDM

%values
a=5;
D=1;
Sa=0.2;
h=input("Enter the value of mesh length: ");

%generating the matrix
x=-5:h:5;
m=length(x);
A = zeros(m,m);
for i=2:m-1
    A(i,i-1)=-D/h^2;
    A(i,i)=Sa+2*D/h^2;
    A(i,i+1)=-D/h^2;
end
A(1,1)=Sa+2*D/h^2;
A(1,2)=-D/h^2;
A(end,end-1)=-D/h^2;
A(end,end)=Sa+2*D/h^2;
Q=(10)*ones(m,1);

%Numerical solution
f=zeros(m,1);
f=A\Q;

%analytical solution
y=-5.28354*(exp(sqrt(Sa)*x))-5.28354*(exp(-sqrt(Sa)*x))+50;

%plot of numerical and analytical solution in the same curve
plot(x,y,'r')
hold on
plot(x,f,'b')
title(['flux vs postion for mesh size = ', num2str(h) , 'cm'] )
xlabel('position (x) cm ')
ylabel('flux(# cm^-2)')
legend('Analytical','Numerical')
grid on
hold off

%plot of relative error
plot(x,abs(f-y)/y)
title(['Relative error for mesh size = ', num2str(h) , 'cm'] )
xlabel('position (x) cm ')
ylabel('Relative error')
grid on