% extrapolation

% define function
f = @(x) 0.5*x + 2*exp(-0.7*(x-8));
% given points
x_data3 = [2 3 4 5 6 7]';
y_data3 = f(x_data3); % corresponding y data
x_query = linspace(0, 11, 1100)'; % query points
%% Manual Linear interpolation and extrapolation
y_linear = zeros(size(x_query)); % initialize linear interpolation matrix
for i = 1:length(x_query)
    xq = x_query(i); % determine query point   
    % Case 1: left extrapolation
    if xq < x_data3(1)
        x1 = x_data3(1);
        x2 = x_data3(2);
        y1 = y_data3(1);
        y2 = y_data3(2);
        % Case 2: right extrapolation
    elseif xq > x_data3(end)
        x1 = x_data3(end-1);
        x2 = x_data3(end);
        y1 = y_data3(end-1);
        y2 = y_data3(end);
        % Case 3: interpolation (inside range)
    else
        for j = 1:length(x_data3)-1
            if xq >= x_data3(j) && xq <= x_data3(j+1)
                x1 = x_data3(j);
                x2 = x_data3(j+1);
                y1 = y_data3(j);
                y2 = y_data3(j+1);
                break;
            end
        end
    end
    y_linear(i) = y1 + (y2 - y1)*(xq - x1)/(x2 - x1); % linear formula
end
%% Spline interpolation and extrapolation
y_spline = interp1(x_data3, y_data3, x_query, 'spline');
%% True data set
x_true3 = x_query;
y_true3 = f(x_true3);
%% Plotting
figure
hold on
grid on
plot(x_data3, y_data3, 'LineStyle', 'none', ...
    'Marker', 's', 'MarkerSize', 8, ...
    'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'w'); % original points
plot(x_true3, y_true3, 'LineStyle', '-', 'Color', 'b', 'LineWidth', 2); % true curve
plot(x_query, y_linear, 'LineStyle', '--', 'Color', 'r', 'LineWidth', 2); % linear interpolant
plot(x_query, y_spline, 'LineStyle', '--', 'Color', 'g', 'LineWidth', 2); % spline interpolant
xlabel('X-axis');
ylabel('Y-axis');
title('Comparison of Extrapolation and Interpolation');
legend('Discrete Data', 'True curve', 'Linear interpolant', 'Spline interpolant', 'Location', 'best');
hold off
