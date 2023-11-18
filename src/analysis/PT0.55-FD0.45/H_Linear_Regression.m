%%%
% Linear Regression - Peak IDR and Peak Theta
%%%

%% PeakIDR Linear Regression

Fig_Peak_Interstorey_Drift_Ratio_linear_regression = figure;

% set layout configuration
figind = {[1 3 5] [2 4 6] [9 11 13] [10 12 14]};
for s=1:storeys
    subplot(8,2,figind{s});
    
    mc=p_matrix(s,1);
    nu=p_matrix_nu(s,1);
    
    IM_u=IM_EDP_u(1:mc,s);
    EDP_u=EDP_PeakIDR_u(1:mc,s);
    
    IM_nu=IM_EDP_nu(1:nu,s);
    EDP_nu=EDP_PeakIDR_nu(1:nu,s);
    
    [p_nu, S_nu] = polyfit(log10(IM_nu), log10(EDP_nu), 1);
    [temp1_nu, temp2_nu] = polyval(p_nu, log10(IM_nu), S_nu);
    y_fit_nu = 10.^temp1_nu;
    upper_ci_nu = y_fit_nu + 2*y_fit_nu.*temp2_nu;
    lower_ci_nu = y_fit_nu - 2*y_fit_nu.*temp2_nu;
    [IM_nu_sorted, idx] = sort(IM_nu);
    upper_ci_nu_sorted = upper_ci_nu(idx);
    lower_ci_nu_sorted = lower_ci_nu(idx);


    [p_u, S_u] = polyfit(log10(IM_u), log10(EDP_u), 1);
    [temp1_u, temp2_u] = polyval(p_u, log10(IM_u), S_u);
    y_fit_u = 10.^temp1_u;
    upper_ci_u = y_fit_u + 2*y_fit_u.*temp2_u;
    lower_ci_u = y_fit_u - 2*y_fit_u.*temp2_u;
    [IM_u_sorted, idx] = sort(IM_u);
    upper_ci_u_sorted = upper_ci_u(idx);
    lower_ci_u_sorted = lower_ci_u(idx);

    % Cloud data + limits
    p(1) = scatter(IM_nu, EDP_nu, 60, 'MarkerEdgeColor', 'b', 'LineWidth', 0.5, 'Marker', 'square');
    hold on
    p(2) = scatter(IM_u, EDP_u, 10, 'MarkerEdgeColor', 'r', 'LineWidth', 0.5, 'Marker', '^');

    p(3) = plot(IM_nu, y_fit_nu, 'b', 'LineWidth', 1);
    p(4) = plot(IM_nu_sorted, upper_ci_nu_sorted, 'b--', 'LineWidth', 1);
    p(5) = plot(IM_nu_sorted, lower_ci_nu_sorted, 'b--', 'LineWidth', 1);
    p(6) = plot(IM_u, y_fit_u, 'r', 'LineWidth', 0.5);
    p(7) = plot(IM_u_sorted, upper_ci_u_sorted, 'r--', 'LineWidth', 0.5);
    p(8) = plot(IM_u_sorted, lower_ci_u_sorted, 'r--', 'LineWidth', 0.5);

    set(gca,'xscale','log')
    set(gca,'yscale','log')

    ylim([1e-2, 1e1])
    xlabel('\itSa(T_1)\rm [g]');
    ylabel('\itIDR_{peak} \rm [%]');
    

    title(strcat('Storey  ',num2str(s)));

end
sgtitle('Peak Interstorey Drift Ratio')
subplot(8, 2, [15 16]) % merge remaining subplots and put legend here
    p(1) = scatter(0,0, 60, 'MarkerEdgeColor', 'b', 'LineWidth', 0.5, 'Marker', 'square');
    hold on
    p(2) = scatter(0,0, 10, 'MarkerEdgeColor', 'r', 'LineWidth', 0.5, 'Marker', '^');

    p(3) = plot(0,0, 'b', 'LineWidth', 0.5);
    p(4) = plot(0,0, 'b--', 'LineWidth', 0.5);
    p(5) = plot(0,0, 'b--', 'LineWidth', 0.5);
    p(6) = plot(0,0, 'r', 'LineWidth', 0.5);
    p(7) = plot(0,0, 'r--', 'LineWidth', 0.5);
    p(8) = plot(0,0, 'r--', 'LineWidth', 0.5);
    xlim([-2 -1])
    ylim([-2 -1])
axis off    
lgd = legend([p(1), p(3), p(4), p(2), p(6), p(7)], ...
        'Without Uncertainties', ...
        'Linear Regression (Without uncertainties)', ...
        '95% Confidence Interval (Without uncertainties)', ...
        'With Uncertainties', ...
        'Linear Regression (With uncertainties)', ...
        '95% Confidence Interval (With uncertainties)', ...
        'Location','southoutside', 'NumColumns',2);
lgd.FontSize = 8;

saveas(gcf,'Figures\02_Peak_IDR_Linear_Regression.fig');

%% Peak Rotation Linear Regression

Fig_Peak_Rotation_linear_regression = figure;

% set layout configuration
figind = {[1 3 5] [2 4 6] [9 11 13] [10 12 14]};

for s=1:storeys
    subplot(8,2,figind{s});
    
    mc=p_matrix(s,1);
    nu=p_matrix_nu(s,1);
    
    IM_u=IM_EDP_u(1:mc,s);
    EDP_u=EDP_PeakTheta_u(1:mc,s);
    
    IM_nu=IM_EDP_nu(1:nu,s);
    EDP_nu=EDP_PeakTheta_nu(1:nu,s);
    
    [p_nu, S_nu] = polyfit(log10(IM_nu), log10(EDP_nu), 1);
    [temp1_nu, temp2_nu] = polyval(p_nu, log10(IM_nu), S_nu);
    y_fit_nu = 10.^temp1_nu;
    upper_ci_nu = y_fit_nu + 2*y_fit_nu.*temp2_nu;
    lower_ci_nu = y_fit_nu - 2*y_fit_nu.*temp2_nu;
    [IM_nu_sorted, idx] = sort(IM_nu);
    upper_ci_nu_sorted = upper_ci_nu(idx);
    lower_ci_nu_sorted = lower_ci_nu(idx);


    [p_u, S_u] = polyfit(log10(IM_u), log10(EDP_u), 1);
    [temp1_u, temp2_u] = polyval(p_u, log10(IM_u), S_u);
    y_fit_u = 10.^temp1_u;
    upper_ci_u = y_fit_u + 2*y_fit_u.*temp2_u;
    lower_ci_u = y_fit_u - 2*y_fit_u.*temp2_u;
    [IM_u_sorted, idx] = sort(IM_u);
    upper_ci_u_sorted = upper_ci_u(idx);
    lower_ci_u_sorted = lower_ci_u(idx);

    % Cloud data + limits
    p(1) = scatter(IM_nu, EDP_nu, 60, 'MarkerEdgeColor', 'b', 'LineWidth', 0.5, 'Marker', 'square');
    hold on
    p(2) = scatter(IM_u, EDP_u, 10, 'MarkerEdgeColor', 'r', 'LineWidth', 0.5, 'Marker', '^');

    p(3) = plot(IM_nu, y_fit_nu, 'b', 'LineWidth', 1);
    p(4) = plot(IM_nu_sorted, upper_ci_nu_sorted, 'b--', 'LineWidth', 1);
    p(5) = plot(IM_nu_sorted, lower_ci_nu_sorted, 'b--', 'LineWidth', 1);
    p(6) = plot(IM_u, y_fit_u, 'r', 'LineWidth', 0.5);
    p(7) = plot(IM_u_sorted, upper_ci_u_sorted, 'r--', 'LineWidth', 0.5);
    p(8) = plot(IM_u_sorted, lower_ci_u_sorted, 'r--', 'LineWidth', 0.5);

    set(gca,'xscale','log')
    set(gca,'yscale','log')

    ylim([1e-3, 1e1])
    xlabel('\itSa(T_1)\rm [g]');
    ylabel('\it\theta_{peak} \rm [rad]');
    

    title(strcat('Storey  ',num2str(s)));
    sgtitle('Peak Rotation')
end

subplot(8, 2, [15 16]) % merge remaining subplots and put legend here
    p(1) = scatter(0,0, 60, 'MarkerEdgeColor', 'b', 'LineWidth', 0.5, 'Marker', 'square');
    hold on
    p(2) = scatter(0,0, 10, 'MarkerEdgeColor', 'r', 'LineWidth', 0.5, 'Marker', '^');

    p(3) = plot(0,0, 'b', 'LineWidth', 0.5);
    p(4) = plot(0,0, 'b--', 'LineWidth', 0.5);
    p(5) = plot(0,0, 'b--', 'LineWidth', 0.5);
    p(6) = plot(0,0, 'r', 'LineWidth', 0.5);
    p(7) = plot(0,0, 'r--', 'LineWidth', 0.5);
    p(8) = plot(0,0, 'r--', 'LineWidth', 0.5);
    xlim([-2 -1])
    ylim([-2 -1])
axis off    
lgd = legend([p(1), p(3), p(4), p(2), p(6), p(7)], ...
        'Without Uncertainties', ...
        'Linear Regression (Without uncertainties)', ...
        '95% Confidence Interval (Without uncertainties)', ...
        'With Uncertainties', ...
        'Linear Regression (With uncertainties)', ...
        '95% Confidence Interval (With uncertainties)', ...
        'Location','southoutside', 'NumColumns',2);
lgd.FontSize = 8;

saveas(gcf,'Figures\02_Peak_Theta_Linear_Regression.fig');