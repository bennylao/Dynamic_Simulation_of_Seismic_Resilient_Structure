%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Quantification of Model Uncertainties on Seismic Response of 
% Eccentrically Braced Frames with Self-Centring Links
%
% Ludovica Pieroni - PhD Candidate UCL 
% 2022/2023
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Model with no uncertainties 

F_FD=(gamma_FD*Fl);                                                         % [kN] Sliding forces developed in the friction pads
F_PT0=(gamma_PT*Fl);                                                        % [kN] Initial post-tensioning force applied in the PT-bars

FpFD=F_FD./(ns*nb*mu);                                                      % [kN] Pre-loading force of each bolt in the FDs (FpFD)
FpPT=F_PT0./npt;                                                            % [kN] Post-tensioning force in each PT-bar (FpPT)

% Flag shape behaviour in terms of longitudinal shear forces (Fl)
Fl_p1=F_PT0+F_FD;                                                           % [kN] point 1 for storey 1,2,3 and 4 (the rows represent the 4 storeys) 
Fl_p2=1.5.*Fl_p1;                                                           % [kN] point 2 for storey 1,2,3 and 4 (the rows represent the 4 storeys)
Fl_p3=Fl_p2-2.*F_FD;                                                        % [kN] point 3 for storey 1,2,3 and 4 (the rows represent the 4 storeys)
Fl_p4=Fl_p1-2.*F_FD;                                                        % [kN] point 4 for storey 1,2,3 and 4 (the rows represent the 4 storeys)

%(the rows represent the 4 storeys, the coloumns represent the 4 points of the fs behaviour p1,p2,p3,p4)
Fl_fs=[Fl_p1,Fl_p2,Fl_p3,Fl_p4];                                            % [kN] FS beahiour in terms of Fl 

h=(hd-tf);                                                                  % [mm]

aux_h=repmat(h,1,storeys);                                                  % [mm] Auxiliary matrix
aux_H_storey=repmat(H_storey,1,storeys);                                    % [mm] Auxiliary matrix
aux_L_link=repmat(L_link,1,storeys);                                        % [mm] Auxiliary matrix

% Flag shape behaviour in terms of transverse shear forces (V) (Fl---tranformed in---F---tranformed in---V)
% (the rows represent the 4 storeys, the coloumns represent the 4 points of the fs behaviour p1,p2,p3,p4)
F_fs=Fl_fs.*L_span.*aux_h./(aux_H_storey.*aux_L_link);                      % [kN] Storey's shear force at storeys 1,2,3,4 (inverse formula Eq.1.3, Lettieri 2022)
V_fs=F_fs.*aux_H_storey./L_span;                                            % [kN] FS beahiour in terms of V (Eq.1.1, Lettieri 2022) -----------------------------------in Opensees model- different at each storey

fs_behaviour=figure;
aux_V_fs=-V_fs;                                                             % [kN] Auxiliary vector
aux_zeros=zeros(4,1);                                                       % [mm] Auxiliary vector
aux_theta_d=theta_d*ones(4,1);                                              % [rad] Auxiliary vector

V_fs_fig=[aux_zeros,V_fs,aux_zeros,aux_V_fs,aux_zeros];                                                 
theta_fs_fig=[aux_zeros,aux_zeros, aux_theta_d, aux_theta_d, aux_zeros, aux_zeros, aux_zeros, -aux_theta_d, -aux_theta_d, aux_zeros, aux_zeros];

for i=1:storeys
subplot(2,2,i);
plot(theta_fs_fig(i,:),V_fs_fig(i,:),'k','LineWidth',1.5);
subtitle(strcat('Storey  ',num2str(i)));
xlabel('\it\theta \rm[ rad ]');
ylabel('\itV\rm[ kN ]');
xlim([-0.09 0.09]);
xticks([0.08]);
end
ylim([-500, 500])
sgtitle('link rotation(\theta)  - transverse shear (V)');
saveas(gcf,'Figures\FS.fig');    

% Flag shape behaviour in terms of vertical dispalcement (delta_v) (theta_d---tranformed in delta_v)
delta_v=theta_d.*(L_link./L_span).*(L_span-L_link)                          % [mm] Auxiliary vector


% Parameters for the Opensees Model
% (the rows reperesent the storeys, the coloumns represent the parameters for the sc behaviour #uniaxialMaterial SelfCentering .... $k2 $sigAct $beta)
for i=1:storeys
    model(i,1)= (V_fs(i,2)-V_fs(i,1))/(delta_v(i)/1000);                    % [kN/m] $k2
    model(i,2)= V_fs(i,1);                                                  % [kN] $sigAct
    model(i,3)= (V_fs(i,2)-V_fs(i,3))/V_fs(i,1);                            % [-] $beta
end

