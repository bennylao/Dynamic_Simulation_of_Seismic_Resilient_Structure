%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Quantification of Model Uncertainties on Seismic Response of 
% Eccentrically Braced Frames with Self-Centring Links
%
% Ludovica Pieroni - PhD Candidate UCL 
% 2022/2023
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% A_MAIN FILE

%% Initiate the code
close all
clear
clc 
format shortG

%% Acronyms
% FD: Friction Dampers
% PT: Post Tentioned Bars
% fs: Flag Shape
% nu: No Uncertainties

%% Geometric properties 

storeys=4;                                                                  % Number of storeys (Figure 4, Lettieri et al 2022)
H_storey=[3.5; 3.2; 3.2; 3.2]*1000;                                         % [mm] Storeys' 1,2,3,4 height (Figure 4, Lettieri et al 2022)
L_span=(6)*1000;                                                            % [mm] Span's lenght (Figure 4, Lettieri et al 2022)

%% Outupts of the design of the conventional steel EBF

Fl=[2152; 1802; 1434; 768];                                                 % [kN] Total longitudinal shear forces at storeys 1,2,3,4 (Table 2, Lettieri et al 2022)
L_link=[1.1; 1.0; 0.9; 0.6]*1000;                                           % [mm] Links' lenght at storeys 1,2,3,4 (Table 1, Lettieri et al 2022)

% Section of the link at storeys 1,2,3,4; HE360B, HE320B, HE280B, HE200B (Table 1, Lettieri et al 2022)
hd=[360; 320; 280; 200];                                                    % [mm] Height of the section of the link 
tf=[22.5; 20.5; 18.0; 15.0];                                                % [mm] Flange thickness of the section of the link

%% Parameters for the design of the SC steel EBF 
gamma_PT=0.55;                                                              % [-] Repartition factor of Fl - force that goes to PT Bars
gamma_FD=1-gamma_PT;                                                       % [-] Repartition factor of Fl - force that goes to FDs

theta_d=0.08;                                                               % [rad] Design link rotation -------------------------------------------------------------------------------in Opensees model-same for all storeys (sigAct inital)

nb=6;                                                                       % [-] Number of bolts in the FDs (i.e., assumed equal to 6 in the considered configuration)
npt=4;                                                                      % [-] Number of PT Bars (i.e., assumed equal to 4 in the considered configuration)

mu=0.53;                                                                    % [-] Friction coefficient - Mean Value (Lettieri 2022, Cavallaro 2008)
ns=2;                                                                       % [-] Number of the friction interfaces (i.e., two in the considered configuration)

%% Model with no uncertainties 
B_Model_nu

%% MonteCarlo Analysis (model with uncertainties)

% Dimension of the sample for Monte Carlo analysis
n_sample=240;                                                                % [-] 

% Friction coefficient (mu)
mu_COV=0.08;                                                                % [-] Friction coefficient - Coefficient of Variation (Lettieri et al 2022, Cavallaro et al 2008)-----------????? Not consistent

% Pre-loading force of each bolt in the FDs (FpFD)
FpFD_COV=0.06;                                                              % [-] Pre-loading force of each bolt in the FDs - Coefficient of Variation (EN 1090-2)

% Post-tensioning force in each PT-bar (FpPT)
FpPT_COV=0.06;                                                              % [-] Post-tensioning force in each PT-bar - Coefficient of Variation (EN 1090-2)

% Crete the samples for Montecarlo Analysis
tic
C_Montecarlo_Analysis;
toc

close all
save('Z01_allvariable_MC.mat')

%% Cloud Analysis (record-to-record variability+model uncertainties)

% Results from Modal analysis
T=[0.5433;0.1989;0.1131;0.0818];                                            % [-] Periods of vibration
aR=0.5080;                                                                  % Rayleigh Damping (assuming 3% viscous damping)
bR=0.0014;                                                                  % Rayleigh Damping (assuming 3% viscous damping)

% Load the ground motion records
load ('D_Ground_Motions_Baker_240_zeros.mat');

% Prepare the input files for the Cloud Analysis 
E_Dynamic_file_preparation;
E_Dynamic_file_preparation_nu;

% Run cloud analysis

tic 
parfor n=1:n_sample    
    dos(strcat('opensees input_dynamic_',num2str(n),'.tcl'));
    dos(strcat('opensees input_dynamic_nu_',num2str(n),'.tcl'));
end
toc

% Delete useless variables
for n=1:n_sample
delete(strcat('input_dynamic_',num2str(n),'.tcl'));
delete(strcat('input_dynamic_nu_',num2str(n),'.tcl'));
end

save('Z02_allvariable_CA.mat')

%% Post processing
F_PostProcessing
save('Z03_allvariable_PP.mat')

%% Remove outliners and plot results
FF_Outliers_Removal

%% Plot results (Peak Interstory drifts, Peak Theta, Residual Interstory Drifts)
G_Plot_Results

%% Create Linear Regression for Peak IDR and Peak Theta
H_Linear_Regression

%% Logistic Regression for ResIDR, PeakIDR and Peak Theta
I_logistic_Regression
