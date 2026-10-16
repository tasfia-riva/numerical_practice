% Buffon's Needle Tossing Experiment Simulation

L = 1;                         % Length of each needle
d = 1;                         % Distance between parallel lines
num_needles = input('Enter the number of needles: ');

% Validate input
if num_needles <= 0 || num_needles ~= floor(num_needles)
    error('Enter a positive integer for the number of needles.');
end

% Define the plotting area
a = 0;
b = 10;

% Set random seed for reproducible results
rng(1234);

% Generate random angles and needle center coordinates
angles = pi * rand(1, num_needles);
xr = 1 + (b - 2) * rand(1, num_needles);
yr = 1 + (b - 2) * rand(1, num_needles);

% Determine whether each needle crosses a line
crossings = abs(yr - round(yr)) <= (L/2) .* sin(angles);

% Estimate pi using Buffon's Needle formula
num_crossings = sum(crossings);

if num_crossings == 0
    pi_estimate = NaN;
    rel_error = NaN;
else
    pi_estimate = (2 * L * num_needles) / ...
        (d * num_crossings);
    rel_error = abs(pi - pi_estimate) / pi;
end

% Display results
fprintf('\n--- Buffon''s Needle Results ---\n');
fprintf('Number of needles = %d\n', num_needles);
fprintf('Number of crossings = %d\n', num_crossings);
fprintf('Estimated pi = %.6f\n', pi_estimate);
fprintf('Actual pi = %.6f\n', pi);
fprintf('Relative error = %.6f\n', rel_error);

if ~isnan(rel_error)
    fprintf('Relative error (percentage) = %.4f%%\n', ...
        rel_error * 100);
end

% Visualization
figure;
hold on;

% Draw parallel horizontal lines
for yy = a:d:b
    plot([a b], [yy yy], 'b-', 'LineWidth', 1);
end

% Draw needles
for i = 1:num_needles
    t = angles(i);

    x1 = xr(i) - (L/2) * cos(t);
    x2 = xr(i) + (L/2) * cos(t);
    y1 = yr(i) - (L/2) * sin(t);
    y2 = yr(i) + (L/2) * sin(t);

    if crossings(i)
        plot([x1 x2], [y1 y2], 'r-', 'LineWidth', 1.5);
    else
        plot([x1 x2], [y1 y2], 'k-', 'LineWidth', 1.5);
    end
end

axis equal;
xlim([a b]);
ylim([a b]);
grid on;
xlabel('x');
ylabel('y');

title(sprintf('Buffon''s Needle: %d Needles, %d Crossings', ...
    num_needles, num_crossings));

legend('Parallel lines', 'Crossing needles', ...
    'Non-crossing needles', 'Location', 'best');

hold off;
