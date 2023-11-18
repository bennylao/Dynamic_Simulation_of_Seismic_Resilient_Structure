%%%
% Fragility Analysis
% Res IDR, Peak IDR and Peak Theta
%%%

%% ResIDR Fragility

failure_valule = 1e-10;

Fig_Residual_Fragility = figure;

% set layout configuration
figind = {[1 3 5] [2 4 6] [9 11 13] [10 12 14]};

for s=1:storeys
    subplot(8,2,figind{s});
    
    mc=p_matrix(s,1);
    nu=p_matrix_nu(s,1);
    
    IM_u=IM_EDP_u(1:mc,s);
    EDP_u=EDP_ResIDR_u(1:mc,s);
    
    IM_nu=IM_EDP_nu(1:nu,s);
    EDP_nu=EDP_ResIDR_nu(1:nu,s);
    
    % data preparation
    [row_nu, ~] = size(IM_nu);
    [row_u, ~] = size(IM_u);
    y_nu = zeros(row_nu, 1);
    y_u = zeros(row_u, 1);
    
    for i = 1:row_nu
    
        if EDP_nu(i) > failure_valule
            y_nu(i) = 1;
        end
    end

    for i = 1:row_u
        if EDP_u(i) > failure_valule
            y_u(i) = 1;
        end
    end
    
    % regression model
    model_nu = stepwiseglm(IM_nu, y_nu, "constant", 'Distribution', 'binomial');
    model_u = stepwiseglm(IM_u, y_u, "constant", 'Distribution', 'binomial');
    
    coefficient_nu = model_nu.Coefficients.Estimate;
    coefficient_u = model_u.Coefficients.Estimate;
    
    numstep = linspace(0, 6, 1000);

    % try and catch to prevent error from logistic regression
    % sometimes when only one or two cases are failed,
    % logistic regression can not be performed correctly
    try
        c_nu = coefficient_nu(1);
        beta_nu = coefficient_nu(2);
        probability_nu = II_Logistic_Probability(numstep, beta_nu, c_nu);
    catch
        probability_nu = zeros(1, 1000);
    end

    try
        c_u = coefficient_u(1);
        beta_u = coefficient_u(2);
        probability_u = II_Logistic_Probability(numstep, beta_u, c_u);
    catch
        probability_u = zeros(1, 1000);
    end

    p(1) = plot(numstep, probability_nu, 'LineWidth', 1.5, 'Color', 'b');
    hold on
    p(2) = plot(numstep, probability_u, 'LineWidth', 1, 'Color', 'r');

    set(gca, 'box', 'off')
    ylim([0,1])
    xlim([0,6])
    xlabel('\itSa(T_1)\rm [g]');
    ylabel('\itProbability of Failure')

    title(strcat('Storey  ',num2str(s)));

end

sgtitle('Residual Interstorey Drift Fragility Curve')
subplot(8, 2, [15 16]) % merge remaining subplots and put legend here
    p(1) = plot(0, 0, 'LineWidth', 1, 'Color', 'b');
    hold on
    p(2) = plot(0, 0, 'LineWidth', 1, 'Color', 'r');
    xlim([-2 -1])
    ylim([-2 -1])
axis off    
lgd = legend([p(1), p(2)], ...
        'Without Uncertainties', ...
        'With Uncertainties', ...
        'Location','southoutside', 'NumColumns',2);
lgd.FontSize = 8;

saveas(gcf,'Figures\03_Res_IDR_Fragility_02.fig');

%% Peak IDR and Theta Fragility

failure_valule_IDR = 2;
failure_valule_theta = 0.08;

Fig_Peak_Fragility = figure;

% set layout configuration
figind = {[1 3 5] [2 4 6] [9 11 13] [10 12 14]};

for s=1:storeys

    subplot(8,2,figind{s});
    
    mc=p_matrix(s,1);
    nu=p_matrix_nu(s,1);
    
    EDP_nu = [];
    EDP_u = [];

    IM_nu=IM_EDP_nu(1:nu,s);
    EDP_nu(:, 1)=EDP_PeakIDR_nu(1:nu,s);
    EDP_nu(:, 2)=EDP_PeakTheta_nu(1:nu,s);

    IM_u=IM_EDP_u(1:mc,s);
    EDP_u(:, 1)=EDP_PeakIDR_u(1:mc,s);
    EDP_u(:, 2)=EDP_PeakTheta_u(1:mc,s);
    
    % data preparation
    [row_nu, ~] = size(IM_nu);
    [row_u, ~] = size(IM_u);
    y_nu = zeros(row_nu, 2);
    y_u = zeros(row_u, 2);
    
    for i = 1:row_nu
    
        if EDP_nu(i, 1) > failure_valule_IDR
            y_nu(i, 1) = 1;
        end

        if EDP_nu(i, 2) > failure_valule_theta
            y_nu(i, 2) = 1;
        end
    end

    for i = 1:row_u
        if EDP_u(i, 1) > failure_valule_IDR
            y_u(i, 1) = 1;
        end
        if EDP_u(i, 2) > failure_valule_theta
            y_u(i, 2) = 1;
        end
    end
    
    % regression model
    % model 1 is Peak IDR
    model_nu_1 = stepwiseglm(IM_nu, y_nu(:, 1), "constant", 'Distribution', 'binomial', 'PEnter', 0.05);
    model_u_1 = stepwiseglm(IM_u, y_u(:, 1), "constant", 'Distribution', 'binomial', 'PEnter', 0.05);
    % model 2 is Peak Rotation
    model_nu_2 = stepwiseglm(IM_nu, y_nu(:, 2), "constant", 'Distribution', 'binomial', 'PEnter', 0.05);
    model_u_2 = stepwiseglm(IM_u, y_u(:, 2), "constant", 'Distribution', 'binomial', 'PEnter', 0.05);
    
    % extract output from model 1
    coefficient_nu_1 = model_nu_1.Coefficients.Estimate;
    coefficient_u_1 = model_u_1.Coefficients.Estimate;
    % extract output from model 2
    coefficient_nu_2 = model_nu_2.Coefficients.Estimate;
    coefficient_u_2 = model_u_2.Coefficients.Estimate;

    numstep = linspace(0, 6, 1000);

    % try and catch to prevent error from logistic regression
    % sometimes when only one or two cases are failed,
    % logistic regression can not be performed correctly
    try
        c_nu_1 = coefficient_nu_1(1);
        beta_nu_1 = coefficient_nu_1(2);
        probability_nu_1 = II_Logistic_Probability(numstep, beta_nu_1, c_nu_1);
    catch
        probability_nu_1 = zeros(1, 1000);
    end

    try
        c_u_1 = coefficient_u_1(1);
        beta_u_1 = coefficient_u_1(2);
        probability_u_1 = II_Logistic_Probability(numstep, beta_u_1, c_u_1);
    catch
        probability_u_1 = zeros(1, 1000);
    end

    try
        c_nu_2 = coefficient_nu_2(1);
        beta_nu_2 = coefficient_nu_2(2);
        probability_nu_2 = II_Logistic_Probability(numstep, beta_nu_2, c_nu_2);
    catch
        probability_nu_2 = zeros(1, 1000);
    end

    try
        c_u_2 = coefficient_u_2(1);
        beta_u_2 = coefficient_u_2(2);
        probability_u_2 = II_Logistic_Probability(numstep, beta_u_2, c_u_2);
    catch
        probability_u_2 = zeros(1, 1000);
    end

    p(1) = plot(numstep, probability_nu_1, 'b', 'LineWidth', 1.5);
    hold on
    p(2) = plot(numstep, probability_u_1, 'r', 'LineWidth', 1);
    p(3) = plot(numstep, probability_nu_2, 'b--', 'LineWidth', 1.5);
    p(4) = plot(numstep, probability_u_2, 'r--', 'LineWidth', 1);

    set(gca, 'box', 'off')
    ylim([0,1])
    xlim([0,6])
    xlabel('\itSa(T_1)\rm [g]');
    ylabel('\itProbability of Failure')

    title(strcat('Storey  ',num2str(s)));

end

sgtitle('Peak Interstorey Drift and Rotation Fragility Curve')
subplot(8, 2, [15 16]) % merge remaining subplots and put legend here
    p(1) = plot(0,0, 'b', 'LineWidth', 1.5);
    hold on
    p(2) = plot(0,0, 'r', 'LineWidth', 1);
    p(3) = plot(0,0, 'b--', 'LineWidth', 1.5);
    p(4) = plot(0,0, 'r--', 'LineWidth', 1);
    xlim([-2 -1])
    ylim([-2 -1])
axis off    
lgd = legend([p(1), p(2), p(3), p(4)], ...
        'IDR_{peak} Without Uncertainties', ...
        'IDR_{peak} With Uncertainties', ...
        '\theta_{peak} Without Uncertainties', ...
        '\theta_{peak} With Uncertainties', ...
        'Location','southoutside', 'NumColumns',2);
lgd.FontSize = 8;

saveas(gcf,'Figures\03_Peak_IDR_Theta_Fragility.fig');

%% clean data

clearvars EDP_u EDP_nu IM_u IM_nu model_nu_1 model_u_1 model_nu_2 model_u_2 model_nu model_u
