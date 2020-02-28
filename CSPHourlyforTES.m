%--------------------------Solar Field Calculation Start ----------raka-------%
clc;
format long;

%% Given Data Based in Midelt Area
%Raka

%data_solar_per_hour Source: Solar Data Online 2005
%theta_z=0.3247; %all angle in radians
%gamma_s=0;      %solar azimuth angle %these 3 variables change with day and time
%I_o=925;        %Irradiance DNI in Midelt Area

I_o=xlsread('Matlab Midelt.xlsx','Sheet1', 'A2:A8761') ;   %Irradiance DNI in midelt Area
theta_z=xlsread('Matlab Midelt.xlsx','Sheet1', 'B2:B8761');
gamma_s=xlsread('Matlab Midelt.xlsx','Sheet1', 'C2:C8761');
    
N=12;            %Zones Discretization, both for radial and azimuthal

h_tower=185;    %height of tower
h_helio=12;     %height of heliostats
A_helio=115;    %Area of one heliostat, similar to project description data

TES_diameter=30.07;  %diameter of TES
D_receiver=16;       %Receiver diameter
A_total=13.4*1e6 ;    %This v"
A_TES=2*0.25*pi*TES_diameter^2;  %Area for 2 TES tanks
A_Powerblock=A_TES;             %assumed to be the same
A_Tower=0.25*pi*D_receiver^2 ;    %land area for tower in m2
A_inner=(A_TES+A_Powerblock+A_Tower)*3;   %Source from real layout
r_h_inner=sqrt((A_inner/pi)) ;   %radius of inner heliostat
A_solarField=A_total-A_inner;
r_h_outer=sqrt((A_total/pi));   %radius of outermost heliostat

theta_h = linspace(0, 2*pi, N); %azimuthal angle from 0-2pi, with N discrete
R = linspace(r_h_inner,r_h_outer , N);           %radius of cell from tower (m)
Rho_f = zeros(N);                       %density of heliostats in a given cell

cosine_eff = zeros(N);               %cosine effectiveness
Q_h = zeros(12,12,8760);                     %Qthermal of solar for each cell
f_att = zeros (N);                  %attenuation loss cell
f_spill = zeros(N);                 %spillage loss cell

for k=1:8760 %Calculating annual power from solar receiver
        
    for i=1:N
    for j=1:N
        
        Rho_f(i,j) = 0.721 * exp(-0.29 * R(i)/h_tower) + 0.03;  % Calculation of single heliostat density
        
        theta_T=atan((h_tower-h_helio)/R(i));       %tower angle
        v_s= [-sin(theta_z(k))*cos(gamma_s(k)); -sin(theta_z(k))*sin(gamma_s(k)); cos(theta_z(k))]; %vector of v_s calculation
        v_t= [sin(theta_h(j))*cos(theta_T); -cos(theta_h(j))*cos(theta_T); sin(theta_T)]; %vector of v_t
                    
        n_h=(v_s+v_t)/abs(norm(v_s+v_t));
        
        cosine_eff(i,j)=dot(v_t,n_h);     %cosine effectiveness value for single cell
        d_r = sqrt(R(i).^2+(h_tower-h_helio).^2);
        f_att(i,j) = 0.1*(d_r)/1000;            %attenuation loss due to distance from tower
        e_surface=0.93*0.95*0.96;                %average value from the lecture slide
        f_spill=0.05;                             %assumed to be 5% losses of power
        f_shadow=0.05;                              %assumed to be 5% losses of power
        f_block=0.05;                                   %assumed to be 5% losses of power
        
        Q_h(i,j,k) = A_helio*I_o(k)*e_surface*cosine_eff(i, j)*(1-f_shadow)*(1-f_block)*(1-f_att(i,j))*(1- f_spill);
    end
    end
end

%% Accumulating all Qh & Mirror Area in the field 

A_cell= zeros(N);   %zero matrix for single cell area

A_total_mirror=0;   %initial value for mirror area, before summing all heliostats

for k=1:8760
    Q_field=0       ;   %initial value 
    for i=1:N-1
    for j=1:N
        A_cell = pi*(R(i+1).^2 - R(i).^2) / N;
        Q_field = Q_field + Rho_f(i,j) * (A_cell / A_helio) * Q_h(i,j,k);
        A_total_mirror=A_total_mirror+A_cell*Rho_f(i,j);
        Q_hourly(k) = Q_field*1e-6;
    end
end
end

%N_heliostat=A_total_mirror/A_helio;
                                                                        
Q_perhour=transpose(Q_hourly(1:8760));
xlswrite('Matlab Midelt.xlsx',Q_perhour,'Sheet1', 'E2');

%--------------------------Solar Field Calculation End ----------raka-------%