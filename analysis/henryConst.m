function K = henryConst(phi,H,T)
% T is temperature
% phi is the "energy surface" - invoke by e.g. esurf.eps2

simga_wf   = 1.0;
epsilon_wf = 1.0;
 
temp1 = sigma_wf/H * trapz(phi(:,1),phi(:,2));

