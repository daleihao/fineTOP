function dif_variables = get_variable_albedo_top(variable_name_new)

dif_variables = nan(900*700,5);
for season_i = 1:5
    load('kTOP_factors.mat');

    variable_name = 'FSDS';
    load(['data/' variable_name '_seasonal_ELM_only_' num2str(season_i) '_with_top.mat']);
    FSDS_PPs = default_seasons;

    variable_name = 'FSA';
    load(['data/' variable_name '_seasonal_ELM_only_' num2str(season_i) '_with_top.mat']);
    FSA_PPs = default_seasons;

    variable_name = 'FSDSND';
    load(['data/' variable_name '_seasonal_ELM_only_' num2str(season_i) '_with_top.mat']);
    FSDSND_PPs = default_seasons;

    variable_name = 'FSDSVD';
    load(['data/' variable_name '_seasonal_ELM_only_' num2str(season_i) '_with_top.mat']);
    FSDSVD_PPs = default_seasons;

    FSDS_DIR_PPs = FSDSVD_PPs + FSDSND_PPs;

    variable_name = 'FSDSNI';
    load(['data/' variable_name '_seasonal_ELM_only_' num2str(season_i) '_with_top.mat']);
    FSDSNI_PPs = default_seasons;

    variable_name = 'FSDSVI';
    load(['data/' variable_name '_seasonal_ELM_only_' num2str(season_i) '_with_top.mat']);
    FSDSVI_PPs = default_seasons;

    FSDS_DIF_PPs = FSDSVI_PPs + FSDSNI_PPs;

    variable_name = 'FLDS';
    load(['data/' variable_name '_seasonal_ELM_only_' num2str(season_i) '_with_top.mat']);
    FLDS_PPs = default_seasons;


    %% TOP

    variable_name = 'FSDS';
    load(['data/' variable_name '_seasonal_ELM_only_' num2str(season_i) '_with_top.mat']);
    FSDS_kTOPs = kTOP_nolw_nosurf_seasons;

    variable_name = 'FSA';
    load(['data/' variable_name '_seasonal_ELM_only_' num2str(season_i) '_with_top.mat']);
    FSA_kTOPs = kTOP_nolw_nosurf_seasons;


    variable_name = 'FSDSND';
    load(['data/' variable_name '_seasonal_ELM_only_' num2str(season_i) '_with_top.mat']);
    FSDSND_kTOPs = kTOP_nolw_nosurf_seasons;

    variable_name = 'FSDSVD';
    load(['data/' variable_name '_seasonal_ELM_only_' num2str(season_i) '_with_top.mat']);
    FSDSVD_kTOPs = kTOP_nolw_nosurf_seasons;

    FSDS_DIR_kTOPs = FSDSVD_kTOPs + FSDSND_kTOPs;

    variable_name = 'FSDSNI';
    load(['data/' variable_name '_seasonal_ELM_only_' num2str(season_i) '_with_top.mat']);
    FSDSNI_kTOPs = kTOP_nolw_nosurf_seasons;

    variable_name = 'FSDSVI';
    load(['data/' variable_name '_seasonal_ELM_only_' num2str(season_i) '_with_top.mat']);
    FSDSVI_kTOPs = kTOP_nolw_nosurf_seasons;

    FSDS_DIF_kTOPs = FSDSVI_kTOPs + FSDSNI_kTOPs;

    variable_name = 'F_SHORT_REFL';
    load(['data/' variable_name '_seasonal_ELM_only_' num2str(season_i) '_with_top.mat']);
    FSDS_ADJ_kTOPs = kTOP_nolw_nosurf_seasons;

    FSDS_DIF_kTOPs = FSDS_DIF_kTOPs - FSDS_ADJ_kTOPs;

    variable_name = 'FLDS';
    load(['data/' variable_name '_seasonal_ELM_only_' num2str(season_i) '_with_top.mat']);
    FLDS_kTOPs = kTOP_nolw_nosurf_seasons;

    variable_name = 'F_LONG_REFL';
    load(['data/' variable_name '_seasonal_ELM_only_' num2str(season_i) '_with_top.mat']);
    FLDS_ADJ_kTOPs = kTOP_nolw_nosurf_seasons;

    FLDS_SKY_kTOPs = FLDS_kTOPs - FLDS_ADJ_kTOPs;

    ALBEDO_kTOPs = 1-FSA_kTOPs./FSDS_kTOPs;
    ALBEDO_PPs = 1-FSA_PPs./FSDS_PPs;


    if(strcmp(variable_name_new, 'SW_DIR'))

        dif_variable = FSDS_DIR_kTOPs - FSDS_DIR_PPs;
    elseif(strcmp(variable_name_new, 'SW_DIF'))
        dif_variable = FSDS_DIF_kTOPs - FSDS_DIF_PPs;

    elseif(strcmp(variable_name_new, 'SW_ADJ'))
        dif_variable = FSDS_ADJ_kTOPs;

    elseif(strcmp(variable_name_new, 'LW_SKY'))
        dif_variable = FLDS_SKY_kTOPs - FLDS_PPs;

    elseif(strcmp(variable_name_new, 'LW_ADJ'))
        dif_variable = FLDS_ADJ_kTOPs;

    elseif(strcmp(variable_name_new, 'ALBEDO'))
        dif_variable = ALBEDO_kTOPs - ALBEDO_PPs;

    end

    %dif_variable(slope<3) = nan;
    dif_variables(:,season_i) = dif_variable(:);
end
