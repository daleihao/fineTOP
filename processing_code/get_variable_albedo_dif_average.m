function [dif_variables] = get_variable_albedo_dif_average(variable_name_new)

load('kTOP_factors.mat');

dif_variables = nan(5,2);
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
   
    dif_variables(season_i,1) = mean(dif_variable_surf(:),'omitnan');
    dif_variables(season_i,2) = mean(dif_variable_all(:),'omitnan');
end

end