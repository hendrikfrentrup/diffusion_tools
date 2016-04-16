function eta = viscLJ(T,rho)
% LJ fluid viscosity from Galliero et al. Ind. Eng. Chem. Res., 2005, 44
% (17) pp. 6963-6972 DOI: 10.1021/ie050154t

A_c = 1.0; % 1.0 for LJ fluid, 0.95 for Methane

% Correlation for the collision integral of Neufeld et al. (see Reid,
% Prausnitz, Poling, 'Properties of Gases and Liquids')
om_i = [1.13145 -0.14875 0.52487 -0.7732 2.16178 -2.43787];
Omega_v = om_i(1)*T^om_i(2) + ...
          om_i(3)*exp(om_i(4)*T) + ...
          om_i(5)*exp(om_i(6)*T) ;

% Chapman-Enskog low-density distribution
eta_0 = 0.17629 * T^(1/2) / Omega_v * A_c;


% Residual viscosity
e_i = [0.062692 4.095577 -8.743269e-6 11.124920 2.542477e-6 14.863984];
eta_1 = e_i(1)*(exp(e_i(2)*rho)-1) + ...
        e_i(3)*(exp(e_i(4)*rho)-1) + ...
        e_i(5)/T^2*(exp(e_i(6)*rho)-1);

eta = eta_0 + eta_1;
end