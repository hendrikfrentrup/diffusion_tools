function plotViscosity

rho  = 0.01:0.005:1.275;
T    = 0.5:0.1:2;

visc=zeros(length(T),length(rho));
for i=1:length(T)
    visc(i,:)=viscLJ(T(i),rho);
end

hold on
for i=1:length(T)
    plot(rho,visc(i,:))
end

Ly=8.735805;
dpdx=;
H=1.5;
j=Ly.*rho/2./viscLJ(1.5,rho)*dpdx*(H^3/16)

end

