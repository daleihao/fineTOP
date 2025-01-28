clc;
clear all;
close all;

res_v = 0.05;
res_h = 0.05;
lon = (-124+res_h/2):res_h: (-117-res_h/2);
lat = (43-res_v/2):-res_v: (34 + res_v/2);

[lons,lats]=meshgrid(lon,lat);



%% figure
figure;
set(gcf,'unit','normalized','position',[0.1,0.05,0.38,0.72]);
set(gca, 'Position', [0 0 1 1]);


colors = flipud(brewermap(17, 'RdBu'));

min_clr = -0.8;
max_clr = 0.8;

numbers = {'a','b','c','d','e','f','g','h','i'};

%% subplot
variable_names = {'FSNO','LST_day','LST_night'};
variable_names1 = {"\it{f}_{sno}",'Daytime \it{T}_{sur}',' Nighttime \it{T}_{sur}'};

for variable_i = 1:3

    variable_name_i = variable_names{variable_i};
    load(['R_' variable_name_i '_55_modify.mat']);


s=subplot('position', [0.11 + (1-1)*0.27 0.05+0.3*(3-variable_i) 0.26 0.28]);
hcb = colormap(s, colors);

if variable_i == 1
 title_text = {'R_{PP}'};
else 
    title_text = '';
end

if variable_i <3
plot_spatial_map(lats, lons, R2, min_clr, max_clr, title_text, 0, 1,numbers{1+(variable_i-1)*3});
else
plot_spatial_map(lats, lons, R2, min_clr, max_clr, title_text, 1, 1,numbers{1+(variable_i-1)*3});
end 

ylabel(variable_names1{variable_i});
%clc = colorbar;

s=subplot('position', [0.11 + (2-1)*0.27 0.05+0.3*(3-variable_i) 0.26 0.28]);
hcb = colormap(s, colors);
if variable_i == 1
 title_text = {'R_{fineTOP}'};

else 
    title_text = '';
end

if variable_i < 3
plot_spatial_map(lats, lons, R1, min_clr, max_clr, title_text, 0, 0,numbers{2+(variable_i-1)*3});
else
    plot_spatial_map(lats, lons, R1, min_clr, max_clr, title_text, 1, 0,numbers{2+(variable_i-1)*3});
end
%clc = colorbar;

s=subplot('position', [0.11 + (3-1)*0.27 0.05+0.3*(3-variable_i) 0.26 0.28]);
hcb = colormap(s, colors);

if variable_i == 1
 title_text = {'R_{MODIS}'};
else 
    title_text = '';
end

if variable_i < 3
plot_spatial_map(lats, lons, R3, min_clr, max_clr, title_text, 0, 0,numbers{3+(variable_i-1)*3});
else
plot_spatial_map(lats, lons, R3, min_clr, max_clr, title_text, 1, 0,numbers{3+(variable_i-1)*3});
end
clc = colorbar;
clc.Position(1) = clc.Position(1)+0.07;
end

set(gcf, 'Color', 'w');
export_fig('../../figure/Figure_Raspect_MODIS_spatial_55.pdf', '-pdf', '-m2', '-painters','-nocrop');

close all

