function Bias_MAD = calculate_Bias_MAD_TOP(variable_name_new)

load('kTOP_factors.mat');
Bias = nan(1,5);
MAD = nan(1,5);
rBias = nan(1,5);
rMAD = nan(1,5);


for season_i = 1:5

    if(strcmp(variable_name_new,'Rnet'))

        variable_name = 'FSA';
        load(['data/' variable_name '_seasonal_ELM_only_' num2str(season_i) '_with_oldtop.mat']);

        % Reshape the differences to have seasons in columns
        dif_variable1 = oldTOP_seasons - default_seasons;
        default_season_1 = default_seasons;
        variable_name = 'FIRA';
        load(['data/' variable_name '_seasonal_ELM_only_' num2str(season_i) '_with_oldtop.mat']);

        % Reshape the differences to have seasons in columns
        dif_variable2 = oldTOP_seasons - default_seasons;
        default_season_2 = default_seasons;
        dif_variable = dif_variable1 - dif_variable2;
        default_season = default_season_1 - default_season_2;
    else
        load(['data/' variable_name_new '_seasonal_ELM_only_' num2str(season_i) '_with_oldtop.mat']);

        if(strcmp(variable_name_new,'t_rad_grc'))
            oldTOP_seasons = oldTOP_seasons .* sqrt(sqrt(cos(slope*pi/180)));
        end

        dif_variable = oldTOP_seasons - default_seasons;
        default_season = default_seasons;

        if (strcmp(variable_name_new, 'FSNO'))
            load(['data/' 'FSNO' '_seasonal_ELM_only_' num2str(5) '_with_oldtop.mat']);
            FSNO_PPs = default_seasons;
            dif_variable(FSNO_PPs<=0.05) = nan;
            default_season(FSNO_PPs<=0.05) = nan;
        end

        if (strcmp(variable_name_new, 'H2OSNO'))

            load(['data/' 'FSNO' '_seasonal_ELM_only_' num2str(5) '_with_oldtop.mat']);
            FSNO_PPs = default_seasons;
            dif_variable(FSNO_PPs<=0.05) = nan;
            default_season(FSNO_PPs<=0.05) = nan;
            
        end

    end
    % Reshape the differences to have seasons in columns
    Bias(season_i) = mean(dif_variable,'all','omitnan');
    MAD(season_i) = mean(abs(dif_variable),'all','omitnan');

    rBias(season_i) = mean(dif_variable,'all','omitnan')./mean(default_season,'all','omitnan')*100;
    rMAD(season_i) = mean(abs(dif_variable),'all','omitnan')./mean(default_season,'all','omitnan')*100;
end

Bias_MAD = [Bias MAD rBias rMAD];
end