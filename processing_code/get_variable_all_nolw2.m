function [dif_variables] = get_variable_all_nolw2(variable_name_new)

load('kTOP_factors.mat');

dif_variables = nan(900*700,5);
default_snow = [];
for season_i = [5 1:4]

    if(strcmp(variable_name_new, 'LST_day'))
        load(['data/' variable_name_new '_seasonal_ELM_MODIS_' num2str(season_i) '_with_top.mat']);
        dif_variable = kTOP_nolw_nosurf_seasons - default_seasons;
    elseif(strcmp(variable_name_new, 'LST_night'))
        load(['data/' variable_name_new '_seasonal_ELM_MODIS_' num2str(season_i) '_with_top.mat']);
        dif_variable = kTOP_nolw_nosurf_seasons - default_seasons;
    elseif(strcmp(variable_name_new, 'Rnet'))

        variable_name = 'FSA';
        load(['data/' variable_name '_seasonal_ELM_only_' num2str(season_i) '_with_top.mat']);

        % Reshape the differences to have seasons in columns
        dif_variable1 = kTOP_nolw_nosurf_seasons - default_seasons;

        variable_name = 'FIRA';
        load(['data/' variable_name '_seasonal_ELM_only_' num2str(season_i) '_with_top.mat']);

        % Reshape the differences to have seasons in columns
        dif_variable2 = kTOP_nolw_nosurf_seasons - default_seasons;

        dif_variable = dif_variable1 - dif_variable2;

    else
        load(['data/' variable_name_new '_seasonal_ELM_only_' num2str(season_i) '_with_oldtop.mat']);

        kTOP_nolw_nosurf_seasons = kTOP_nolw_seasons ; %.* sqrt(sqrt(cos(slope*pi/180)));
            default_seasons = kTOP_nosurf_seasons;

        if (strcmp(variable_name_new, 't_rad_grc'))
            kTOP_nolw_nosurf_seasons = kTOP_nolw_seasons; %.* sqrt(sqrt(cos(slope*pi/180)));
            default_seasons = kTOP_nosurf_seasons.* sqrt(sqrt(cos(slope*pi/180)));
        end

        % Reshape the differences to have seasons in columns
        dif_variable =  default_seasons - kTOP_nolw_nosurf_seasons;

        if (strcmp(variable_name_new, 'FIRA'))
            dif_variable = -dif_variable;
        end

        if (strcmp(variable_name_new, 'QRUNOFF'))
            dif_variable = dif_variable * 3600 * 24;
        end

        if (strcmp(variable_name_new, 'FSNO'))
            if season_i == 5
            default_snow = default_seasons;
            end
            dif_variable(default_snow<=0.05) = nan;
        end

        if (strcmp(variable_name_new, 'H2OSNO'))

%             load(['data/' 'FSNO' '_seasonal_ELM_only_' num2str(season_i) '.mat']);
%             FSNO_PPs = default_seasons;
            dif_variable(default_snow<=0.05) = nan;
        end

    end
    dif_variables(:,season_i) = dif_variable(:);
end
