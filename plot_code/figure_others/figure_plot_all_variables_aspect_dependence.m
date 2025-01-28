clc;
clear all;
close all;


figure;
set(gcf,'unit','normalized','position',[0.1,0.05,0.6,0.6]);
set(gca, 'Position', [0 0 1 1]);

s=subplot('position', [0.05 + (3-1)*0.31 0.52 0.28 0.4]);
plot_polar_plot_all(5,'FSH',30,'(c) \Delta\it{F}_{sen}')

clr = colorbar;
clr.Title.String = "W/m^2";


s=subplot('position', [0.05 + (1-1)*0.31 0.03 0.28 0.4]);
plot_polar_plot_all(5,'EFLX_LH_TOT',30,'(d) \Delta\it{F}_{lat}')

clr = colorbar;
clr.Title.String = "W/m^2";


s=subplot('position', [0.05 + (1-1)*0.31 0.52 0.28 0.4]);
plot_polar_plot_all(5,'TV',3,'(a) \Delta\it{T}_{veg}')

clr = colorbar;
clr.Title.String = "K";

% s=subplot('position', [0.05 + (3-1)*0.31 0.52 0.28 0.4]);
% plot_polar_plot_all(5,'H2OSOI',0.01,'(c) \it{T}_{veg}')
% 
% clr = colorbar;
% clr.Title.String = "K";

s=subplot('position', [0.05 + (2-1)*0.31 0.52 0.28 0.4]);
plot_polar_plot_all(5,'t_rad_grc',3,'(b) \Delta\it{T}_{sur}')
clr = colorbar;
clr.Title.String = "K";

s=subplot('position', [0.05 + (2-1)*0.31 0.05 0.28 0.4]);
plot_polar_plot_all(5,'FSNO',0.151,'(e) \Delta\it{f}_{sno} ')

clr = colorbar;
clr.Title.String = "Unitless";


s=subplot('position', [0.05 + (3-1)*0.31 0.05 0.28 0.4]);
plot_polar_plot_all(5,'H2OSNO',60,'(f) \DeltaSWE')

clr = colorbar;
%clr.Position = [0.07 + (3-1)*0.31 0.05 0.02 0.4];
%clr.AxisLocation = "in";
clr.Title.String = "mm";


set(gcf, 'Color', 'w');
export_fig('../figure/Figure_energy_snow_aspect.pdf', '-pdf', '-m2', '-painters','-nocrop');

close all

