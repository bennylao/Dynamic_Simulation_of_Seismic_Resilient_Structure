%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%acce
% Quantification of Model Uncertainties on Seismic Response of 
% Eccentrically Braced Frames with Self-Centring Links
%
% Ludovica Pieroni - PhD Candidate UCL 
% 2022/2023
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% MonteCarlo Analysis (model with uncertainties) 

%% Part 1 - Identification of uncertainties and definition of the distributions

% Friction coefficient (mu)
mu_mean=mu;                                                                 % [-] Friction coefficient - Mean Value (Lettieri 2022, Cavallaro 2008)
mu_sigma=mu_mean*mu_COV;                                                    % [-] Friction coefficient - Standard deviation

mu_x=(0:mu_mean/500:2*mu_mean);                                             % [-] Auxiliary vector
mu_PDF=normpdf(mu_x,mu_mean,mu_sigma);                                      % [] Friction coefficient - Probability Density Function

Distribution_mu=figure;
plot(mu_x,mu_PDF);
title ('Distribution of Friction coefficient (mu)');
xlabel('\itmu \rm[ - ]');
ylabel('\itPDF \rm[ - ]');
saveas(gcf,'Figures\Distribution_mu.fig');                                  % .fig for MATLAB® FIG-file

% Pre-loading force of each bolt in the FDs (FpFD)
FpFD_mean=FpFD;                                                             % [kN] Pre-loading force of each bolt in the FDs - Mean Value 
FpFD_sigma=FpFD_mean*FpFD_COV;                                              % [kN] Pre-loading force of each bolt in the FDs - Standard deviation

Distribution_FpFD=figure;
for i=1:storeys
FpFD_x(i,:)=(0:FpFD_mean(i)/500:2*FpFD_mean(i));                            % [kN] Auxiliary vector
FpFD_PDF(i,:)=normpdf(FpFD_x(i,:),FpFD_mean(i),FpFD_sigma(i));              % [] Pre-loading force of each bolt in the FDs - Probability Density Function at each storey (the rows represent the 4 storeys)

plot(FpFD_x(i,:),FpFD_PDF(i,:));
legendInfo_FpFD{i} = ['Storey  ',num2str(i)];
legend(legendInfo_FpFD);
hold on
end

title ('Distribution of Pre-loading force of each bolt in the FDs (FpFD)');
xlabel('\itFpFD \rm[ kN ]');
ylabel('\itPDF \rm[ - ]');
saveas(gcf,'Figures\Distribution_FpFD.fig');                                % .fig for MATLAB® FIG-file

% Post-tensioning force in each PT-bar (FpPT)
FpPT_mean=FpPT;                                                            % [kN] Post-tensioning force in each PT-bar - Mean Value 
FpPT_sigma=FpPT_mean*FpPT_COV;                                              % [kN] Post-tensioning force in each PT-bar - Standard deviation

Distribution_FpPT=figure;
for i=1:storeys
FpPT_x(i,:)=(0:FpPT_mean(i)/500:2*FpPT_mean(i));                            % [kN] Auxiliary vector
FpPT_PDF(i,:)=normpdf(FpPT_x(i,:),FpPT_mean(i),FpPT_sigma(i));              % [] Post-tensioning force in each PT-bar - Probability Density Function at each storey (the rows represent the 4 storeys)

plot(FpPT_x(i,:),FpPT_PDF(i,:));
legendInfo_FpPT{i} = ['Storey  ',num2str(i)];
legend(legendInfo_FpPT);
hold on
end

title ('Distribution of Post-tensioning force in each PT-bar (FpPT)');
xlabel('\itFpPT \rm[ kN ]');
ylabel('\itPDF \rm[ - ]');
saveas(gcf,'Figures\Distribution_FpPT.fig');                                % .fig for MATLAB® FIG-file

%% Part 2 - Definition of the samples

for n=1:n_sample
    rng('shuffle');

    disp(strcat('Montecarlo Simulation # ',num2str(n)))

% Extraction of values for Friction coefficient (mu) 
% Assuming a different value of mu for each simulation (1 value per simulation)
    mu_sample(n)=normrnd(mu_mean,mu_sigma);                                 % [-] Select a randon value of mu from the normal distribution
    mu_PDF_sample(n)=normpdf(mu_sample(n),mu_mean,mu_sigma);                % [-] Compute the value ot PDF associated to the selected randon value of mu 
    
    figure(Distribution_mu);
    hold on
    plot(mu_sample(n),mu_PDF_sample(n),'x');
    saveas(gcf,'Figures\Distribution_mu+sample.fig');

% Extraction of values for Pre-loading force of each bolt in the FDs (FpFD)
% Assuming a different value of FpFD for each bolt of each story for each simulation (6x4 values per simulation)
    for i_nb=1:nb                                                                                 % (the rows reperesent the 4 storeys, the coloumns represent the 6 bolts at each storey, the page represent the simulation)
        for i=1:storeys                                                                         
        FpFD_sample(i,i_nb,n)=normrnd(FpFD_mean(i),FpFD_sigma(i));                                 % [kN] Select a randon value of FpFD from the normal distribution (for each bolt at each storey)
        FpFD_PDF_sample(i,i_nb,n)=normpdf(FpFD_sample(i,i_nb,n),FpFD_mean(i),FpFD_sigma(i));       % [-] Compute the value ot PDF associated to the selected randon value of FpFD
        end
    end 

    figure(Distribution_FpFD);
    hold on
    plot(FpFD_sample(:,:,n),FpFD_PDF_sample(:,:,n),'x', 'HandleVisibility','off');
    saveas(gcf,'Figures\Distribution_FpFD+sample.fig');

% Extraction of values for Post-tensioning force in each PT-bar (FpPT)
% Assuming a different value of FpPT for each bar of each story for each simulation (4x4 values per simulation)
    for i_npt=1:npt                                                                               % (the rows reperesent the 4 storeys, the coloumns represent the 4 PT bars at each storey, the page represent the simulation)
        for i=1:storeys;                                                                         
        FpPT_sample(i,i_npt,n)=normrnd(FpPT_mean(i),FpPT_sigma(i));                                % [kN] Select a randon value of FpPT from the normal distribution (for each PT bar at each storey)
        FpPT_PDF_sample(i,i_npt,n)=normpdf(FpPT_sample(i,i_npt,n),FpPT_mean(i),FpPT_sigma(i));     % [-] Compute the value ot PDF associated to the selected randon value of FpPT
        end
    end 

    figure(Distribution_FpPT);
    hold on
    plot(FpPT_sample(:,:,n),FpPT_PDF_sample(:,:,n),'x','HandleVisibility','off');
    saveas(gcf,'Figures\Distribution_FpPT+sample.fig');

% Compute the forces based on the estracted values of mu, FpFD, FpPT (which are the variable with uncertanties) 
% (the rows reperesent the 4 storeys, the coloumns represent the 240 simulations)
    F_FD_sample(:,n)=mu_sample(n)*ns*sum(FpFD_sample(:,:,n)')';                                            % [kN] Compute the value of F_FD (Sliding forces developed in the friction pads) usign the values from the sample                                       
    F_PT0_sample(:,n)=sum(FpPT_sample(:,:,n)')';                                                           % [kN] Compute the value of F_PT0 (Initial post-tensioning force applied in the PT-bars) usign the values from the sample 

% Compute the flag shape behaviour in terms of longitudinal shear forces (Fl) based on the estracted values of mu, FpFD, FpPT
% (the rows reperesent the 4 storeys, the coloumns represent the 240 simulations)
    Fl_p1_sample(:,n)=F_PT0_sample(:,n)+F_FD_sample(:,n);                                                  % [kN] point 1 for storey 1,2,3 and 4 (the rows represent the 4 storeys)
    Fl_p2_sample(:,n)=1.5.*Fl_p1_sample(:,n);                                                              % [kN] point 2 for storey 1,2,3 and 4 (the rows represent the 4 storeys)
    Fl_p3_sample(:,n)=Fl_p2_sample(:,n)-2.*F_FD_sample(:,n);                                               % [kN] point 3 for storey 1,2,3 and 4 (the rows represent the 4 storeys)
    Fl_p4_sample(:,n)=Fl_p1_sample(:,n)-2.*F_FD_sample(:,n);                                               % [kN] point 4 for storey 1,2,3 and 4 (the rows represent the 4 storeys)

    %(the rows represent the 4 storeys, the coloumns represent the 4 points of the fs behaviour p1,p2,p3,p4, the page represent the simulation)
    Fl_fs_sample(:,:,n)=[Fl_p1_sample(:,n),Fl_p2_sample(:,n),Fl_p3_sample(:,n),Fl_p4_sample(:,n)];         % [kN] FS beahiour in terms of Fl 

% Compute the flag shape behaviour in terms of transverse shear forces (V)(Fl---tranformed in---F---tranformed in---V) based on the estracted values of mu, FpFD, FpPT
% (the rows represent the 4 storeys, the coloumns represent the 4 points of the fs behaviour p1,p2,p3,p4,the page represent the simulation)
    F_fs_sample(:,:,n)=Fl_fs_sample(:,:,n).*L_span.*aux_h./(aux_H_storey.*aux_L_link);                         % [kN] Storey's shear force at storeys 1,2,3,4 (inverse formula Eq.1.3, Lettieri 2022)
    V_fs_sample(:,:,n)=F_fs_sample(:,:,n).*aux_H_storey./L_span;                                               % [kN] FS beahiour in terms of V (Eq.1.1, Lettieri 2022) -----------------------------------in Opensees model- different at each storey

    aux_V_fs_sample(:,:,n)=-V_fs_sample(:,:,n);                             % [kN] Auxiliary matrix

    V_fs_fig_sample(:,:,n)=[aux_zeros,V_fs_sample(:,:,n),aux_zeros,aux_V_fs_sample(:,:,n),aux_zeros];                                                 
    theta_fs_fig=[aux_zeros,aux_zeros, aux_theta_d, aux_theta_d, aux_zeros, aux_zeros, aux_zeros, -aux_theta_d, -aux_theta_d, aux_zeros, aux_zeros];

    figure(fs_behaviour)
    for i=1:storeys
        subplot(2,2,i);
        hold on;
        plot(theta_fs_fig(i,:),V_fs_fig_sample(i,:,n));
    end
    ylim([-500, 500])
  saveas(gcf,'Figures\FS+sample.fig')    

% Compute the parameters for the Opensees Model based on the estracted values of mu, FpFD, FpP
% (the rows reperesent the storeys, the coloumns represent the parameters for the sc behaviour #uniaxialMaterial SelfCentering .... $k2 $sigAct $beta,the page represent the simulation)
for i=1:storeys
    model_sample(i,1,n)= (V_fs_sample(i,2,n)-V_fs_sample(i,1,n))/(delta_v(i)/1000);              % [kN/m] $k2
    model_sample(i,2,n)= V_fs_sample(i,1,n);                                                     % [kN] $sigAct
    model_sample(i,3,n)= (V_fs_sample(i,2,n)-V_fs_sample(i,3,n))/V_fs_sample(i,1,n);             % [-] $beta
end
end

