% estimating the value of pi using Laplace MC method
clc;
clear;
close all;

% Input number of samples
N = input('Enter the number of samples: ');

% Initialize counters and arrays
dots = 0;
inside_x = [];
inside_y = [];
outside_x = [];
outside_y = [];

% Monte Carlo simulation
for i = 1:N
    x = rand;
    y = rand;

    if x*x + y*y <= 1
        dots = dots + 1;
        inside_x(end+1) = x;
        inside_y(end+1) = y;
    else
        outside_x(end+1) = x;
        outside_y(end+1) = y;
    end
end

% Calculate estimated pi and relative error
pi_actual = pi;
pi_value = 4 * dots / N;
rel_error = abs(pi_actual - pi_value) / pi_actual;

% Display results
fprintf('\n----- Monte Carlo Estimation of Pi -----\n');
fprintf('Number of samples       = %d\n', N);
fprintf('Points inside circle    = %d\n', dots);
fprintf('Estimated pi            = %.8f\n', pi_value);
fprintf('Actual pi               = %.8f\n', pi_actual);
fprintf('Relative error          = %.8f\n', rel_error);
fprintf('Relative error (%%)      = %.4f%%\n', ...
    rel_error * 100);

% Visualization
figure;
hold on;

% Plot points inside and outside the quarter circle
plot(inside_x, inside_y, 'b.', 'MarkerSize', 8);
plot(outside_x, outside_y, 'r.', 'MarkerSize', 8);

% Draw quarter circle
theta = linspace(0, pi/2, 500);
plot(cos(theta), sin(theta), 'k-', 'LineWidth', 2);

% Format the graph
axis equal;
axis([0 1 0 1]);
grid on;
box on;

xlabel('x');
ylabel('y');
title(sprintf('Monte Carlo Estimation of Pi (N = %d)', N));

legend('Inside quarter circle', ...
    'Outside quarter circle', ...
    'Quarter circle', ...
    'Location', 'southwest');

hold off;
