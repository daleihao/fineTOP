clc;
clear all;
close all;

numRows = 900;
numCols = 700;

load('../kTOP_factors.mat');
aspects_all = aspect(:);
slope_all = slope(:);
% for i = 1:8
% 
%     if i==1
%         aspects_all(aspect>=337.5 | aspect<22.5) = i;
%     else
% 
%         lower_limit = 22.5 + (i-2)*45;
%         upper_limit = lower_limit + 45;
%         aspects_all(aspect>=lower_limit & aspect<upper_limit) = i;
%     end
% end

aspects_all(:) = 0;
aspects_all(aspect>90 & aspect<270) = 1;

MODIS_data_all = nan(3,5,numCols*numRows);

kTOP_surf_seasons_all = nan(3,5,numCols*numRows);
kTOP_nosurf_seasons_all  = nan(3,5,numCols*numRows);
default_seasons_all  = nan(3,5,numCols*numRows);


variable_names = {'FSNO','LST_day','LST_night'};
for variable_name_i = 1:3
    variable_name = variable_names{variable_name_i};
    for season_i = 1:5

        load([ '../data/' variable_name '_seasonal_ELM_MODIS_' num2str(season_i) '_modify.mat']);

        MODIS_data_all(variable_name_i,season_i,:) = MODIS_data(:);
        kTOP_surf_seasons_all(variable_name_i,season_i,:) = kTOP_surf_seasons(:);
        kTOP_nosurf_seasons_all(variable_name_i,season_i,:) = kTOP_nosurf_seasons(:);
        default_seasons_all(variable_name_i,season_i,:) = default_seasons(:);
    end
end

save(['ELM_MODIS_all_modify_NS.mat'],'MODIS_data_all','kTOP_surf_seasons_all','kTOP_nosurf_seasons_all',"default_seasons_all","aspects_all","slope_all");