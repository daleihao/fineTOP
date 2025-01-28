function [dif_variables,dif_variables_relative] = get_variable_albedo_dif(variable_name_new)

load('kTOP_factors.mat');

dif_variables = nan(900*700,5);
dif_variables_relative = nan(900*700,5);
for season_i = 1:5
    if(strcmp(variable_name_new, 'Rnet'))

        variable_name = 'FSA';
        load(['data/' variable_name '_seasonal_ELM_only_' num2str(season_i) '.mat']);

        % Reshape the differences to have seasons in columns
        dif_variable1 = kTOP_surf_seasons - default_seasons;

        variable_name = 'FIRA';
        load(['data/' variable_name '_seasonal_ELM_only_' num2str(season_i) '.mat']);

        % Reshape the differences to have seasons in columns
        dif_variable2 = kTOP_surf_seasons - default_seasons;

        dif_variable_all = dif_variable1 - dif_variable2;

        variable_name = 'FSA';
        load(['data/' variable_name '_seasonal_ELM_only_' num2str(season_i) '.mat']);

        % Reshape the differences to have seasons in columns
        dif_variable1 = kTOP_surf_seasons - kTOP_nosurf_seasons;

        variable_name = 'FIRA';
        load(['data/' variable_name '_seasonal_ELM_only_' num2str(season_i) '.mat']);

        % Reshape the differences to have seasons in columns
        dif_variable2 = kTOP_surf_seasons - kTOP_nosurf_seasons;

        dif_variable_surf = dif_variable1 - dif_variable2;


    else
        load(['data/' variable_name_new '_seasonal_ELM_only_' num2str(season_i) '.mat']);

        if (strcmp(variable_name_new, 't_rad_grc'))
            kTOP_surf_seasons = kTOP_surf_seasons .* sqrt(sqrt(cos(slope*pi/180)));
            kTOP_nosurf_seasons = kTOP_nosurf_seasons .* sqrt(sqrt(cos(slope*pi/180)));
        end

        % Reshape the differences to have seasons in columns
        dif_variable_surf = kTOP_surf_seasons - kTOP_nosurf_seasons;
        dif_variable_all = kTOP_surf_seasons - default_seasons;

        if (strcmp(variable_name_new, 'FIRA'))
            dif_variable_surf = -dif_variable_surf;
            dif_variable_all = -dif_variable_all;
        end

    end
   
    dif_variables(:,season_i) = dif_variable_surf(:);
    dif_variables_relative(:,season_i) = (dif_variable_surf(:)./dif_variable_all(:));
end

dif_variables_relative(dif_variables_relative>1 | dif_variables_relative<-1) = nan;
dif_variables_relative = dif_variables_relative *100;
end