% heat conduction equation solve using FDM

L  = 1;              % Length (m)
k  = 10;             % Thermal conductivity (W/m-K)
q  = 500;            % Heat generation (W/m^3)
T0 = 100;            % Temperature at x=0 (°C)
TL = 50;             % Temperature at x=L (°C)
N  = 50;             % Total number of nodes

dx = L/(N-1);        % Grid spacing
Ni = N - 2;          % Internal nodes


A = zeros(Ni, Ni);
B = zeros(Ni, 1);


for i = 1:Ni
    A(i,i) = -2;
    
    if i > 1
        A(i,i-1) = 1;
    end
    
    if i < Ni
        A(i,i+1) = 1;
    end
    B(i) = -(q/k) * dx^2;
end


B(1)   = B(1)   - T0;
B(end) = B(end) - TL;

T_internal = A \ B;

T = zeros(N,1);
T(1)       = T0;
T(N)       = TL;
T(2:N-1)   = T_internal;

x = linspace(0, L, N);
plot(x, T, 'LineWidth', 2)
xlabel('x (m)')
ylabel('Temperature (°C)')
title('1D Steady Heat Conduction with Internal Heat Generation')
grid on
