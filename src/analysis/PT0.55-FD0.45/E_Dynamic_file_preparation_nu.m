%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Quantification of Model Uncertainties on Seismic Response of 
% Eccentrically Braced Frames with Self-Centring Links
%
% Ludovica Pieroni - PhD Candidate UCL 
% 2022/2023
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Cloud Analysis (no model uncertainties)
% Prepare the input files for the Cloud Analysis

for n=1:n_sample

%     fid=fopen(strcat('Analysis_',num2str(n),'/acc_',num2str(n),'.txt'),'w');
%     fprintf( fid,'%3.4f\n',acc(:,n));     
%     fclose(fid);    
    
    fid = fopen(strcat('input_dynamic_nu_',num2str(n),'.tcl'),'w');
    fprintf(fid,'% s\n','wipe');

    fprintf(fid,'% s\n','#Accelerogram number');
    fprintf(fid,'set n %2.0f\n',n );

    fprintf(fid,'% s\n','#Parameters for SC MATERIALS');

    fprintf(fid,'set k2_s1 %5.4f\n',model(1,1));
    fprintf(fid,'set k2_s2 %5.4f\n',model(2,1));
    fprintf(fid,'set k2_s3 %5.4f\n',model(3,1));
    fprintf(fid,'set k2_s4 %5.4f\n',model(4,1));

    fprintf(fid,'set sigAct_s1 %5.4f\n',model(1,2));
    fprintf(fid,'set sigAct_s2 %5.4f\n',model(2,2));
    fprintf(fid,'set sigAct_s3 %5.4f\n',model(3,2));
    fprintf(fid,'set sigAct_s4 %5.4f\n',model(4,2));

    fprintf(fid,'set beta_s1 %5.4f\n',model(1,3));
    fprintf(fid,'set beta_s2 %5.4f\n',model(2,3));
    fprintf(fid,'set beta_s3 %5.4f\n',model(3,3));
    fprintf(fid,'set beta_s4 %5.4f\n',model(4,3));

    fprintf(fid,'% s\n','#Parameters for the Dynamic Analysis');
    fprintf(fid,'set dt %5.4f\n',dt(n));
    fprintf(fid,'set numstep %5.0f\n',numstep(n));
    fprintf(fid,'set aR %5.4f\n',aR);
    fprintf(fid,'set bR %5.4f\n',bR); 
    fprintf(fid,['source _Dynamic_SC_nu.tcl'] ); % upload the tcl file for the dynamic analysis

    fclose(fid);

end