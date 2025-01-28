clc;
clear all;
close all;

load("kTOP_factors.mat");
load("mask_SN.mat");

kTOP_surf_filename = '../long_term_run/ktop_SN_rad_surf_MODIS_run_multi_year_average.nc';
kTOP_nosurf_filename = '../long_term_run/ktop_SN_rad_nosurf_MODIS_run_multi_year_average.nc';
default_filename = '../long_term_run/ktop_SN_default_MODIS_run_multi_year_average.nc';

variable_name = 'FSDS';

kTOP_surf_variables = ncread(kTOP_surf_filename, variable_name);
kTOP_nosurf_variables = ncread(kTOP_nosurf_filename, variable_name);
default_variables = ncread(default_filename, variable_name);


figure;
colormap jet

for season_i = 1:4

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


kTOP_surf_seasons = mean(kTOP_surf_variables(:,:,season_filter),3,'omitnan');
kTOP_nosurf_seasons = mean(kTOP_nosurf_variables(:,:,season_filter),3,'omitnan');
default_seasons = mean(default_variables(:,:,season_filter),3,'omitnan');

kTOP_surf_seasons = flipud(kTOP_surf_seasons');
kTOP_nosurf_seasons = flipud(kTOP_nosurf_seasons');
default_seasons = flipud(default_seasons');

dif_seasons = kTOP_surf_seasons - default_seasons;
reldif_seasons = dif_seasons./default_seasons;
subplot(4,4,1+season_i-1)
imagesc(kTOP_surf_seasons,[0 5])
subplot(4,4,5+season_i-1)
imagesc(default_seasons,[0 5])
subplot(4,4,9+season_i-1)
imagesc(dif_seasons,[-0.2,0.2])
subplot(4,4,13+season_i-1)
imagesc(reldif_seasons,[-0.2 0.2])
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



