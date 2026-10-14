% numerical regression

%% Load Data
T = readtable("Regression_ex_fulldata.csv");
x_data = T.x(:);
y_data = T.y(:);

%% Train-Test Split (70-30)
rng(10);

idx = randperm(numel(x_data));
ntrain = round(0.7*numel(x_data));

id_strain = idx(1:ntrain);
id_stest  = idx(ntrain+1:end);

x_strain = x_data(id_strain);
y_strain = y_data(id_strain);

x_stest  = x_data(id_stest);
y_stest  = y_data(id_stest);

fprintf('\nIndices of testing data points (stochastic method):\n');
disp(id_stest);

%% Exercise 1 Part A

deg = 2;

% Train on training data
[coeff_train, ~, train_rmse, train_R2, train_res] = manual_polyfit(x_strain, y_strain, deg);

% Predict testing data
y_test_pred = polyval(coeff_train', x_stest);

[test_rmse, test_R2, test_res] = fitting_metrics(y_stest, y_test_pred);

fprintf('\nTesting Metrics (trained on training data):\n');
fprintf('Testing RMSE = %.2f\n', test_rmse);
fprintf('Testing R2   = %.2f\n', test_R2);

%% Train on testing only
[coeff_testonly, ~, rmse_testonly, R2_testonly] = manual_polyfit(x_stest, y_stest, deg);

%% Train on full dataset
[coeff_full, ~, rmse_full, R2_full] = manual_polyfit(x_data, y_data, deg);

%% Generate smooth curve
x_curve = linspace(min(x_data), max(x_data), 200);

y_curve_train = polyval(coeff_train', x_curve);
y_curve_test  = polyval(coeff_testonly', x_curve);
y_curve_full  = polyval(coeff_full', x_curve);

%% Strict Plotting Part A

figure;

%% Left Plot: Data + Curves
subplot(1,2,1)

scatter(x_strain, y_strain, 49, 'ko', 'filled'); 
hold on;
scatter(x_stest,  y_stest,  49, 'rs', 'filled');

plot(x_curve, y_curve_train, 'b-',  'LineWidth',1.5);
plot(x_curve, y_curve_test,  'm--', 'LineWidth',1.5);
plot(x_curve, y_curve_full,  'g--', 'LineWidth',1.5);

axis square;
grid on;
xlabel('x');
ylabel('y');
title('Quadratic Model Fits');
legend({'Training data','Testing data','Trained-on-training curve','Trained-on-testing curve','Trained-on-full curve'},'Location','best','FontSize',9);

%% Right Plot: Residuals
subplot(1,2,2)

scatter(x_strain, train_res, 25, 'bo', 'filled'); 
hold on;
scatter(x_stest,  test_res,  25, 'ro', 'filled');


plot(x_curve, zeros(size(x_curve)), 'k--', 'LineWidth',1.5);

axis square;
grid on;
xlabel('x');
ylabel('Residual');
title('Residuals vs. x')
legend({'Training residuals','Testing residuals','Residual = 0'},'Location','best','FontSize',9);
sgtitle('Exercise 1 Part A: Quadratic Model Testing');

set(gcf,'Units','pixels');
set(gcf,'Position', get(0,'ScreenSize'));   % Full screen size
set(gcf,'PaperPositionMode','auto');

saveas(gcf,'NE262_Regression_ex1A_figure.jpg');


degrees = [1 2 3 4];

for i = 1:length(degrees)
    
    deg = degrees(i);
    
    [coeff{i}, ~, train_rmse_all(i), train_R2_all(i), train_res_all{i}] = manual_polyfit(x_strain, y_strain, deg);
    y_test_pred = polyval(coeff{i}', x_stest);
    [test_rmse_all(i), test_R2_all(i), test_res_all{i}] = fitting_metrics(y_stest, y_test_pred);
    
end

fprintf('\nTesting Metrics for Degrees 1–4:\n');

for i = 1:length(degrees)
    fprintf('\nPolynomial Degree = %d\n', degrees(i));
    fprintf('Testing RMSE = %.2f\n', test_rmse_all(i));
    fprintf('Testing R2   = %.2f\n', test_R2_all(i));
end

%% True function
true_fun = @(x) 0.6*x.^2 - 1.2*x + 3;

%% Strict Plotting Part B

figure;

colors = {'m','b','g',[1 0.65 0]};   % exact orange tone

%% Top Left: Data + Degree 1–4 curves
subplot(2,2,1)

scatter(x_strain, y_strain, 49, 'ko', 'filled'); 
hold on;
scatter(x_stest,  y_stest,  49, 'rs', 'filled');

for i = 1:4
    y_curve = polyval(coeff{i}', x_curve);
    plot(x_curve, y_curve, 'Color', colors{i}, 'LineWidth',1.5);
end

axis square;
grid on;
xlabel('x');
ylabel('y');
title('Polynomial Fits (Degree 1-4)');
legend({'Training data','Testing data',...
        'Degree 1','Degree 2','Degree 3','Degree 4'},...
        'Location','best','FontSize',9);

%% Top Right: RMSE & R2 vs Degree
subplot(2,2,2)

yyaxis left
plot(degrees, train_rmse_all, '-bs','LineWidth',1.5,'MarkerEdgeColor','b','MarkerSize',5); 
hold on;
plot(degrees, test_rmse_all,  '-rs','LineWidth',1.5,'MarkerEdgeColor','r','MarkerSize',5);
ylabel('RMSE');
yyaxis right
plot(degrees, train_R2_all, '-.bd','LineWidth',1.5,'MarkerEdgeColor','b','MarkerSize',5);
plot(degrees, test_R2_all,  '-.rd','LineWidth',1.5,'MarkerEdgeColor','r','MarkerSize',5);
ylabel('R^2');
xlabel('Polynomial Degree');
axis square;
grid on;
title('Regression Metrics vs Degree');
legend({'Training RMSE','Testing RMSE','Training R^2','Testing R^2'},'Location','best','FontSize',9);

%% Bottom Left: Residuals (degree specific markers)
subplot(2,2,3)

for i = 1:4
    scatter(x_strain, train_res_all{i}, 25, colors{i}, 'o','filled'); 
    hold on;
    scatter(x_stest,  test_res_all{i},  25, colors{i}, 's','filled');
end

plot(x_curve, zeros(size(x_curve)), 'k-', 'LineWidth',1.5);
axis square;
grid on;
xlabel('x');
ylabel('Residual');
title('Residuals vs x');
legend({'Training point residuals', 'Testing point residuals', 'Residual = 0'},'Location', 'best', 'FontSize', 9);

%% Bottom Right: Signed Deviation
subplot(2,2,4)

true_fun = @(x) 0.6*x.^2 - 1.2*x + 3;

for i = 1:4
    y_curve = polyval(coeff{i}', x_curve);
    deviation = y_curve - true_fun(x_curve);
    plot(x_curve, deviation, 'Color', colors{i}, 'LineWidth',1.5); hold on;
end

plot(x_curve, zeros(size(x_curve)), 'k-', 'LineWidth',1.5);
axis square;
grid on;
xlabel('x');
ylabel('Signed Deviation');
title('Signed Deviation from True Function');
legend({'Degree 1', 'Degree 2', 'Degree 3', 'Degree 4'}, 'Location', 'best', 'FontSize', 9);

sgtitle('Exercise 1 Part B: Underfitting and Overfitting Analysis');

set(gcf,'Units','pixels');
set(gcf,'Position', get(0,'ScreenSize'));   % Full screen size
set(gcf,'PaperPositionMode','auto');

saveas(gcf,'Regression_ex1B_figure.jpg');