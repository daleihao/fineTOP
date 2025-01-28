clc;
clear all;
close all;


figure;
set(gcf,'unit','normalized','position',[0.1,0.05,0.6,0.6]);
set(gca, 'Position', [0 0 1 1]);

s=subplot('position', [0.05 + (1-1)*0.31 0.52 0.3 0.4]);
plot_polar_plot(5,'FSDS',60,'(a) \it{SW}_{down}')

s=subplot('position', [0.05 + (2-1)*0.31 0.52 0.3 0.4]);
plot_polar_plot(5,'FSA',60,'(b) \it{SW}_{net}')

s=subplot('position', [0.05 + (3-1)*0.31 0.52 0.3 0.4]);
plot_polar_plot(5,'FLDS',60,'(c) \it{LW}_{down}')

s=subplot('position', [0.05 + (1-1)*0.31 0.05 0.3 0.4]);
plot_polar_plot(5,'FIRA',60,'(d) \it{LW}_{net}')

s=subplot('position', [0.05 + (2-1)*0.31 0.05 0.3 0.4]);
plot_polar_plot(5,'Rnet',60,'(e) \it{R}_{net}')

clr = colorbar;
clr.Position = [0.07 + (3-1)*0.31 0.05 0.02 0.4];
%clr.AxisLocation = "in";
clr.Title.String = "W/m^2";


set(gcf, 'Color', 'w');
export_fig('../figure/Figure_components_radiation_aspect.pdf', '-pdf', '-m2', '-painters','-nocrop');

close all

