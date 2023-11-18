%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Quantification of Model Uncertainties on Seismic Response of 
% Eccentrically Braced Frames with Self-Centring Links
%
% Ludovica Pieroni - PhD Candidate UCL 
% 2022/2023
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Plot results

%% Peak Interstory Drifts

% set threshold in [%]
threshold = 2;
limited_state = 'Capacity';
color = ["#D95319", "#77AC30", ];

%PeakIDR plot in normal scale
Fig_Peak_Interstorey_Drift_Ratio=figure;

for s=1:storeys
    subplot(2,2,s);
    
    mc=p_matrix(s,1);
    nu=p_matrix_nu(s,1);
    
    IM_u=IM_EDP_u(1:mc,s);
    EDP_u=EDP_PeakIDR_u(1:mc,s);
    
    IM_nu=IM_EDP_nu(1:nu,s);
    EDP_nu=EDP_PeakIDR_nu(1:nu,s);
    
    % Cloud data + limits
    scatter(IM_nu, EDP_nu, 60, 'MarkerEdgeColor', 'b', 'LineWidth', 1, 'Marker', 'square');
    hold on
    scatter(IM_u, EDP_u, 10, 'MarkerEdgeColor', 'r', 'LineWidth', 1, 'Marker', '^');
    yline(threshold, '-', append(limited_state, ": ", num2str(threshold), '%'),'Color',color(1),'LineWidth',1.5, 'LabelHorizontalAlignment','left')
    xlim([0, 2.5])
    ylim([0, 5])
    xlabel('\itSa(T_1)\rm [g]');
    ylabel('\itIDR_{peak} \rm [%]');
    legend('Without Uncertainties', 'With Uncertainties', append(limited_state, ": ", num2str(threshold), '%'), 'Location','northwest');
    title(strcat('Storey  ',num2str(s)));
end
sgtitle('Peak Interstorey Drift Ratio')
saveas(gcf,'Figures\01_Peak_IDR.fig');


%PeakIDR plot in loglog scale
Fig_Peak_Interstorey_Drift_Ratio_loglog = figure;

for s=1:storeys
    subplot(2,2,s);
    
    mc=p_matrix(s,1);
    nu=p_matrix_nu(s,1);
    
    IM_u=IM_EDP_u(1:mc,s);
    EDP_u=EDP_PeakIDR_u(1:mc,s);
    
    IM_nu=IM_EDP_nu(1:nu,s);
    EDP_nu=EDP_PeakIDR_nu(1:nu,s);
    
    % Cloud data + limits
    scatter(IM_nu, EDP_nu, 60, 'MarkerEdgeColor', 'b', 'LineWidth', 1, 'Marker', 'square');
    hold on
    scatter(IM_u, EDP_u, 10, 'MarkerEdgeColor', 'r', 'LineWidth', 1, 'Marker', '^');
    yline(threshold, '-', append(limited_state, ": ", num2str(threshold), '%'),'Color',color(1),'LineWidth',1.5, 'LabelHorizontalAlignment','left')

    set(gca,'xscale','log')
    set(gca,'yscale','log')

    ylim([1e-2, 1e1])
    xlabel('\itSa(T_1)\rm [g]');
    ylabel('\itIDR_{peak} \rm [%]');
    legend('Without Uncertainties', 'With Uncertainties', append(limited_state, ": ", num2str(threshold), '%'), 'Location','southeast');
    title(strcat('Storey  ',num2str(s)));
end
sgtitle('Peak Interstorey Drift Ratio')
saveas(gcf,'Figures\01_Peak_IDR_loglog.fig');

%% Peak Theta

% set threshold in rad
threshold = 0.08;
limited_state = 'Capacity';
color = ["#D95319", "#77AC30", ];

%PeakTheta plot in normal scale
Fig_Peak_Rotation=figure;

for s=1:storeys
    subplot(2,2,s);
    
    mc=p_matrix(s,1);
    nu=p_matrix_nu(s,1);
    
    IM_u=IM_EDP_u(1:mc,s);
    EDP_u=EDP_PeakTheta_u(1:mc,s);
    
    IM_nu=IM_EDP_nu(1:nu,s);
    EDP_nu=EDP_PeakTheta_nu(1:nu,s);
    
    % Cloud data + limits
    scatter(IM_nu, EDP_nu, 60, 'MarkerEdgeColor', 'b', 'LineWidth', 1, 'Marker', 'square');
    hold on
    scatter(IM_u, EDP_u, 10, 'MarkerEdgeColor', 'r', 'LineWidth', 1, 'Marker', '^');
    yline(threshold, '-', append(limited_state, ": ", num2str(threshold), 'rad'),'Color',color(1),'LineWidth',1.5, 'LabelHorizontalAlignment','right')
    xlim([0, 2.5])
    ylim([0, 1.5])
    xlabel('\itSa(T_1)\rm [g]');
    ylabel('\it\theta_{peak}\rm [rad]');
    legend('Without Uncertainties', 'With Uncertainties', append(limited_state, ": ", num2str(threshold), 'rad'), 'Location','northwest');
    title(strcat('Storey  ',num2str(s)));
end
sgtitle('Peak Rotation')
saveas(gcf,'Figures\01_Peak_Theta.fig');


%PeakTheta plot in loglog scale
Fig_Peak_Rotation_loglog = figure;

for s=1:storeys
    subplot(2,2,s);
    
    mc=p_matrix(s,1);
    nu=p_matrix_nu(s,1);
    
    IM_u=IM_EDP_u(1:mc,s);
    EDP_u=EDP_PeakTheta_u(1:mc,s);
    
    IM_nu=IM_EDP_nu(1:nu,s);
    EDP_nu=EDP_PeakTheta_nu(1:nu,s);
    
    % Cloud data + limits
    scatter(IM_nu, EDP_nu, 60, 'MarkerEdgeColor', 'b', 'LineWidth', 1, 'Marker', 'square');
    hold on
    scatter(IM_u, EDP_u, 10, 'MarkerEdgeColor', 'r', 'LineWidth', 1, 'Marker', '^');
    yline(threshold, '-', append(limited_state, ": ", num2str(threshold), 'rad'),'Color',color(1),'LineWidth',1.5, 'LabelHorizontalAlignment','left')

    set(gca,'xscale','log')
    set(gca,'yscale','log')

    ylim([1e-3, 1e1])
    xlabel('\itSa(T_1)\rm [g]');
    ylabel('\it\theta_{peak}\rm [rad]');
    legend('Without Uncertainties', 'With Uncertainties', append(limited_state, ": ", num2str(threshold), 'rad'), 'Location','northwest');
    title(strcat('Storey  ',num2str(s)));
end
sgtitle('Peak Rotation')
saveas(gcf,'Figures\01_Peak_Theta_loglog.fig');

%% Residual Interstory Drifts

% set threshold in [%]
threshold = [0.5, 0.2];
limited_state = ["DS2", 'DS1'];
color = ["#D95319", "#77AC30", ];

%ResIDR plot in normal scale
Fig_Residual_Interstorey_Drift_Ratio = figure;

for s=1:storeys
    subplot(2,2,s);
    
    mc=p_matrix(s,1);
    nu=p_matrix_nu(s,1);
    
    IM_u=IM_EDP_u(1:mc,s);
    EDP_u=EDP_ResIDR_u(1:mc,s);
    
    IM_nu=IM_EDP_nu(1:nu,s);
    EDP_nu=EDP_ResIDR_nu(1:nu,s);
    
    % Cloud data + limits
    scatter(IM_nu, EDP_nu, 60, 'MarkerEdgeColor', 'b', 'LineWidth', 1, 'Marker', 'square');
    hold on
    scatter(IM_u, EDP_u, 10, 'MarkerEdgeColor', 'r', 'LineWidth', 1, 'Marker', '^');
    for i = 1:length(threshold)
        yline(threshold(i), '-', append(limited_state(i), ": ", num2str(threshold(i)), '%'),'Color',color(i),'LineWidth',1.5, 'LabelHorizontalAlignment','left')
    end
    xlim([0, 2.5])
    ylim([0, 0.8])
    xlabel('\itSa(T_1)\rm [g]');
    ylabel('\itIDR_{res}\rm [%]');
    legend('Without Uncertainties', 'With Uncertainties', append(num2str(limited_state(1)), ": ", num2str(threshold(1)), '%'), append(num2str(limited_state(2)), ": ", num2str(threshold(2)), '%'), 'Location','northwest');
    title(strcat('Storey  ',num2str(s)));
end
sgtitle('Residual Interstorey Drift Ratio')
saveas(gcf,'Figures\01_Residual_IDR.fig');

%ResIDR plot in loglog scale
Fig_Residual_Interstorey_Drift_Ratio_loglog = figure;

for s=1:storeys
    subplot(2,2,s);
    
    mc=p_matrix(s,1);
    nu=p_matrix_nu(s,1);
    
    IM_u=IM_EDP_u(1:mc,s);
    EDP_u=EDP_ResIDR_u(1:mc,s);
    
    IM_nu=IM_EDP_nu(1:nu,s);
    EDP_nu=EDP_ResIDR_nu(1:nu,s);
    
    % Cloud data + limits
    scatter(IM_nu, EDP_nu, 60, 'MarkerEdgeColor', 'b', 'LineWidth', 1, 'Marker', 'square');
    hold on
    scatter(IM_u, EDP_u, 10, 'MarkerEdgeColor', 'r', 'LineWidth', 1, 'Marker', '^');
    for i = 1:length(threshold)
        yline(threshold(i), '-','Color',color(i),'LineWidth',1.5)
    end

    set(gca,'xscale','log')
    set(gca,'yscale','log')

    ylim([1e-16, 1e0])
    xlabel('\itSa(T_1)\rm [g]');
    ylabel('\itIDR_{res}\rm [%]');
    legend('Without Uncertainties', 'With Uncertainties', append(num2str(limited_state(1)), ": ", num2str(threshold(1)), '%'), append(num2str(limited_state(2)), ": ", num2str(threshold(2)), '%'), 'Location','northwest');
    title(strcat('Storey  ',num2str(s)));
end
sgtitle('Residual Interstorey Drift Ratio')
saveas(gcf,'Figures\01_Residual_IDR_loglog.fig');
