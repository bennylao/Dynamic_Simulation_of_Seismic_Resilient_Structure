%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Quantification of Model Uncertainties on Seismic Response of 
% Eccentrically Braced Frames with Self-Centring Links
%
% Ludovica Pieroni - PhD Candidate UCL 
% 2022/2023
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Post-Processing of the results

%% IM (Intensity Measure)
for n=1:n_sample
accIM = acc(1:numstep(n),(n));                                             % [m/sec^2]
Sa(n) = (FF_Spectral(T(1),0.02,accIM,dt(n)))/9.81 ;                        % [g]
clearvars accIM
end 

%% EDP (Engineering Demand Parameter)
numstep_max=max(numstep);

time=zeros(numstep_max,n_sample);
time_nu=zeros(numstep_max,n_sample);

numstep_an=zeros(n_sample,1);
numstep_an_nu=zeros(n_sample,1);

Displacement=zeros(numstep_max,storeys,n_sample);
Displacement_nu=zeros(numstep_max,storeys,n_sample);

theta=zeros(numstep_max,storeys,n_sample);
theta_nu=zeros(numstep_max,storeys,n_sample);

Interstorey_drift=zeros(numstep_max,storeys,n_sample);
Interstorey_drift_nu=zeros(numstep_max,storeys,n_sample);

for n=1:n_sample
    D = importdata(['Analysis_',num2str(n),'/Displacement.out']);
    D_nu = importdata(['Analysis_',num2str(n),'/Displacement_nu.out']);

    i_numstep_an=size(D,1);
    i_numstep_an_nu=size(D_nu,1);

    i_time=D(:,1);
    i_time_nu= D_nu(:,1);

    i_Displacement=D(:,2:size(D,2));
    i_Displacement_nu=D_nu(:,2:size(D_nu,2));

   for s=1:storeys
       i_theta(:,s)=abs(i_Displacement(:,s)).*(L_span/(L_link(s)*H_storey(s)))*1000;    % [-] Frame sway displacement at storeys 1,2,3,4 (inverse formula Eq.2.1, Lettieri 2022)---------------------------------Leo's Code?????????? rows 268-274 Parameters 
       i_theta_nu(:,s)=abs(i_Displacement_nu(:,s)).*(L_span/(L_link(s)*H_storey(s)))*1000;

        if s==1
            i_Interstorey_drift(:,s)=abs(i_Displacement(:,s)/(H_storey(s)/1000));
            i_Interstorey_drift_nu(:,s)=abs(i_Displacement_nu(:,s)/(H_storey(s)/1000));
        else
            i_Interstorey_drift(:,s)=(abs(i_Displacement(:,s))-abs(i_Displacement(:,s-1)))/(H_storey(s)/1000);
            i_Interstorey_drift_nu(:,s)=(abs(i_Displacement_nu(:,s))-abs(i_Displacement_nu(:,s-1)))/(H_storey(s)/1000);
        end
     
     Peak_Displacement(n,s)=max(abs(i_Displacement(:,s)));
     Peak_theta(n,s)=max(i_theta(:,s));   
     Peak_Interstorey_drift(n,s)=max(abs(i_Interstorey_drift(:,s)))*100;            % [%]
     Residual_Displacement(n,s)=abs(i_Displacement(end,s));
     Residual_Interstorey_drift(n,s)=abs(i_Interstorey_drift(end,s))*100;           % [%]

     Peak_Displacement_nu(n,s)=max(abs(i_Displacement_nu(:,s)));
     Peak_theta_nu(n,s)=max(i_theta_nu(:,s));
     Peak_Interstorey_drift_nu(n,s)=max(abs(i_Interstorey_drift_nu(:,s)))*100;      % [%]
     Residual_Displacement_nu(n,s)=abs(i_Displacement_nu(end,s));
     Residual_Interstorey_drift_nu(n,s)=abs(i_Interstorey_drift_nu(end,s))*100;     % [%]
   end 

    numstep_an(n,1)=i_numstep_an;
    numstep_an_nu(n,1)=i_numstep_an_nu;

    time(1:i_numstep_an,n)=i_time;
    time_nu(1:i_numstep_an_nu,n)=i_time_nu;
    
    Displacement(1:i_numstep_an,:,n)=i_Displacement;
    Displacement_nu(1:i_numstep_an_nu,:,n)=i_Displacement_nu;

    theta(1:i_numstep_an,:,n)=i_theta;
    theta_nu(1:i_numstep_an_nu,:,n)=i_theta_nu;

    Interstorey_drift(1:i_numstep_an,:,n)=i_Interstorey_drift;
    Interstorey_drift_nu(1:i_numstep_an_nu,:,n)=i_Interstorey_drift_nu;

    clearvars D D_nu i_numstep_an i_numstep_an_nu i_time i_time_nu i_Displacement i_Displacement_nu i_theta i_theta_nu i_Interstorey_drift i_Interstorey_drift_nu
end 
                 

