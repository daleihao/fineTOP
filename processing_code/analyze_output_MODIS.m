clc;
clear all;
close all;

load("kTOP_factors.mat");
load("mask_SN.mat");

kTOP_surf_filename = '../long_term_run/ktop_SN_rad_surf_MODIS_run_multi_year_average.nc';
kTOP_nosurf_filename = '../long_term_run/ktop_SN_rad_nosurf_MODIS_run_multi_year_average.nc';
default_filename = '../long_term_run/ktop_SN_default_MODIS_run_multi_year_average.nc';

variable_name = 'FSNO';
variable_name_MODIS = 'FSNO';

scale_factor = 0.01;

 %variable_name = 't_rad_grc_MODIS_daytime';
 %variable_name_MODIS = 'LST_day';
% 
% variable_name = 't_rad_grc_MODIS_nighttime';
% variable_name_MODIS = 'LST_night';
% 
% scale_factor = 0.02;

kTOP_surf_variables = ncread(kTOP_surf_filename, variable_name);
kTOP_nosurf_variables = ncread(kTOP_nosurf_filename, variable_name);
default_variables = ncread(default_filename, variable_name);

MODIS_folder = '../../MODIS_data/kTOP_MODIS_data/';

figure;
colormap jet

for season_i = 1

    switch season_i
        case 1
            season_filter = [12 1 2];
        case 2
            season_filter = [3 4 5];
        case 3
            season_filter = [6 7 8];
        case 4
            season_filter = [9 10 11];
    end

MODIS_data = [];
for season_filter_i = season_filter
MODIS_tmp = imread([ MODIS_folder '/' variable_name_MODIS '_1km_' num2str(season_filter_i) '.tif']);
MODIS_data = cat(3, MODIS_data, MODIS_tmp);
end

MODIS_data = mean(MODIS_data, 3, "omitnan") * scale_factor;
MODIS_data(~inSN) = nan;

kTOP_surf_seasons = mean(kTOP_surf_variables(:,:,season_filter),3,'omitnan');
kTOP_nosurf_seasons = mean(kTOP_nosurf_variables(:,:,season_filter),3,'omitnan');
default_seasons = mean(default_variables(:,:,season_filter),3,'omitnan');

kTOP_surf_seasons = flipud(kTOP_surf_seasons');
kTOP_nosurf_seasons = flipud(kTOP_nosurf_seasons');
default_seasons = flipud(default_seasons');

dif_seasons = kTOP_surf_seasons - default_seasons;
reldif_seasons = dif_seasons./default_seasons;
subplot(4,4,1+season_i-1)
imagesc(kTOP_surf_seasons,[0 1])
subplot(4,4,5+season_i-1)
imagesc(default_seasons,[0 1])
subplot(4,4,9+season_i-1)
imagesc(dif_seasons,[-0.2,0.2])
subplot(4,4,13+season_i-1)
imagesc(MODIS_data,[0 1])
end

%% figure

filters = default_seasons>0 & slope>5;
figure;
colormap("jet")
subplot(231)
scatter(slope(filters), aspect(filters),[],dif_seasons(filters))


subplot(232)
colormap("jet")
scatter(slope(filters), aspect(filters),[],kTOP_surf_seasons(filters))


subplot(233)
colormap("jet")
scatter(slope(filters), aspect(filters),[],kTOP_surf_seasons(filters))


subplot(234)
colormap("jet")
scatter(slope(filters), aspect(filters),[],default_seasons(filters))


subplot(235)
colormap("jet")
scatter(slope(filters), aspect(filters),[],MODIS_data(filters))

