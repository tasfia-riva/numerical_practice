%% spline interpolation vs linear interpolation

% define function
f = @(x) 2*cos(0.5*x) + 0.05*x.^2;

% given data
x_data2 = [0.0 0.7 1.4 2.9 4.1 5.0 6.7 8.5]';
y_data2 = f(x_data2); % corresponding y data

x_query = linspace(x_data2(1), x_data2(end), 850)'; % query points

%% Manual linear interpolation
y_linear = zeros(size(x_query)); % initialize linear interpolation matrix

for i = 1:length(x_query)
    xq = x_query(i); % query point

    % find the segment where xq lies
    for j = 1:length(x_data2)-1
        if xq >= x_data2(j) && xq <= x_data2(j+1)
            x1 = x_data2(j);
            x2 = x_data2(j+1);
            y1 = y_data2(j);
            y2 = y_data2(j+1);

            y_linear(i) = y1 + (y2 - y1)*(xq - x1)/(x2 - x1); % linear interpolation formula
            break; % segment found
        end
    end
end

%% Spline interpolation
y_spline = interp1(x_data2, y_data2, x_query, "spline");

%% True data set
x_true2 = x_query;
y_true2 = f(x_true2);

%% Error calculation
error1 = y_linear - y_true2;   % linear interpolation error
error2 = y_spline - y_true2;   % spline interpolation error

%% Plotting
figure

% Top plot
subplot(2,1,1)
hold on
grid on

plot(x_data2, y_data2, 'LineStyle', 'none', ...
    'Marker', 's', 'MarkerSize', 8, ...
    'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'w'); % original points

plot(x_true2, y_true2, 'LineStyle', '-', 'Color', 'b', 'LineWidth', 2); % true curve
plot(x_query, y_linear, 'LineStyle', '--', 'Color', 'r', 'LineWidth', 2); % linear interpolant
plot(x_query, y_spline, 'LineStyle', '--', 'Color', 'g', 'LineWidth', 2); % spline interpolant

xlabel('X-axis');
ylabel('Y-axis');
title('Comparison of Linear and Spline Interpolation');
legend('Discrete Data', 'True curve', 'Linear interpolant', 'Spline interpolant', 'Location', 'best');
hold off

% Bottom plot
subplot(2,1,2)
hold on
grid on

plot(x_query, error1, 'LineStyle', '--', 'Color', 'r', 'LineWidth', 2); % linear error
plot(x_query, error2, 'LineStyle', '--', 'Color', 'b', 'LineWidth', 1.5); % spline error

xlabel('X-axis');
ylabel('Interpolation Error');
title('Comparison of Linear and Spline Interpolation Error');
legend('Linear interpolation error', 'Spline interpolation error', 'Location', 'north');
hold off
