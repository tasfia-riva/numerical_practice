% linear interpolation

% given value input
x_data1 = [0 1 2 3 4 5 7 10]';
y_data1 = [12 9.2221 7.2518 5.8158 4.7521 3.9981 3.4837 5.4577]';

x_query = linspace(x_data1(1), x_data1(end), 600)'; % query points

%% Manual Interpolation
y_linear = zeros(size(x_query)); % initializing manual interpolation matrix

for i = 1:length(x_query)
    xq = x_query(i); % the value of x where to interpolate

    % find the segment where xq lies
    for j = 1:length(x_data1)-1
        if xq >= x_data1(j) && xq <= x_data1(j+1)
            x1 = x_data1(j);
            x2 = x_data1(j+1);
            y1 = y_data1(j);
            y2 = y_data1(j+1);

            y_linear(i) = y1 + (y2 - y1)*(xq - x1)/(x2 - x1); % linear interpolation formula
            break; % segment found
        end
    end
end

%% Interpolation with built-in function
y_builtin = interp1(x_data1, y_data1, x_query, "linear");

%% Plotting
figure
hold on
grid on

plot(x_data1, y_data1, 'LineStyle', 'none', ...
    'Marker', 's', 'MarkerSize', 8, ...
    'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'w'); % original data

plot(x_query, y_linear, 'LineStyle', '-', 'Color', 'g', 'LineWidth', 2); % manual interpolation line
plot(x_query, y_builtin, 'LineStyle', '--', 'Color', 'r', 'LineWidth', 1.5); % built-in interpolation line

xlabel('X-axis');
ylabel('Y-axis');
title('Verification of Linear Interpolation');
legend('Discrete Data', 'Manual Linear Interpolant', 'Builtin Linear Interpolant', 'Location', 'best');

hold off
