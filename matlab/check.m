clear;
clc;
close all;

%% ============================================================
%  FILES
% =============================================================

files = {
    '1ph_amp_disturbance.csv'
    '2ph_amp_disturbance.csv'
    '3ph_amp_disturbance.csv'
    '1ph_ph_disturbance.csv'
};

titles = {
    'Single-Phase Voltage Sag'
    'Two-Phase Voltage Sag'
    'Three-Phase Voltage Sag'
    'Single-Phase Phase-Angle Jump'
};

%% ============================================================
%  PLOT SETTINGS
% =============================================================

% Time interval shown in the thesis figure
tMin = 3.0;
tMax = 3.7;

% Voltage limits in kV
vMin = -110;
vMax = 110;

% If PLECS exports voltage in volts:
voltageScale = 1e3;

% If your CSV already contains kV, use instead:
% voltageScale = 1;

% Line width
lineWidth = 0.9;

% Phase colours
colorA = [0.90 0.15 0.15];    % red
colorB = [0.10 0.70 0.15];    % green
colorC = [0.45 0.45 0.85];    % blue/purple

%% ============================================================
%  CREATE FIGURE
% =============================================================

fig = figure( ...
    'Color','w', ...
    'Units','centimeters', ...
    'Position',[2 2 18 12]);

tl = tiledlayout(2,2, ...
    'TileSpacing','compact', ...
    'Padding','compact');

%% ============================================================
%  READ CSV FILES AND PLOT
% =============================================================

for k = 1:4

    % Read CSV
    D = readmatrix(files{k});

    % Keep only rows containing a valid time value
    D = D(~isnan(D(:,1)),:);

    % Time
    t = D(:,1);

    % Three-phase PCC voltage
    va = D(:,2) / voltageScale;
    vb = D(:,3) / voltageScale;
    vc = D(:,4) / voltageScale;

    % Create next subplot
    ax = nexttile;

    h1 = plot(t,va, ...
        'Color',colorA, ...
        'LineWidth',lineWidth);

    hold on;

    h2 = plot(t,vb, ...
        'Color',colorB, ...
        'LineWidth',lineWidth);

    h3 = plot(t,vc, ...
        'Color',colorC, ...
        'LineWidth',lineWidth);

    hold off;

    %% Axes
    xlim([tMin tMax]);
    ylim([vMin vMax]);

    xticks(3:0.2:3.6);
    yticks(-100:50:100);

    grid on;
    box on;

    %% Title
    title(titles{k}, ...
        'FontWeight','bold', ...
        'FontSize',10);

    %% Axis appearance
    set(ax, ...
        'FontName','Times New Roman', ...
        'FontSize',9, ...
        'LineWidth',0.8, ...
        'TickDir','out');

    % Only left plots get Y-axis label
    if k == 1 || k == 3
        ylabel('Grid Voltage (kV)', ...
            'FontName','Times New Roman', ...
            'FontSize',10);
    end

    % Only bottom plots get X-axis label
    if k == 3 || k == 4
        xlabel('Time (s)', ...
            'FontName','Times New Roman', ...
            'FontSize',10);
    end

end

%% ============================================================
%  COMMON LEGEND
% =============================================================

lgd = legend([h1 h2 h3], ...
    {'$v_a$','$v_b$','$v_c$'}, ...
    'Interpreter','latex', ...
    'Orientation','horizontal', ...
    'FontSize',9);

lgd.Layout.Tile = 'south';

%% ============================================================
%  EXPORT FOR LATEX / THESIS
% =============================================================

exportgraphics(fig, ...
    'grid_disturbances_overview.pdf', ...
    'ContentType','vector');

disp('Figure saved as: grid_disturbances_overview.pdf');