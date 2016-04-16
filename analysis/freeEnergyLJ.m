%	This subroutine evaluates the EXCESS Helmholtz free energy 
%	for the spherical LJ potential.
%	It additionally gives the quantity rho^2(dA/drho) needed for
%	the pressure calculations and the residual internal energy U
%	This uses the Kolafa/Nezbeda EOS

function P = freeEnergyLJ(T,rho) %,A_r,dA_drho,U)

% Parameters for the Kolafa/Nezbeda EOS
Aij=[  0.00000    0.000000   0.000000,      0.000000,    0.000000; ...
     -13.37031968 0.000000   29.34470520  -19.58371655   2.01546797; ...
      65.38059570 0.000000 -112.35356937   75.62340289 -28.17881636; ...
    -115.09233113 0.000000  170.64908980 -120.70586598  28.28313847; ...
      88.91973082 0.000000 -123.06669187   93.92740328 -10.42402873; ...
     -25.62099890 0.000000   34.42288969  -27.37737354   0.000000];
% set up the energy KN constants
Cij=Aij;

% Parameters of the Barker-Henderson theory
% -> hard sphere diameter
DBH=[ 0.011117524, -0.076383859, 1.080142248, 0.000693129, -0.063920968];
% -> residual second virial coefficient
DB2=[-0.58544978,   0.43102052,  0.87361369, -4.13749995, ...
      2.90616279,  -7.02181962,  0.000000,    0.02459877];
  
% hybrid Barker-Henderson diameter and its T-derivative
dBH=0;
for i=1:4
    dBH = dBH+DBH(i)*(T^((i-3)/2));
end
dBH = dBH + DBH(5)*log(T);

DdBH_DT=0;
for i=1:4
    DdBH_DT=DdBH_DT + (i-3)*DBH(i)*(T^((i-3)/2));
end
DdBH_DT = -T*((DdBH_DT/2)+DBH(5));

% residual second virial correction and its T-derivative
B2=0;
for i=1:8
    B2=B2+DB2(i)*(T^((i-8)/2));
end

DB2_DT=0;
for i=1:8
    DB2_DT=DB2_DT+(i-8)*DB2(i)*(T^((i-8)/2));
end
DB2_DT=-DB2_DT*T/2;


F=exp(-1.92907278*rho.*rho);

% hard sphere density
nu = pi * rho*(dBH^3)/6;

% helmholtz energy
A_r = (34 - 33*nu + 4*nu.^2) .* nu./(6*((1-nu).^2));
A_r = T*( A_r + 5*log(1-nu)/3 );
A_r = A_r + F.*rho.*T.*B2;
for i=1:6
    for j=1:5
        A_r = A_r + Cij(i,j)*(T^(0.5*(i-5))).*(rho.^j);
    end
end

% hard sphere compressibility
Z_HS = 1 + nu + nu.^2 - 2*(nu.^3).*(1+nu)./3;
Z_HS = Z_HS./((1-nu).^3);

Z = Z_HS+rho.*(1 - 2*1.92907278.*rho.^2).*F*B2;

for i=1:6
    for j=1:5
        Z = Z + j*Cij(i,j)*(T^(0.5*(i-5)-1))*(rho.^j);
    end
end

dA_drho = (Z-1).*rho*T;


% calculate the residual energy U
U=(3*(Z_HS-1)*DdBH_DT/dBH) + F.*rho*DB2_DT;
for i=1:6
    for j=1:5
        U = U - (0.5*(i-5)-1)*Cij(i,j)*(T^(0.5*(i-5)))*(rho.^j);
    end  
end

%disp(nu)
%disp(Z)
%disp(A_r)
%disp(dA_drho)
%disp (U)

P = T*rho+dA_drho;