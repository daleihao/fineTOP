clc;
clear all;
close all;

load("kTOP_factors.mat");
load("mask_SN.mat");

kTOP_surf_filename = '../long_term_run/ktop_SN_rad_surf_MODIS_run_multi_year_average.nc';
kTOP_nosurf_filename = '../long_term_run/ktop_SN_rad_nosurf_MODIS_run_multi_year_average.nc';

variable_names = {'F_LONG_DIF','F_LONG_REFL','F_SHORT_DIR','F_SHORT_DIF','F_SHORT_REFL','forc_solad_grc_pp','forc_solai_grc_pp',...
    'FSDSND','FSDSNI','FSDSVD','FSDSVI','FSDS','LWdown','LWdown_PP','SWdown','SWdown_PP'};
for variable_name_i = 1:length(variable_names)

    variable_name = variable_names{variable_name_i};

    kTOP_surf_variables = ncread(kTOP_surf_filename, variable_name);
    kTOP_nosurf_variables = ncread(kTOP_nosurf_filename, variable_name);


    for season_i = 1:5

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

        if (length(size(kTOP_surf_variables))<=3)
            kTOP_surf_seasons = mean(kTOP_surf_variables(:,:,season_filter),3,'omitnan');
            kTOP_nosurf_seasons = mean(kTOP_nosurf_variables(:,:,season_filter),3,'omitnan');
        else
            kTOP_surf_seasons = mean(kTOP_surf_variables(:,:,:,season_filter),4,'omitnan');
            kTOP_surf_seasons = sum(kTOP_surf_seasons,3,'omitnan');
            kTOP_nosurf_seasons = mean(kTOP_nosurf_variables(:,:,:,season_filter),4,'omitnan');
            kTOP_nosurf_seasons = sum(kTOP_nosurf_seasons,3,'omitnan');
        end

        kTOP_surf_seasons = flipud(kTOP_surf_seasons');
        kTOP_nosurf_seasons = flipud(kTOP_nosurf_seasons');

        save(['data/' variable_name '_seasonal_ELM_kTOP_only_' num2str(season_i) '.mat'],'kTOP_surf_seasons','kTOP_nosurf_seasons');
    end

end