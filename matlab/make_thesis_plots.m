clear;
close all;
clc;

%% ============================================================
%  USER SETTINGS
% =============================================================

% Simulation case - CHANGE ONLY THIS
caseTag = ['1ph_ph'];

% Automatic file prefix
caseName = ['Prot_+_' caseTag];

% Input / output folders
dataDir = pwd;
outDir  = fullfile(pwd, 'figures', 'results', caseName);

if ~exist(outDir, 'dir')
    mkdir(outDir);
end

%% System parameters

Sb = 60e6;          % VA
Vb = 130e3;         % V

Ib   = Sb/(sqrt(3)*Vb);
Imax = 1.2*Ib;      % A

% Plotting time interval
% [] means show the entire simulation
timeWindow = [];

%% Scaling factors

currentScale = 1;       % A
voltageScale = 1e3;     % V -> kV
powerScale   = 1e6;     % W -> MW / var -> MVAr


%% ============================================================
%  LOAD PLECS DATA
% =============================================================

% Three-phase inverter current
Iabc = readmatrix(fullfile(dataDir,[caseName '_I.csv']));
Iabc = Iabc(isfinite(Iabc(:,1)),:);

% Three-phase PCC voltage
Vabc = readmatrix(fullfile(dataDir,[caseName '_voltage.csv']));
Vabc = Vabc(isfinite(Vabc(:,1)),:);

% Positive-sequence active power
Ppos = readmatrix(fullfile(dataDir,[caseName '_P.csv']));
Ppos = Ppos(isfinite(Ppos(:,1)),:);

% Positive-sequence reactive power
Qpos = readmatrix(fullfile(dataDir,[caseName '_Q.csv']));
Qpos = Qpos(isfinite(Qpos(:,1)),:);

% Positive-sequence dq current
IdqP = readmatrix(fullfile(dataDir,[caseName '_idq_pos.csv']));
IdqP = IdqP(isfinite(IdqP(:,1)),:);

% Negative-sequence dq current
IdqN = readmatrix(fullfile(dataDir,[caseName '_idq_neg.csv']));
IdqN = IdqN(isfinite(IdqN(:,1)),:);

IdPosRef = readmatrix(fullfile(dataDir, [caseName '_id_pos_ref.csv']));
IdPosRef = IdPosRef(isfinite(IdPosRef(:,1)),:);

IqPosRef = readmatrix(fullfile(dataDir, [caseName '_iq_pos_ref.csv']));
IqPosRef = IqPosRef(isfinite(IqPosRef(:,1)),:);

IdNegRef = readmatrix(fullfile(dataDir, [caseName '_id_neg_ref.csv']));
IdNegRef = IdNegRef(isfinite(IdNegRef(:,1)),:);

IqNegRef = readmatrix(fullfile(dataDir, [caseName '_iq_neg_ref.csv']));
IqNegRef = IqNegRef(isfinite(IqNegRef(:,1)),:);

%% ============================================================
%  1. THREE-PHASE INVERTER CURRENT
% =============================================================

t  = Iabc(:,1);
ia = Iabc(:,2)/currentScale;
ib = Iabc(:,3)/currentScale;
ic = Iabc(:,4)/currentScale;

fig = figure;
set(fig,'Units','centimeters','Position',[2 2 16 8],'Color','w');

plot(t,ia,'r','LineWidth',1.15);
hold on;
plot(t,ib,'g','LineWidth',1.15);
plot(t,ic,'b','LineWidth',1.15);

% Automatic current-limit lines
yline(Imax/currentScale,'k--', ...
    '$I_{\max}$', ...
    'Interpreter','latex', ...
    'LineWidth',1.0);

yline(-Imax/currentScale,'k--', ...
    '$-I_{\max}$', ...
    'Interpreter','latex', ...
    'LineWidth',1.0);

% addFaultLines(tFault,tClear);
grid on;
box on;

ax = gca;
ax.FontSize = 11;
ax.LineWidth = 0.8;

if ~isempty(timeWindow)
    xlim(timeWindow);
else
    xlim([t(1) t(end)]);
end

xlabel('Time (s)');
ylabel('Current (A)');

lgd = legend('$i_a$','$i_b$','$i_c$', ...
    'Interpreter','latex', ...
    'Location','east');

lgd.FontSize = 9;
lgd.ItemTokenSize = [12 8];

exportgraphics(fig, ...
    fullfile(outDir,['current_' caseTag '.pdf']), ...
    'ContentType','vector');

close(fig);


%% ============================================================
%  2. THREE-PHASE PCC VOLTAGE
% =============================================================

t  = Vabc(:,1);
va = Vabc(:,2)/voltageScale;
vb = Vabc(:,3)/voltageScale;
vc = Vabc(:,4)/voltageScale;

fig = figure;
set(fig,'Units','centimeters','Position',[2 2 16 8],'Color','w');

plot(t,va,'r','LineWidth',1.15);
hold on;
plot(t,vb,'g','LineWidth',1.15);
plot(t,vc,'b','LineWidth',1.15);

grid on;
box on;

ax = gca;
ax.FontSize = 11;
ax.LineWidth = 0.8;

if ~isempty(timeWindow)
    xlim(timeWindow);
else
    xlim([t(1) t(end)]);
end

xlabel('Time (s)');
ylabel('PCC Voltage (kV)');

lgd = legend('$v_a$','$v_b$','$v_c$', ...
    'Interpreter','latex', ...
    'Location','southeast');

lgd.FontSize = 9;
lgd.ItemTokenSize = [12 8];

exportgraphics(fig, ...
    fullfile(outDir,['voltage_' caseTag '.pdf']), ...
    'ContentType','vector');

close(fig);

%% ============================================================
%  3. POSITIVE-SEQUENCE ACTIVE POWER
% =============================================================

t = Ppos(:,1);
P = Ppos(:,2)/powerScale;

fig = figure;
set(fig,'Units','centimeters','Position',[2 2 16 8],'Color','w');

plot(t,P,'b','LineWidth',1.2);

grid on;
box on;

ax = gca;
ax.FontSize = 11;
ax.LineWidth = 0.8;

if ~isempty(timeWindow)
    xlim(timeWindow);
else
    xlim([t(1) t(end)]);
end

xlabel('Time (s)');
ylabel('$P^{+}$ (MW)','Interpreter','latex');

exportgraphics(fig, ...
    fullfile(outDir,['active_power_' caseTag '.pdf']), ...
    'ContentType','vector');

close(fig);

%% ============================================================
%  4. POSITIVE-SEQUENCE REACTIVE POWER
% =============================================================

t = Qpos(:,1);
Q = Qpos(:,2)/powerScale;

fig = figure;
set(fig,'Units','centimeters','Position',[2 2 16 8],'Color','w');

plot(t,Q,'r','LineWidth',1.2);

grid on;
box on;

ax = gca;
ax.FontSize = 11;
ax.LineWidth = 0.8;

if ~isempty(timeWindow)
    xlim(timeWindow);
else
    xlim([t(1) t(end)]);
end

xlabel('Time (s)');
ylabel('$Q^{+}$ (MVAr)','Interpreter','latex');

exportgraphics(fig, ...
    fullfile(outDir,['reactive_power_' caseTag '.pdf']), ...
    'ContentType','vector');

close(fig);

%% ============================================================
%  5. POSITIVE-SEQUENCE dq CURRENTS
% =============================================================

t   = IdqP(:,1);
idp = IdqP(:,2)/currentScale;
iqp = IdqP(:,3)/currentScale;

fig = figure;
set(fig,'Units','centimeters','Position',[2 2 16 8],'Color','w');

plot(t,idp,'Color',[0.8500 0.3250 0.0980],'LineWidth',1.15);
hold on;
plot(t,iqp,'b','LineWidth',1.15);

grid on;
box on;

ax = gca;
ax.FontSize = 11;
ax.LineWidth = 0.8;

if ~isempty(timeWindow)
    xlim(timeWindow);
else
    xlim([t(1) t(end)]);
end

xlabel('Time (s)');
ylabel('Positive-Sequence Current (A)');

lgd = legend('$i_d^{+}$','$i_q^{+}$', ...
    'Interpreter','latex', ...
    'Location','southeast');

lgd.FontSize = 9;
lgd.ItemTokenSize = [12 8];

exportgraphics(fig, ...
    fullfile(outDir,['idq_positive_' caseTag '.pdf']), ...
    'ContentType','vector');

close(fig);

%% ============================================================
%  6. NEGATIVE-SEQUENCE dq CURRENTS
% =============================================================

t   = IdqN(:,1);
idn = IdqN(:,2)/currentScale;
iqn = IdqN(:,3)/currentScale;

fig = figure;
set(fig,'Units','centimeters','Position',[2 2 16 8],'Color','w');

plot(t,idn,'Color',[0.8500 0.3250 0.0980],'LineWidth',1.15);
hold on;
plot(t,iqn,'b','LineWidth',1.15);

grid on;
box on;

ax = gca;
ax.FontSize = 11;
ax.LineWidth = 0.8;

if ~isempty(timeWindow)
    xlim(timeWindow);
else
    xlim([t(1) t(end)]);
end

xlabel('Time (s)');
ylabel('Negative-Sequence Current (A)');

lgd = legend('$i_d^{-}$','$i_q^{-}$', ...
    'Interpreter','latex', ...
    'Location','southeast');

lgd.FontSize = 9;
lgd.ItemTokenSize = [12 8];

exportgraphics(fig, ...
    fullfile(outDir,['idq_negative_' caseTag '.pdf']), ...
    'ContentType','vector');

close(fig);

%% ============================================================
%  POSITIVE-SEQUENCE d-AXIS CURRENT REFERENCE
%  Red = before limitation
%  Green = after limitation
% =============================================================

t = IdPosRef(:,1);

id_after  = IdPosRef(:,2)/currentScale;
id_before = IdPosRef(:,3)/currentScale;

fig = figure;
set(fig,'Units','centimeters','Position',[2 2 16 8],'Color','w');

plot(t,id_before,'r','LineWidth',1.15);
hold on;

plot(t,id_after,'g','LineWidth',1.15);

grid on;
box on;

ax = gca;
ax.FontSize = 11;
ax.LineWidth = 0.8;

if ~isempty(timeWindow)
    xlim(timeWindow);
else
    xlim([t(1) t(end)]);
end

xlabel('Time (s)');
ylabel('Current Reference (A)');

lgd = legend('$i_{d,\mathrm{before}}^{+*}$', ...
       '$i_{d,\mathrm{after}}^{+*}$', ...
       'Interpreter','latex', ...
       'Location','southeast');

lgd.FontSize = 9;
lgd.ItemTokenSize = [12 8];

exportgraphics(fig, ...
    fullfile(outDir,['id_pos_ref_' caseTag '.pdf']), ...
    'ContentType','vector');

close(fig);

%% ============================================================
%  POSITIVE-SEQUENCE q-AXIS CURRENT REFERENCE
% =============================================================

t = IqPosRef(:,1);

iq_after  = IqPosRef(:,2)/currentScale;
iq_before = IqPosRef(:,3)/currentScale;

fig = figure;
set(fig,'Units','centimeters','Position',[2 2 16 8],'Color','w');

plot(t,iq_before,'r','LineWidth',1.15);
hold on;

plot(t,iq_after,'g','LineWidth',1.15);

grid on;
box on;

ax = gca;
ax.FontSize = 11;
ax.LineWidth = 0.8;

if ~isempty(timeWindow)
    xlim(timeWindow);
else
    xlim([t(1) t(end)]);
end

xlabel('Time (s)');
ylabel('Current Reference (A)');

lgd = legend('$i_{q,\mathrm{before}}^{+*}$', ...
       '$i_{q,\mathrm{after}}^{+*}$', ...
       'Interpreter','latex', ...
       'Location','southeast');

lgd.FontSize = 9;
lgd.ItemTokenSize = [12 8];

exportgraphics(fig, ...
    fullfile(outDir,['iq_pos_ref_' caseTag '.pdf']), ...
    'ContentType','vector');

close(fig);

%% ============================================================
%  NEGATIVE-SEQUENCE d-AXIS CURRENT REFERENCE
% =============================================================

t = IdNegRef(:,1);

idn_after  = IdNegRef(:,2)/currentScale;
idn_before = IdNegRef(:,3)/currentScale;

fig = figure;
set(fig,'Units','centimeters','Position',[2 2 16 8],'Color','w');

plot(t,idn_before,'r','LineWidth',1.15);
hold on;

plot(t,idn_after,'g','LineWidth',1.15);

grid on;
box on;

ax = gca;
ax.FontSize = 11;
ax.LineWidth = 0.8;

if ~isempty(timeWindow)
    xlim(timeWindow);
else
    xlim([t(1) t(end)]);
end

xlabel('Time (s)');
ylabel('Current Reference (A)');

lgd = legend('$i_{d,\mathrm{before}}^{-*}$', ...
       '$i_{d,\mathrm{after}}^{-*}$', ...
       'Interpreter','latex', ...
       'Location','southeast');

lgd.FontSize = 9;
lgd.ItemTokenSize = [12 8];

exportgraphics(fig, ...
    fullfile(outDir,['id_neg_ref_' caseTag '.pdf']), ...
    'ContentType','vector');

close(fig);

%% ============================================================
%  NEGATIVE-SEQUENCE q-AXIS CURRENT REFERENCE
% =============================================================

t = IqNegRef(:,1);

iqn_after  = IqNegRef(:,2)/currentScale;
iqn_before = IqNegRef(:,3)/currentScale;

fig = figure;
set(fig,'Units','centimeters','Position',[2 2 16 8],'Color','w');

plot(t,iqn_before,'r','LineWidth',1.15);
hold on;

plot(t,iqn_after,'g','LineWidth',1.15);

grid on;
box on;

ax = gca;
ax.FontSize = 11;
ax.LineWidth = 0.8;

if ~isempty(timeWindow)
    xlim(timeWindow);
else
    xlim([t(1) t(end)]);
end

xlabel('Time (s)');
ylabel('Current Reference (A)');

lgd = legend('$i_{q,\mathrm{before}}^{-*}$', ...
       '$i_{q,\mathrm{after}}^{-*}$', ...
       'Interpreter','latex', ...
       'Location','southeast');

lgd.FontSize = 9;
lgd.ItemTokenSize = [12 8];

exportgraphics(fig, ...
    fullfile(outDir,['iq_neg_ref_' caseTag '.pdf']), ...
    'ContentType','vector');

close(fig);


% %% ============================================================
% %  LOCAL FUNCTIONS
% % =============================================================
% 
% function M = loadPlecsCsv(filename,nColumns)
% 
%     M = readmatrix(filename);
% 
%     % Remove possible header / empty rows
%     M = M(isfinite(M(:,1)),:);
% 
%     if size(M,2) < nColumns
%         error('File %s contains fewer columns than expected.',filename);
%     end
% 
%     M = M(:,1:nColumns);
% end
% 
% 
% function fig = newThesisFigure()
% 
%     fig = figure( ...
%         'Units','centimeters', ...
%         'Position',[2 2 16 8], ...
%         'Color','w');
% 
% end
% 
% 
% function addFaultLines(tFault,tClear)
% 
%     hold on;
% 
%     xline(tFault,'k:', ...
%         'Fault applied', ...
%         'LabelVerticalAlignment','bottom', ...
%         'LineWidth',0.9);
% 
%     xline(tClear,'k:', ...
%         'Fault cleared', ...
%         'LabelVerticalAlignment','bottom', ...
%         'LineWidth',0.9);
% 
% end
% 
% 
% function applyThesisStyle(timeWindow)
% 
%     grid on;
%     box on;
% 
%     ax = gca;
% 
%     ax.FontSize = 10;
%     ax.LineWidth = 0.8;
%     ax.TickLabelInterpreter = 'latex';
% 
%     if ~isempty(timeWindow)
%         xlim(timeWindow);
%     end
% 
% end