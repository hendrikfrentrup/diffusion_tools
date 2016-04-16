


%% get data

system = {'WCA' 'LJ' 'EPS2'};
pore   = {'h1.5' 'h4.0'};
rho    = {'rho001' 'rho003' 'rho005' 'rho01' 'rho02' 'rho03' 'rho04' 'rho05' 'rho06' 'rho07'};
forces = {'f005' 'f02' 'f05' 'f1' 'f2' 'f4' 'f6' 'f8' 'fx' 'fx2' 'fx6' 'fxx'};
%%
clear all;
cd './WCA/h1.5/rho001'

%% get forces
filename = 'flux_data.csv';
fid = fopen(filename);

forces = zeros(12,1);
for i=1:12
 tline = fgetl(fid);
 a = textscan(tline, '%f');
 forces(i) = a{1};
end
WCA.h1.rho001.forces = forces;

fluxes = zeros(12,1);
for i=1:12
 tline = fgetl(fid);
 a = textscan(tline, '%f');
 fluxes(i) = a{1};
end
WCA.h1.rho001.fluxes = fluxes;

DrhoDx = zeros(12,2);
for i=1:12
 tline = fgetl(fid);
 a = textscan(tline, '%f');
 fluxes(i) = a{1};
end
WCA.h1.rho001.fluxes = fluxes;
fclose(fid);