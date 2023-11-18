%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Ground motion scaling 
%
% Ludovica Pieroni - PhD Candidate UCL 
% 2022/2023
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


close all
clear
clc

%% Definition of the variables resulted from the modal analysis
load('Results/001-MODAL_SC.mat','T_SC','aR','bR');
T1 = T_SC(1);
% T1 = 0.54;

%% Load the accelerogram
load (['accelerograms30_5x4.mat']);  % load the accelerograms acc in m/s^2 

%% Ground motion Scaling
DBE = 1.2*9.81;                                  % DBE=1.2g

for k=1:size(acc,2)                                          % Take only 1 accelerogram   
Sa(1,k) = D_Spectral(T1,0.02,acc(:,k),dt(k));                %Sa(T1) referred to the chosen accelerogram
acc_norm(:,k) = acc(:,k)/Sa(1,k);                            % [ - ] accelerogram normalized by Sa(T1)
acc_scaled(:,k) = acc_norm(:,k)*DBE;                         % [m/sec^2]  accelerogram scaled at DBE
end

save ('accelerograms30_5x4_scaled_DBE.mat',"acc_scaled", "dt", "numstep");

%% PLOT the Ground motion Scaling

T_Spettro = 0.01: 0.01:4;

for k=1:size(acc,2)
for ii = 1:length(T_Spettro)
    Sa_T(ii,k) = D_Spectral(T_Spettro(ii),0.02,acc(1:numstep(k),k),dt(k));          % [ m ] [ sec ]   Sa(k) in [m/sec^2]
end

for ii = 1:length(T_Spettro)
    Sa_T_norm(ii,k) = D_Spectral(T_Spettro(ii),0.02,acc_norm(1:numstep(k),k),dt(k));       % [ m ] [ sec ]   Sa(k) in [m/sec^2]
end

for ii = 1:length(T_Spettro)
    Sa_T_scaled(ii,k) = D_Spectral(T_Spettro(ii),0.02,acc_scaled(1:numstep(k),k),dt(k));                 % [ m ] [ sec ]   Sa(k) in [m/sec^2]
end

end 


aaa = [T1 T1];
bbb = [0 40.00];
T_matrix=ones(size(T_Spettro,2),size(acc,2)).*T_Spettro';

figure
hold on
p1=plot(T_matrix,Sa_T/9.81, 'b', 'LineWidth', 1.5)
hold on 
p2=plot(aaa,bbb, 'k', 'LineWidth', 1.5)
xlabel('T [ sec ]','FontSize',24,'FontName','Times New Roman')
ylabel('\itS_a\rm [ g ]','FontSize',24,'FontName','Times New Roman')
lg=legend([p1(1),p2(1)],'Spectra GM','T1');
lg.FontSize = 24;
axis([0 4 0 5])

figure
p4=plot(T_matrix,Sa_T_scaled/9.81, 'r', 'LineWidth', 1.5)
hold on
p5=plot(aaa,bbb, 'k', 'LineWidth', 1.5)
xlabel('T [ sec ]','FontSize',24,'FontName','Times New Roman')
ylabel('\itS_a\rm [ g ]','FontSize',24,'FontName','Times New Roman')
lg=legend([p4(1),p5(1)],'Spectra GM-scaled','T1')
lg.FontSize = 24;
axis([0 4 0 5])

