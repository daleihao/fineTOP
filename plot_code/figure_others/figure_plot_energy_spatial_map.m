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

variable_name = 'FSH';
load(['data/' variable_name '_seasonal_ELM_only_' num2str(season_i) '.mat']);
FSH_kTOPs = kTOP_surf_seasons;
FSH_PPs = default_seasons;

dif_FSH = FSH_kTOPs - FSH_PPs;

variable_name = 'EFLX_LH_TOT';
load(['data/' variable_name '_seasonal_ELM_only_' num2str(season_i) '.mat']);
EFLX_LH_TOT_kTOPs = kTOP_surf_seasons;
EFLX_LH_TOT_PPs = default_seasons;

dif_EFLX_LH_TOT = EFLX_LH_TOT_kTOPs - EFLX_LH_TOT_PPs;




variable_name = 'TV';
load(['data/' variable_name '_seasonal_ELM_only_' num2str(season_i) '.mat']);
TV_kTOPs = kTOP_surf_seasons;
TV_PPs = default_seasons;

dif_TV = TV_kTOPs - TV_PPs;

% variable_name = 'H2OSOI';
% load(['data/' variable_name '_seasonal_ELM_only_' num2str(season_i) '.mat']);
% TV_kTOPs = kTOP_surf_seasons;
% TV_PPs = default_seasons;
% 
% dif_TV = TV_kTOPs - TV_PPs;

variable_name = 't_rad_grc';
load(['data/' variable_name '_seasonal_ELM_only_' num2str(season_i) '.mat']);

kTOP_surf_seasons = kTOP_surf_seasons .* sqrt(sqrt(cos(slope*pi/180)));


TS_kTOPs = kTOP_surf_seasons;
TS_PPs = default_seasons;

dif_TS = TS_kTOPs - TS_PPs;



variable_name = 'FSNO';
load(['data/' variable_name '_seasonal_ELM_only_' num2str(season_i) '.mat']);
FSNO_kTOPs = kTOP_surf_seasons;
FSNO_PPs = default_seasons;

dif_FSNO = FSNO_kTOPs - FSNO_PPs;

dif_FSNO(FSNO_PPs<=0.05) = nan;

variable_name = 'H2OSNO';
load(['data/' variable_name '_seasonal_ELM_only_' num2str(season_i) '.mat']);
H2OSNO_kTOPs = kTOP_surf_seasons;
H2OSNO_PPs = default_seasons;

dif_H2OSNO = H2OSNO_kTOPs - H2OSNO_PPs;
dif_H2OSNO(FSNO_PPs<=0.01) = nan;

colors = flipud(brewermap(17, 'RdBu'));
min_clr = -30;
max_clr = 30;

%% figure
figure;
set(gcf,'unit','normalized','position',[0.1,0.05,0.54,0.68]);
set(gca, 'Position', [0 0 1 1]);


%% subplot
s=subplot('position', [0.06 + (3-1)*0.31 0.52 0.28 0.42]);
hcb = colormap(s, colors);
title_text = '\Delta\it{F}_{sen}';

min_clr = -30;
max_clr = 30;

plot_spatial_map(lats, lons, dif_FSH, min_clr, max_clr, title_text, 0, 0,'c');
clc = colorbar;
clc.Title.String = "W/m^2";
set(gca,'XTickLabel',[])
insetPos = [0.08 + (3-1)*0.31 0.55 0.1 0.13]; % Adjust as needed
insetAxes = axes('Position', insetPos);

% Plot the histogram in the inset axes
h = histogram(insetAxes, dif_FSH(:),100);
set(insetAxes, 'YTickLabel',[]);
set(insetAxes, 'YColor', 'none'); % Hide y-axis line and ticks
set(insetAxes, 'YTick', []); % Optionally, remove y-tick marks
%
set(h, 'EdgeColor', [1, 0.5, 0.2]); % Optional: set edge color of bars
set(h,'FaceColor',[1, 0.5, 0.2]);

xlim(insetAxes, [-30, 30]);
box off

%% FSA
s=subplot('position', [0.06 + (1-1)*0.31 0.03 0.28 0.42]);
hcb = colormap(s, colors);
title_text = '\Delta\it{F}_{lat}';

min_clr = -10;
max_clr = 10;

plot_spatial_map(lats, lons, dif_EFLX_LH_TOT, min_clr, max_clr, title_text, 1, 1,'d');
clc = colorbar;
clc.Title.String = "W/m^2";

insetPos = [0.08 + (1-1)*0.31 0.06 0.1 0.13]; % Adjust as needed
insetAxes = axes('Position', insetPos);

% Plot the histogram in the inset axes
h = histogram(insetAxes, dif_EFLX_LH_TOT(:),100);
set(insetAxes, 'YTickLabel',[]);
set(insetAxes, 'YColor', 'none'); % Hide y-axis line and ticks
set(insetAxes, 'YTick', []); % Optionally, remove y-tick marks

set(h, 'EdgeColor', [1, 0.5, 0.2]); % Optional: set edge color of bars
set(h,'FaceColor',[1, 0.5, 0.2]);

xlim(insetAxes, [-10, 10]);
box off


%% FLDS
s=subplot('position', [0.06 + (1-1)*0.31 0.52 0.28 0.42]);
hcb = colormap(s, colors);
title_text = '\Delta\it{T}_{veg}';

min_clr = -1;
max_clr = 1;

plot_spatial_map(lats, lons, dif_TV, min_clr, max_clr, title_text, 0, 1,'a');

clc = colorbar;
clc.Title.String = "K";

insetPos = [0.08 + (1-1)*0.31 0.55 0.1 0.13]; % Adjust as needed
insetAxes = axes('Position', insetPos);

% Plot the histogram in the inset axes
h = histogram(insetAxes, dif_TV(:),100);
set(insetAxes, 'YTickLabel',[]);
set(insetAxes, 'YColor', 'none'); % Hide y-axis line and ticks
set(insetAxes, 'YTick', []); % Optionally, remove y-tick marks
set(h, 'EdgeColor', [1, 0.5, 0.2]); % Optional: set edge color of bars
set(h,'FaceColor',[1, 0.5, 0.2]);
xlim(insetAxes, [-1.5, 1.5]);
box off


%% subplot
s=subplot('position', [0.06 + (2-1)*0.31 0.52 0.28 0.42]);
hcb = colormap(s, colors);
title_text = '\Delta\it{T}_{sur}';

min_clr = -1;
max_clr = 1;

plot_spatial_map(lats, lons, dif_TS, min_clr, max_clr, title_text, 0, 0,'b');
clc = colorbar;
clc.Title.String = "K";

insetPos = [0.08 + (2-1)*0.31 0.55 0.1 0.13]; % Adjust as needed
insetAxes = axes('Position', insetPos);

% Plot the histogram in the inset axes
h = histogram(insetAxes, dif_TS(:),100);
set(insetAxes, 'YTickLabel',[]);
set(insetAxes, 'YColor', 'none'); % Hide y-axis line and ticks
set(insetAxes, 'YTick', []); % Optionally, remove y-tick marks
%
set(h, 'EdgeColor', [1, 0.5, 0.2]); % Optional: set edge color of bars
set(h,'FaceColor',[1, 0.5, 0.2]);

xlim(insetAxes, [-2, 2]);
box off

%% FSA
s=subplot('position', [0.06 + (2-1)*0.31 0.03 0.28 0.42]);
hcb = colormap(s, colors);
title_text = '\Delta\it{f}_{sno}';

min_clr = -0.1;
max_clr = 0.1;

plot_spatial_map(lats, lons, dif_FSNO, min_clr, max_clr, title_text, 1, 0,'e');
clc = colorbar;
clc.Title.String = "Unitless";

insetPos = [0.08 + (2-1)*0.31 0.06 0.1 0.13]; % Adjust as needed
insetAxes = axes('Position', insetPos);

% Plot the histogram in the inset axes
h = histogram(insetAxes, dif_FSNO(:),100);
set(insetAxes, 'YTickLabel',[]);
set(insetAxes, 'YColor', 'none'); % Hide y-axis line and ticks
set(insetAxes, 'YTick', []); % Optionally, remove y-tick marks

set(h, 'EdgeColor', [1, 0.5, 0.2]); % Optional: set edge color of bars
set(h,'FaceColor',[1, 0.5, 0.2]);

xlim(insetAxes, [-0.1 0.1]);
box off


%% FLDS
s=subplot('position', [0.06 + (3-1)*0.31 0.03 0.28 0.42]);
hcb = colormap(s, colors);
title_text = '\DeltaSWE';

min_clr = -30;
max_clr = 30;

plot_spatial_map(lats, lons, dif_H2OSNO, min_clr, max_clr, title_text, 1, 0,'f');

clc = colorbar;
clc.Title.String = "mm";


insetPos = [0.08 + (3-1)*0.31 0.06 0.1 0.13]; % Adjust as needed
insetAxes = axes('Position', insetPos);

% Plot the histogram in the inset axes
h = histogram(insetAxes, dif_H2OSNO(:),100);
set(insetAxes, 'YTickLabel',[]);
set(insetAxes, 'YColor', 'none'); % Hide y-axis line and ticks
set(insetAxes, 'YTick', []); % Optionally, remove y-tick marks
set(h, 'EdgeColor', [1, 0.5, 0.2]); % Optional: set edge color of bars
set(h,'FaceColor',[1, 0.5, 0.2]);
xlim(insetAxes, [-30, 30]);
box off

set(gcf, 'Color', 'w');
export_fig('../figure/Figure_energy_spatial_modify.pdf', '-pdf', '-m2', '-painters','-nocrop');

close all

