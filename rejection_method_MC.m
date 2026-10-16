%  rejection method of integration

% Function to integrate
f = @(x) 1 ./ (1 + x.^2);

% Parameters
N = input('Enter the number of samples: ');
a = 0;
b = 1;

if N <= 0 || N ~= floor(N)
    error('Enter a positive integer for the number of samples.');
end

% Maximum height of the function
M = 1.4 * max(f(linspace(a, b, 1000)));

% Generate random points
x = a + (b-a) * rand(1, N);
y_val = M * rand(1, N);

% Check which points lie under the curve
fx = f(x);
under = y_val < fx;

% Estimate the integral
PercentUnderCurve = sum(under) / N;
Monte_Integral = PercentUnderCurve * M * (b-a);

% Estimate pi and calculate percentage error
pi_estimate = 4 * Monte_Integral;
PercentError = abs(pi_estimate - pi) / pi * 100;

% Display results
fprintf('\n--- Rejection Method of Integration ---\n');
fprintf('Number of samples = %d\n', N);
fprintf('Points under curve = %d\n', sum(under));
fprintf('Estimated integral = %.8f\n', Monte_Integral);
fprintf('Estimated pi = %.8f\n', pi_estimate);
fprintf('Actual pi = %.8f\n', pi);
fprintf('Percentage error = %.4f%%\n', PercentError);

% Visualization
figure;
hold on;

% Plot points below and above the curve
plot(x(under), y_val(under), 'b.', 'MarkerSize', 8);
plot(x(~under), y_val(~under), 'r.', 'MarkerSize', 8);

% Plot the function
x_curve = linspace(a, b, 500);
plot(x_curve, f(x_curve), 'k-', 'LineWidth', 2);

% Plot the bounding rectangle
plot([a b b a a], [0 0 M M 0], ...
    'g--', 'LineWidth', 1.5);

% Format graph
xlim([a b]);
ylim([0 M]);
grid on;
xlabel('x');
ylabel('y');

title(sprintf('Rejection Method: N = %d, Estimate of pi = %.6f', ...
    N, pi_estimate));

legend('Points under curve', ...
    'Points above curve', ...
    'f(x) = 1/(1+x^2)', ...
    'Bounding rectangle', ...
    'Location', 'northeast');

hold off;

