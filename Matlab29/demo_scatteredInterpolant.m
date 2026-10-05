%Demonstrate how to use the scatteredInterpolant function
%
%Christopher Lum
%lum@uw.edu

%Version History
%10/03/26: Created
%10/04/26: Added scaling so axes are similar

clear
clc
close all

tic

%% User selections
dataFile = 'dataShuffled.csv';
lineWidth = 2;
markerSize = 14;

alt_scaling_factor      = 1;

simulinkModel = 'scatteredInterpolant_model.slx';

%% Load some data points
data = readmatrix(dataFile);

%scale the data so scatteredInterpolant
data(:,2) = data(:,2)/alt_scaling_factor;

%How many unique z-values are there
uniqueMaxTurn_g = unique(data(:,3));

colorMap = jet(length(uniqueMaxTurn_g));

figh_2D = figure;
hold on
for k=1:length(uniqueMaxTurn_g)
    %Plot data points
    maxTurn_g_k = uniqueMaxTurn_g(k);
    indices = find(data(:,3)==maxTurn_g_k);
    plot(data(indices,1),data(indices,2),'x','Color',colorMap(k,:),'LineWidth',lineWidth,'MarkerSize',markerSize,'DisplayName',['maxTurn\_g = ',num2str(maxTurn_g_k)])
end

xlabel('mach')
ylabel('alt\_kft')
grid on
legend()

%% Use scatteredInterpolant
mach        = data(:,1);
alt_kft     = data(:,2);
maxTurn_g   = data(:,3);

method              = 'natural';
extrapolationMethod = 'none';
interpolant = scatteredInterpolant(mach,alt_kft,maxTurn_g,method,extrapolationMethod);

%% Evaluate over a few individual values
mach_new = [0.5 0.6 1.4 1.5]';
alt_new_kft = [10 31 40 52]'/alt_scaling_factor;
maxTurn_new_g = interpolant(mach_new,alt_new_kft);

disp(['Interpolated points'])
disp([mach_new alt_new_kft maxTurn_new_g])

plot(mach_new,alt_new_kft,'mo','LineWidth',lineWidth,'MarkerSize',markerSize)

%% Evaluate over a rectangular grid values
envelopeExpansionFactor = 0.1;

Lx = max(mach) - min(mach);
mach_vec    = linspace(min(mach)-Lx*envelopeExpansionFactor,max(mach)+Lx*envelopeExpansionFactor,25);

Ly = max(alt_kft) - min(alt_kft);
alt_vec_kft = linspace(min(alt_kft)-Ly*envelopeExpansionFactor,max(alt_kft)+Ly*envelopeExpansionFactor,35);

%Create a rectangular mesh (and transpose the outputs of meshgrid so the
%results are appropriate for usage in Simulink lookup tables later)
[mach_mesh,alt_mesh_kft] = meshgrid(mach_vec,alt_vec_kft);
mach_mesh       = mach_mesh';
alt_mesh_kft    = alt_mesh_kft';

maxTurn_mesh_g = interpolant(mach_mesh,alt_mesh_kft);
zMax = max(max(maxTurn_mesh_g));

figh_3D = figure;
hold on
surf(mach_mesh,alt_mesh_kft,maxTurn_mesh_g)
plot3(mach_mesh,alt_mesh_kft,zMax*ones(size(mach_mesh)),'rx')
xlabel('mach')
ylabel('alt\_kft')
zlabel('maxTurn\_g')
grid on
view([35 35])

for k=1:length(uniqueMaxTurn_g)
    %Plot data points
    maxTurn_g_k = uniqueMaxTurn_g(k);
    indices = find(data(:,3)==maxTurn_g_k);
    plot3(data(indices,1),data(indices,2),maxTurn_g_k*ones(size(data(indices,1))),'x','Color',colorMap(k,:),'LineWidth',lineWidth,'MarkerSize',markerSize,'DisplayName',['maxTurn\_g = ',num2str(maxTurn_g_k)])
end

%% Run in Simulink model
tFinal_s = 1;
deltaT_s = 0.01;

scenario = 'mach_constant_alt_varies';

switch scenario
    case 'mach_varies_alt_constant'
        mach_slope              = max(mach_vec) - min(mach_vec);
        mach_initial_output     = 0;

        alt_slope_kftps         = 0;
        alt_initial_output_kft  = 5/alt_scaling_factor;

    case 'mach_constant_alt_varies'
        mach_slope              = 0;
        mach_initial_output     = 0.8;

        alt_slope_kftps         = max(alt_vec_kft) - min(alt_vec_kft);
        alt_initial_output_kft  = 0;
end

simOut = sim(simulinkModel);
simulink_mach        = simOut.logsout.getElement('mach').Values.Data;
simulink_alt_kft     = simOut.logsout.getElement('alt_kft').Values.Data;
simulink_maxTurn_g   = simOut.logsout.getElement('maxTurn_g').Values.Data;

plot3(simulink_mach,simulink_alt_kft,simulink_maxTurn_g,'m-','LineWidth',lineWidth)

toc
disp('DONE!')