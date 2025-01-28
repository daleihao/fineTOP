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

elevations = Z/1000;
slopes = slope;
aspects = ones(size(aspect))*2;
horizon_angles = squeeze(H(:,:,1));
skyview_factors = vf;
terrain_factors = 1 - skyview_factors;
LAIs = (LAI_1_Data + LAI_2_Data + LAI_3_Data + ...
    LAI_4_Data + LAI_5_Data + LAI_6_Data + ...
    LAI_7_Data + LAI_8_Data + LAI_9_Data + ...
    LAI_10_Data + LAI_11_Data + LAI_12_Data)/12;
PFTs = ones(size(LC_ELM_Data))*0;
PFTs(LC_ELM_Data>=1 & LC_ELM_Data<=8) = 3;
PFTs(LC_ELM_Data>=9 & LC_ELM_Data<=11) = 2;
PFTs(LC_ELM_Data>=12 & LC_ELM_Data<=14) = 1;


aspects(aspect<=90 | aspect>=270) = 1;

PFTs(~inSN) = nan;
LAIs(~inSN) = nan;
elevations(~inSN) = nan;
slopes(~inSN) = nan;
aspects(~inSN) = nan;
horizon_angles(~inSN) = nan;
skyview_factors(~inSN) = nan;
terrain_factors(~inSN) = nan;


%% figure;
colors_LAI = (brewermap(17, 'YlGn'));
colors = (brewermap(17, 'YlGnBu'));
colors_sky = flipud(brewermap(17, 'YlGnBu'));

colors2 = flipud(brewermap(4, 'Accent'));
colors3 = (brewermap(2, 'Set2'));

figure;
set(gcf,'unit','normalized','position',[0.1,0.05,0.52,0.68]);
set(gca, 'Position', [0 0 1 1]);

colormap jet
s=subplot('position', [0.05 + (1-1)*0.235 0.52 0.23 0.45]);
hcb = colormap(s, colors2);
min_clr = 0;
max_clr = 3;
title_text = 'Land cover';

plot_spatial_map(lats, lons, PFTs, min_clr, max_clr, title_text, 0, 1,'a');

clr = colorbar;
clr.Position = [0.06 0.56 0.02 0.23];
clr.AxisLocation = "in";
clr.Ticks = [0+1/3 1+1/6 2-1/6 2+1/2];
clr.TickLabels = {'Others','Grass','Shrub','Forest'};
clr.Ruler.TickLabelRotation=-30;

s=subplot('position', [0.05 + (2-1)*0.235 0.52 0.23 0.45]);
colormap(s, colors_LAI);

min_clr = 0;
max_clr = 3;
title_text = 'LAI (m^{2}/m^{2})';

plot_spatial_map(lats, lons, LAIs, min_clr, max_clr, title_text, 0, 0,'b');

clr = colorbar;
clr.Position = [0.06+0.235 0.56 0.02 0.23];
clr.AxisLocation = "in";

s=subplot('position', [0.05 + (3-1)*0.235 0.52 0.23 0.45]);
colormap(s, colors);

min_clr = 0;
max_clr = 4;
title_text = 'Elevation (km)';

plot_spatial_map(lats, lons, elevations, min_clr, max_clr, title_text, 0, 0,'c');
clr = colorbar;
clr.Position = [0.06+2*0.235 0.56 0.02 0.23];
clr.AxisLocation = "in";

s=subplot('position', [0.05 + (4-1)*0.235 0.52 0.23 0.45]);
colormap(s, colors);

min_clr = 0;
max_clr = 30;
title_text = 'Slope (°)';

plot_spatial_map(lats, lons, slopes, min_clr, max_clr, title_text, 0, 0,'d');

clr = colorbar;
clr.Position = [0.06+3*0.235 0.56 0.02 0.23];
clr.AxisLocation = "in";

s=subplot('position', [0.05 + (1-1)*0.235 0.05 0.23 0.45]);
colormap(s, colors3);

min_clr = 1;
max_clr = 2;
title_text = 'Aspect';

plot_spatial_map(lats, lons, aspects, min_clr, max_clr, title_text, 1, 1,'e');
clr = colorbar;
clr.Position = [0.06 0.09 0.02 0.23];
clr.AxisLocation = "in";
clr.Ticks = [1+1/4 2-1/4];
clr.TickLabels = {'North','South'};

s=subplot('position', [0.05 + (2-1)*0.235 0.05 0.23 0.45]);
colormap(s, colors);

min_clr = 0;
max_clr = 20;
title_text = 'Horizon angle (°)';

plot_spatial_map(lats, lons, horizon_angles, min_clr, max_clr, title_text, 1, 0,'f');
clr = colorbar;
clr.Position = [0.06+1*0.235 0.09 0.02 0.23];
clr.AxisLocation = "in";

s=subplot('position', [0.05 + (3-1)*0.235 0.05 0.23 0.45]);
colormap(s, colors);

min_clr = 0.9;
max_clr = 1;
title_text = '\it{V}_{sky}';

plot_spatial_map(lats, lons, skyview_factors, min_clr, max_clr, title_text, 1, 0,'g');
clr = colorbar;
clr.Position = [0.06+2*0.235 0.09 0.02 0.23];
clr.AxisLocation = "in";

s=subplot('position', [0.05 + (4-1)*0.235 0.05 0.23 0.45]);
colormap(s, colors);

min_clr = 0;
max_clr = 0.1;
title_text = '\it{T}_{adj}';

plot_spatial_map(lats, lons, terrain_factors, min_clr, max_clr, title_text, 1, 0,'h');
clr = colorbar;
clr.Position = [0.06+3*0.235 0.09 0.02 0.23];
clr.AxisLocation = "in";

%set(gcf, 'PaperPositionMode', 'manual'); % or 'manual'
%exportgraphics(gcf,'../figure/Figure_2_study_area.tif','Resolution',300);
%print(gcf, '-dtiff', '-r300', '../figure/Figure_2_study_area.tif')
%exportgraphics(gcf,'../figure/Figure_2_study_area.pdf','ContentType','vector','Resolution',300);
%export_fig('../figure/Figure_2_study_area.pdf', '-pdf', '-transparent', '-m2', '-painters');
set(gcf, 'Color', 'w');
export_fig('../figure/Figure_2_study_area_modify.pdf', '-pdf', '-m2', '-painters','-nocrop');

close all



