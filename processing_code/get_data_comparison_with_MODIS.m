clc;
clear all;
close all;

load("kTOP_factors.mat");
load("mask_SN.mat");

kTOP_surf_filename = '../long_term_run/ktop_SN_rad_surf_MODIS_run_multi_year_average.nc';
kTOP_nosurf_filename = '../long_term_run/ktop_SN_rad_nosurf_MODIS_run_multi_year_average.nc';
default_filename = '../long_term_run/ktop_SN_default_MODIS_run_multi_year_average.nc';

variable_names = {'FSNO','LST_day','LST_night'};
for variable_name_i = 2

    variable_name_MODIS = variable_names{variable_name_i};
    switch variable_name_MODIS
        case 'FSNO'
            variable_name = 'FSNO';
            scale_factor = 0.01;
        case 'LST_day'
            variable_name = 't_rad_grc_MODIS_daytime';
            scale_factor = 0.02;
        case 'LST_night'
            variable_name = 't_rad_grc_MODIS_nighttime';
            scale_factor = 0.02;
    end

    kTOP_surf_variables = ncread(kTOP_surf_filename, variable_name);
    kTOP_nosurf_variables = ncread(kTOP_nosurf_filename, variable_name);
    default_variables = ncread(default_filename, variable_name);

    
    MODIS_folder = '../../MODIS_data/kTOP_MODIS_data/';

    for season_i = 5

        switch season_i
            case 1
                season_filter = [12 1 2];
            case 2
                season_filter = [3 4 5];
            case 3
                season_filter = [6 7 8];
            case 4
                season_filter = [9 10 11];
            case 5
                season_filter = [1:12];
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

        if (~strcmp(variable_name_MODIS, 'FSNO'))
           kTOP_surf_seasons = kTOP_surf_seasons .* sqrt(sqrt(cos(slope*pi/180)));
           kTOP_nosurf_seasons = kTOP_nosurf_seasons .* sqrt(sqrt(cos(slope*pi/180)));
        end
        save(['data/' variable_name_MODIS '_seasonal_ELM_MODIS_' num2str(season_i) '_modify.mat'],'kTOP_surf_seasons','kTOP_nosurf_seasons','default_seasons','MODIS_data');
    end

end