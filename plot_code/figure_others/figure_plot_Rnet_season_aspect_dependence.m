clc;
clear all;
close all;


figure;
set(gcf,'unit','normalized','position',[0.1,0.05,0.6,0.6]);
set(gca, 'Position', [0 0 1 1]);

s=subplot('position', [0.05 + (1-1)*0.31 0.52 0.3 0.4]);
plot_polar_plot(1,'Rnet',60,'(a) Winter')

s=subplot('position', [0.05 + (2-1)*0.31 0.52 0.3 0.4]);
plot_polar_plot(2,'Rnet',60,'(b) Spring')

s=subplot('position', [0.05 + (3-1)*0.31 0.52 0.3 0.4]);
plot_polar_plot(3,'Rnet',60,'(c) Summer')

s=subplot('position', [0.05 + (1-1)*0.31 0.05 0.3 0.4]);
plot_polar_plot(4,'Rnet',60,'(d) Autumn')

s=subplot('position', [0.05 + (2-1)*0.31 0.05 0.3 0.4]);
plot_polar_plot(5,'Rnet',60,'(e) Annual')

clr = colorbar;
clr.Position = [0.07 + (3-1)*0.31 0.05 0.02 0.4];
%clr.AxisLocation = "in";
clr.Title.String = "W/m^2";


set(gcf, 'Color', 'w');
export_fig('../figure/Figure_6_radiation_aspect_seasonal.pdf', '-pdf', '-m2', '-painters','-nocrop');

close all

