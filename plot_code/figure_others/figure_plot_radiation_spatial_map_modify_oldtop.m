clc;
clear all;
close all;

load("kTOP_factors.mat");
load("mask_SN.mat");
load('LCELM_1km.mat');
load('LAISAI_1km.mat');
res_v = 0.01;
res_h = 0.01;
lon = (-124+res_h/2):res_h: (-117-res_h/2);
lat = (43-res_v/2):-res_v: (34 + res_v/2);

[lons,lats]=meshgrid(lon,lat);


season_i = 5;

%% annual

variable_name = 'FSDS'; 
load(['data/' variable_name '_seasonal_ELM_only_' num2str(season_i) '_with_oldtop.mat']);
FSDS_TOPs = oldTOP_seasons;
FSDS_PPs = default_seasons;

dif_FSDS = FSDS_TOPs - FSDS_PPs;

variable_name = 'FSA'; 
load(['data/' variable_name '_seasonal_ELM_only_' num2str(season_i) '_with_oldtop.mat']);
FSA_TOPs = oldTOP_seasons;
FSA_PPs = default_seasons;

dif_FSA = FSA_TOPs - FSA_PPs;


variable_name = 'FLDS'; 
load(['data/' variable_name '_seasonal_ELM_only_' num2str(season_i) '_with_oldtop.mat']);
FLDS_TOPs = oldTOP_seasons;
FLDS_PPs = default_seasons;

dif_FLDS = FLDS_TOPs - FLDS_PPs;


variable_name = 'FIRA'; 
load(['data/' variable_name '_seasonal_ELM_only_' num2str(season_i) '_with_oldtop.mat']);
FIRA_TOPs = oldTOP_seasons;
FIRA_PPs = default_seasons;

dif_FIRA = FIRA_TOPs - FIRA_PPs;
dif_FIRA = - dif_FIRA;

dif_Rnet = dif_FSA + dif_FIRA;

colors = flipud(brewermap(17, 'RdBu'));
min_clr = -30;
max_clr = 30;


figure;
set(gcf,'unit','normalized','position',[0.1,0.05,0.5,0.8]);
set(gca, 'Position', [0 0 1 1]);

s=subplot('position', [0.05 + (1-1)*0.32 0.53 0.3 0.42]);
hcb = colormap(s, colors);
title_text = '\Delta\it{SW}_{down}';

plot_spatial_map(lats, lons, dif_FSDS, min_clr, max_clr, title_text, 0, 1,'a');

  
insetPos = [0.08 + (1-1)*0.32 0.56 0.08 0.2]; % Adjust as needed
insetAxes = axes('Position', insetPos);

% Plot the histogram in the inset axes
h = histogram(insetAxes, dif_FSDS(:),100);
set(insetAxes, 'YTickLabel',[]);
set(insetAxes, 'YColor', 'none'); % Hide y-axis line and ticks
set(insetAxes, 'YTick', []); % Optionally, remove y-tick marks
% 
set(h, 'EdgeColor', [1, 0.5, 0.2]); % Optional: set edge color of bars
set(h,'FaceColor',[1, 0.5, 0.2]);

xlim(insetAxes, [-60, 60]);
box off

%% FSA
s=subplot('position', [0.05 + (2-1)*0.32 0.53 0.31 0.42]);
hcb = colormap(s, colors);
title_text = '\Delta\it{SW}_{net}';

plot_spatial_map(lats, lons, dif_FSA, min_clr, max_clr, title_text, 0,0,'b');


insetPos = [0.08 + (2-1)*0.32 0.56 0.08 0.2]; % Adjust as needed
insetAxes = axes('Position', insetPos);

% Plot the histogram in the inset axes
h = histogram(insetAxes, dif_FSA(:),100);
set(insetAxes, 'YTickLabel',[]);
set(insetAxes, 'YColor', 'none'); % Hide y-axis line and ticks
set(insetAxes, 'YTick', []); % Optionally, remove y-tick marks

set(h, 'EdgeColor', [1, 0.5, 0.2]); % Optional: set edge color of bars
set(h,'FaceColor',[1, 0.5, 0.2]);

xlim(insetAxes, [-60, 60]);
box off


%% FLDS
s=subplot('position', [0.05 + (3-1)*0.32 0.53 0.31 0.42]);
hcb = colormap(s, colors);
title_text = '\Delta\it{LW}_{down}';

plot_spatial_map(lats, lons, dif_FLDS, min_clr, max_clr, title_text, 0, 0,'c');

insetPos = [0.08 + (3-1)*0.32 0.56 0.08 0.2]; % Adjust as needed
insetAxes = axes('Position', insetPos);

% Plot the histogram in the inset axes
h = histogram(insetAxes, dif_FLDS(:),100);
set(insetAxes, 'YTickLabel',[]);
set(insetAxes, 'YColor', 'none'); % Hide y-axis line and ticks
set(insetAxes, 'YTick', []); % Optionally, remove y-tick marks
set(h, 'EdgeColor', [1, 0.5, 0.2]); % Optional: set edge color of bars
set(h,'FaceColor',[1, 0.5, 0.2]);
xlim(insetAxes, [-60, 60]);
box off


%% FIRA
s=subplot('position', [0.05 + (1-1)*0.32 0.04 0.31 0.42]);
hcb = colormap(s, colors);
title_text = '\Delta\it{LW}_{net}';

plot_spatial_map(lats, lons, dif_FIRA, min_clr, max_clr, title_text, 1, 1,'d');

% clr = colorbar;
% clr.Position = [0.93 0.1 0.02 0.78];
% %clr.AxisLocation = "in";
% clr.Title.String = "W/m^2";


insetPos = [0.08 + (1-1)*0.32 0.07 0.08 0.2]; % Adjust as needed
insetAxes = axes('Position', insetPos);


% Plot the histogram in the inset axes
h = histogram(insetAxes, dif_FIRA(:),100);
set(insetAxes, 'YTickLabel',[]);
set(insetAxes, 'YColor', 'none'); % Hide y-axis line and ticks
set(insetAxes, 'YTick', []); % Optionally, remove y-tick marks

set(h, 'EdgeColor', [1, 0.5, 0.2]); % Optional: set edge color of bars
set(h,'FaceColor',[1, 0.5, 0.2]);

xlim(insetAxes, [-60, 60]);
box off


%% Rnet
%% FIRA
s=subplot('position', [0.05 + (2-1)*0.32 0.04 0.31 0.42]);
hcb = colormap(s, colors);
title_text = '\Delta\it{R}_{net}';

plot_spatial_map(lats, lons, dif_Rnet, min_clr, max_clr, title_text, 1, 0,'e');

clr = colorbar;
clr.Position = [0.7 0.04 0.02 0.42];
%clr.AxisLocation = "in";
clr.Title.String = "W/m^2";


insetPos = [0.08 + (2-1)*0.32 0.07 0.08 0.2]; % Adjust as needed
insetAxes = axes('Position', insetPos);


% Plot the histogram in the inset axes
h = histogram(insetAxes, dif_Rnet(:),100);
set(insetAxes, 'YTickLabel',[]);
set(insetAxes, 'YColor', 'none'); % Hide y-axis line and ticks
set(insetAxes, 'YTick', []); % Optionally, remove y-tick marks

set(h, 'EdgeColor', [1, 0.5, 0.2]); % Optional: set edge color of bars
set(h,'FaceColor',[1, 0.5, 0.2]);

xlim(insetAxes, [-60, 60]);
box off
set(gcf, 'Color', 'w');
export_fig('../figure/Figure_3_radiation_spatial_modify_oldTOP.pdf', '-pdf', '-m2', '-painters','-nocrop');

close all

