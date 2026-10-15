clear;
clc;
close all;

%% Case
caseName = 'virtual_imp_1ph_amp';

dataDir = 'C:/ΔΙΠΛΩΜΑΤΙΚΗ ΙΣΧΥΟΣ/LaTex/plots/';

%% Load data
Rv_data = readmatrix(fullfile(dataDir, [caseName '_Rv.csv']));
Xv_data = readmatrix(fullfile(dataDir, [caseName '_Xv.csv']));

t  = Rv_data(:,1);
Rv = Rv_data(:,2);
Xv = Xv_data(:,2);

%% Plot
figure('Color','w');

tiledlayout(2,1,'TileSpacing','compact','Padding','compact');


nexttile;
plot(t, Rv, 'LineWidth', 1.4);
grid on;
ylabel('$R_v$ [$\Omega$]', 'Interpreter','latex');
xlim([3 4.2]);

nexttile;
plot(t, Xv, 'LineWidth', 1.4);
grid on;
ylabel('$X_v$ [$\Omega$]', 'Interpreter','latex');
xlabel('Time [s]', 'Interpreter','latex');
xlim([3 4.2]);

%% Export
exportgraphics(gcf, ...
    fullfile(dataDir, [caseName '_virtual_admittance_parameters.pdf']), ...
    'ContentType','vector');