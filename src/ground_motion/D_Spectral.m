%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Script for the derivation of the displacement, velocity and acceleration
% spectra for a given accelerogram ug through Newmark Algorithm
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Legend
% T: first fundamental period
% xi: damping coefficient (usually 5%)
% ug: accelerogram
% dt: time step size

function [Sa] = D_Spectral(T,xi,ug,dt)
w=2*pi/T;
nstp = size(ug,1); 
Sd=0;
Sv=0;
Sa=0; 
A=w.^2+4/dt*(xi*w)+4/dt.^2;
B=4*(xi*w+1/dt);
u=0;
ud=0;
udd=-ug(1)-2*xi*w*ud-w^2*u; j=1;
for i=2:nstp
du=(-(ug(i)-ug(i-1))+B*ud+2*udd)/A;
dud=2*du/dt-2*ud;
dudd=4.*(du-ud.*dt)/(dt.*dt)-2.*udd;
u=u+du;
ud=ud+dud;
udd=udd+dudd;
Sd=max(Sd,abs(u));
Sv=max(Sv,abs(ud));
Sa=max(Sa,abs(udd+ug(i)));
end;