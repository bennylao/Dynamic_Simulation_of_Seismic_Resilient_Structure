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
load (['D_Ground_Motions_Baker_240_zeros.mat']);  % load the accelerograms acc in m/s^2 

%% Ground motion Scaling
DBE = 1.2*9.81;                                  % DBE=1.2g

for k=1:size(acc,2)                                          % Take only 1 accelerogram   
Sa(1,k) = D_Spectral(T1,0.02,acc(:,k),dt(k));                %Sa(T1) referred to the chosen accelerogram
end


%% PLOT the Ground motion Scaling

T_Spettro = 0.01: 0.01:4;

for k=1:size(acc,2)
for ii = 1:length(T_Spettro)
    Sa_T(ii,k) = D_Spectral(T_Spettro(ii),0.02,acc(1:numstep(k),k),dt(k));          % [ m ] [ sec ]   Sa(k) in [m/sec^2]
end
end 


aaa = [T1 T1];
bbb = [0 40.00];
T_matrix=ones(size(T_Spettro,2),size(acc,2)).*T_Spettro';

figure
hold on
p1=plot(T_matrix,Sa_T/9.81);
xlabel('T [ sec ]','FontSize',24,'FontName','Times New Roman')
ylabel('\itS_a\rm [ g ]','FontSize',24,'FontName','Times New Roman')
axis([0 4 0 5])

