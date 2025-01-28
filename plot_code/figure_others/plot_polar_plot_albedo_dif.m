function plot_polar_plot_albedo_dif(season_i, variable_name_new, maxvalue, title_text)

load('kTOP_factors.mat');

%season_i = 5;
if(strcmp(variable_name_new, 'Rnet'))

    variable_name = 'FSA';
    load(['data/' variable_name '_seasonal_ELM_only_' num2str(season_i) '.mat']);

    % Reshape the differences to have seasons in columns
    dif_variable1 = kTOP_surf_seasons - kTOP_nosurf_seasons;

    variable_name = 'FIRA';
    load(['data/' variable_name '_seasonal_ELM_only_' num2str(season_i) '.mat']);

    % Reshape the differences to have seasons in columns
    dif_variable2 = kTOP_surf_seasons - kTOP_nosurf_seasons;

    dif_variable_albedo = dif_variable1 - dif_variable2;

elseif(strcmp(variable_name_new, 'Rnet_ratio'))

    variable_name = 'FSA';
    load(['data/' variable_name '_seasonal_ELM_only_' num2str(season_i) '.mat']);

    % Reshape the differences to have seasons in columns
    dif_variable1 = kTOP_surf_seasons - kTOP_nosurf_seasons;

    variable_name = 'FIRA';
    load(['data/' variable_name '_seasonal_ELM_only_' num2str(season_i) '.mat']);

    % Reshape the differences to have seasons in columns
    dif_variable2 = kTOP_surf_seasons - kTOP_nosurf_seasons;

    dif_variable_albedo = dif_variable1 - dif_variable2;

    variable_name = 'FSA';
    load(['data/' variable_name '_seasonal_ELM_only_' num2str(season_i) '.mat']);

    % Reshape the differences to have seasons in columns
    dif_variable1 = kTOP_surf_seasons - default_seasons;

    variable_name = 'FIRA';
    load(['data/' variable_name '_seasonal_ELM_only_' num2str(season_i) '.mat']);

    % Reshape the differences to have seasons in columns
    dif_variable2 = kTOP_surf_seasons - default_seasons;

    dif_variable_all = dif_variable1 - dif_variable2;
else

    variable_name_new2 = strrep(variable_name_new, '_ratio', '');

    load(['data/' variable_name_new2 '_seasonal_ELM_only_' num2str(season_i) '.mat']);

    if (strcmp(variable_name_new2, 't_rad_grc'))
        kTOP_surf_seasons = kTOP_surf_seasons .* sqrt(sqrt(cos(slope*pi/180)));
        kTOP_nosurf_seasons = kTOP_nosurf_seasons .* sqrt(sqrt(cos(slope*pi/180)));
    end

    % Reshape the differences to have seasons in columns
    dif_variable_albedo = kTOP_surf_seasons - kTOP_nosurf_seasons; %kTOP_surf_seasons - ;
    dif_variable_all = kTOP_surf_seasons - default_seasons;

    if (strcmp(variable_name_new2, 'FIRA'))
        dif_variable_albedo = -dif_variable_albedo;
        dif_variable_all = -dif_variable_all;
    end

    if (strcmp(variable_name_new2, 'QRUNOFF'))
        dif_variable_albedo = dif_variable_albedo * 3600 * 24;
        dif_variable_all = dif_variable_all * 3600 * 24;
    end

    if (strcmp(variable_name_new2, 'FSNO'))
        dif_variable_albedo(default_seasons<=0.01) = nan;
        dif_variable_all(default_seasons<=0.01) = nan;
    end

    if (strcmp(variable_name_new2, 'H2OSNO'))

        load(['data/' 'FSNO' '_seasonal_ELM_only_' num2str(season_i) '.mat']);
        FSNO_PPs = default_seasons;
        dif_variable_albedo(FSNO_PPs<=0.01) = nan;
        dif_variable_all(FSNO_PPs<=0.01) = nan;
    end

end

    Pdata_albedo = nan(8,17);
    Pdata_all = nan(8,17);
     Pdata = nan(8,17);

if contains(variable_name_new, '_ratio')


    for slope_i = 0:5:30
        row_i = round(slope_i/5)+2;
        for aspect_i = 0:22.5:(360-22.5)
            col_j = round(aspect_i/22.5)+1;
            filters = slope>=slope_i & slope< (slope_i+5) & aspect >= aspect_i & aspect< (aspect_i+22.5);

            tmp = dif_variable_albedo(filters);
            Pdata_albedo(row_i,col_j) = mean(tmp(:),'omitnan');

            tmp = dif_variable_all(filters);
            Pdata_all(row_i,col_j) = mean(tmp(:),'omitnan');
        end
    end

    Pdata = abs(Pdata_albedo./Pdata_all);
else
    for slope_i = 0:5:30
        row_i = round(slope_i/5)+2;
        for aspect_i = 0:22.5:(360-22.5)
            col_j = round(aspect_i/22.5)+1;
            filters = slope>=slope_i & slope< (slope_i+5) & aspect >= aspect_i & aspect< (aspect_i+22.5);

            tmp = dif_variable_albedo(filters);
            Pdata(row_i,col_j) = mean(tmp(:),'omitnan');

        end
    end

end

Pdata(:,end) = Pdata(:,1);
Pdata(1,:) = Pdata(2,:);

R = 0:5:35; % (distance in km)
Az = linspace(0,360,17); % in degrees

pos = [0:5:35]; % Distance of the different circles from the origin
ncolor = 21;
Rticks = {'0°','5°','10°','15°','20°','25°','30°','35°'};

%% ,'colBar',0

[~,c]= polarPcolor(R,Az,Pdata,'Nspokes',9,'circlesPos',pos,'ncolor',ncolor,'colormap','hot','Rticklabel',Rticks,'autoOrigin','off');
colors = flipud(brewermap(21,'RdBu'));
colormap(colors);
clim([-maxvalue maxvalue]);
%shading interp
titleObj = title(title_text); %% 'FSDS (W/m^2)'
titlePosition = titleObj.Position;
%titlePosition(1) = -0.7; % Adjust this value as needed
titleObj.Position = titlePosition;


set(gcf,'color','w')
set(gca,'fontsize',18)