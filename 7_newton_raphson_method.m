% newton raphson method
% root finding method

%Initial guess 0.8

f=@(x) (exp(-x)-x);   %defining function
df=@(x) (-exp(-x)-1); %defining derivative function
x0=0.8;               %initial guess
tol=1e-10;            %setting tolerance(part of stopping criteria)
max_iter=50;          %maximum iteration 

[xn,iter_needed,history]=NR_method(f,df,x0,tol,max_iter); %function execution
fprintf('ID=202428028\n');
fprintf('Root=%.10f\n',xn);
fprintf('iteration needed =%d\n',iter_needed);
columnNames={'Iteration number','x','Absolute error (en)'};
T = array2table(history, 'VariableNames', columnNames); %naming the column of history matrix
disp(T);                        %displaying history matrix

function [x0,i,H]=NR_method(f,df,x0,tol,max_iter)

%taking given function,derivative function,initial guess,tolerance and 
% maximum iteration number as input and needed iteration number,final root as output

H =zeros(max_iter+1,3);

%history matrix for showing iteration number,final guess and absolute error

H(1,1:2)=[0,x0]; %Setting initial guess at iteration 0

for i=1:max_iter
    fx=f(x0);
    dfx=df(x0);
    x=x0-(fx/dfx);
    H(i+1,1:2)=[i,x];
    if abs(x-x0)<=tol  %stopping criteria
        x0=x;
        break
    end
    x0=x;
end

H(i+2:max_iter+1,:)=[];            %deleting matrix after convergence 
H(:,3)=abs(H(i+1,2)-H(1:i+1,2));   %Adding absolute error in column 3
x=linspace(0,i,i+1);               %defining x axis
y=zeros(i,1);
y=log(H(:,3));                     %defining y axis
plot(x,y,'LineWidth',2)            %plotting semi logarithmic curve
xlabel('iteration no')
ylabel('log(en)')
title('curve of log(en) vs n')
axis equal
grid on
end