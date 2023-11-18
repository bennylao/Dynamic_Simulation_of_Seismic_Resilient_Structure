%% Remove outliners and plot results

EDP_ResIDR_u=zeros(n_sample,storeys);
EDP_PeakIDR_u = zeros(n_sample,storeys);
EDP_PeakTheta_u = zeros(n_sample,storeys);
IM_EDP_u=zeros(n_sample,storeys);

EDP_ResIDR_nu=zeros(n_sample,storeys);
EDP_PeakIDR_nu = zeros(n_sample,storeys);
EDP_PeakTheta_nu = zeros(n_sample,storeys);
IM_EDP_nu=zeros(n_sample,storeys);

% Clean the results from the outliers (remove residual < 1%)
p_matrix= zeros(storeys, 1);
p_matrix_nu=zeros(storeys, 1);

for s=1:storeys
    p=1;
    p_nu=1;

    for i=1:n_sample
        if Residual_Interstorey_drift(i,s)>1.0
        else
            EDP_ResIDR_u(p,s)= Residual_Interstorey_drift(i,s);
            EDP_PeakIDR_u(p,s) = Peak_Interstorey_drift(i,s);
            EDP_PeakTheta_u(p,s) = Peak_theta(i,s);
            IM_EDP_u(p,s)= Sa(i);
            p=p+1;
        end
        
        if Residual_Interstorey_drift_nu(i,s)>1.0
        else
            EDP_ResIDR_nu(p_nu,s)= Residual_Interstorey_drift_nu(i,s);
            EDP_PeakIDR_nu(p_nu,s) = Peak_Interstorey_drift_nu(i,s);
            EDP_PeakTheta_nu(p_nu,s) = Peak_theta_nu(i,s);
            IM_EDP_nu(p_nu,s)= Sa(i);
            p_nu=p_nu+1;
        end
    
    end
    p_matrix(s,1)=p-1;
    p_matrix_nu(s,1)=p_nu-1;

end
