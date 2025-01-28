clc;
clear all;
close all;


figure;
set(gcf,'unit','normalized','position',[0.1,0.05,0.6,0.6]);
set(gca, 'Position', [0 0 1 1]);

s=subplot('position', [0.05 + (1-1)*0.31 0.52 0.28 0.4]);
plot_polar_plot_albedo(5,'SW_DIR',30,'(a) \it{F}_{sen}')

clr = colorbar;
clr.Title.String = "W/m^2";


s=subplot('position', [0.05 + (2-1)*0.31 0.52 0.28 0.4]);
plot_polar_plot_albedo(5,'SW_DIF',30,'(b) \it{F}_{lat}')

clr = colorbar;
clr.Title.String = "W/m^2";


s=subplot('position', [0.05 + (3-1)*0.31 0.52 0.28 0.4]);
plot_polar_plot_albedo(5,'SW_ADJ',30,'(c) \it{T}_{veg}')

clr = colorbar;
clr.Title.String = "K";

% s=subplot('position', [0.05 + (3-1)*0.31 0.52 0.28 0.4]);
% plot_polar_plot_all(5,'H2OSOI',0.01,'(c) \it{T}_{veg}')
% 
% clr = colorbar;
% clr.Title.String = "K";

s=subplot('position', [0.05 + (1-1)*0.31 0.05 0.28 0.4]);
plot_polar_plot_albedo(5,'LW_SKY',30,'(d) \it{T}_{sur}')
clr = colorbar;
clr.Title.String = "K";

s=subplot('position', [0.05 + (2-1)*0.31 0.05 0.28 0.4]);
plot_polar_plot_albedo(5,'LW_ADJ',30,'(e) \it{f}_{sno} ')

clr = colorbar;
clr.Title.String = "Unitless";


s=subplot('position', [0.05 + (3-1)*0.31 0.05 0.28 0.4]);
plot_polar_plot_albedo(5,'ALBEDO',0.01,'(f) SWE')

clr = colorbar;
%clr.Position = [0.07 + (3-1)*0.31 0.05 0.02 0.4];
%clr.AxisLocation = "in";
clr.Title.String = "mm";


set(gcf, 'Color', 'w');
export_fig('../figure/Figure_radiation_albedo_aspect.pdf', '-pdf', '-m2', '-painters','-nocrop');

close all

