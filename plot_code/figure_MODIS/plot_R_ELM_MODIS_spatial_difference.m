clc;
clear all;
close all;

res_v = 0.1;
res_h = 0.1;
lon = (-124+res_h/2):res_h: (-117-res_h/2);
lat = (43-res_v/2):-res_v: (34 + res_v/2);

[lons,lats]=meshgrid(lon,lat);

min_clr = -0.2;
max_clr = 0.2;

colors = flipud(brewermap(17, 'RdBu'));

variable_names1 = {'FSNO','LST_day','LST_night'};

for window_i = [10]
    load(['R_all' num2str(window_i) '_modify_top.mat']);

    filters = slopes >=0;
    filters2 = [filters(:); filters(:)];
    filters = [filters(:); filters(:); filters(:)];


    %% boxplot
    figure;
    set(gcf, 'Position', [100, 100, 900, 800]);

    positions = [
        0.08, 0.70, 0.27, 0.275;  % Top subplot
        0.08, 0.39, 0.27, 0.275;  % Middle subplot
        0.08, 0.08, 0.27, 0.275   % Bottom subplot
        ];

    positions2 = [
        0.41, 0.70, 0.57, 0.275;  % Top subplot
        0.41, 0.39, 0.57, 0.275;  % Middle subplot
        0.41, 0.08, 0.57, 0.275   % Bottom subplot
        ];

    labels = {'a','c','e','b','d','f'};

    ylims = [-1.1, 1.1; -1.1 1.1; -1.1 1.1];
    violin_colors = [0.6350 0.7608 0.8784; 0.9765 0.7725 0.6941; 0.8353 0.6471 0.8510]; % Light blue, light orange, light purple

    variable_names = {"\DeltaR for \it{f}_{sno}",'\DeltaR for Daytime \it{T}_{sur}','\DeltaR for Nighttime \it{T}_{sur}'};
    for variable_i = 1:3

        load(['R_' variable_names1{variable_i} '_105_modify_top.mat']);

        s = subplot('Position', positions(variable_i,:))
        hcb = colormap(s, colors);

        hold on

        % First subplot
        switch variable_i
            case 1
        plot_spatial_map(lats, lons, R4 - R5, min_clr, max_clr, "", 0, 1,labels{variable_i});

         case 2
        plot_spatial_map(lats, lons, R4 - R5, min_clr, max_clr, "", 0, 1,labels{variable_i});

         case 3
        plot_spatial_map(lats, lons, R4 - R5, min_clr, max_clr, "", 1, 1,labels{variable_i});

        end
        colorbar

        ylabel(variable_names{variable_i});

    end

    % Overall figure adjustments
    set(gcf, 'Color', 'w')


    %% right
    positions = positions2;

    ylims = [-0.31, 0.31; -0.61 0.61; -0.21 0.21];

    violin_colors = [0.6350 0.7608 0.8784; 0.9765 0.7725 0.6941]; % Light blue, light orange, light purple
    violin_colors = [0.6350 0.7608 0.8784; 0.9765 0.7725 0.6941; 0.8353 0.6471 0.8510]; % Light blue, light orange, light purple


    %variable_names = {"Snow cover fraction",'Daytime surface temperature','Nighttime surface temperature'};
    for variable_i = 1:3
        subplot('Position', positions(variable_i,:))
        hold on
        data = squeeze(R_MODISs(variable_i,:,:));
        data(:,~filters2) = nan;
        data = data';
        group_inx = [ones(1,size(data,1)/2), 2.*ones(1,size(data,1)/2)];
        data(group_inx == 1,:) = data(group_inx == 2,:) - data(group_inx == 1,:);
        data  = data(group_inx == 1,:);
        mean(data,'omitnan')

        group_names = {'PP','fine-TOP'};
        condition_names = {'Winter','Spring','Summer','Autumn','Annual'};

        line([0 6], [0 0], 'Color', 'k', 'LineWidth', 1, 'LineStyle', '--');

        h = daboxplot(data,'outsymbol','kx',...
            'xtlabels', condition_names,'fill',1,'mean',1,'outliers',0);

        %         h = daviolinplot(data,'groups',group_inx,...
        %             'xtlabels', condition_names,'violin','full',...
        %             'boxcolors','w','smoothing',0.01,'boxwidth',1.1,'boxspacing',1, ...
        %             'colors',violin_colors);
        %ylabel('\DeltaR');

        %         if variable_i == 1
        %             legend([h.ds(1,:)],group_names, 'Orientation', 'horizontal', 'Location', 'south', 'Box', 'off');    % add the legend manually
        %         end
        if variable_i <3
            set(gca,'XTickLabel',[])
        end
        set(gca,'FontSize',10);



        set(gca, 'FontSize', 20,'linewidth',1)
        grid off
        ylim(ylims(variable_i,:))

        xlim([0.5 5.5])
        box on

        if variable_i == 4
            title({'Difference in correlation to', 'MODIS (\DeltaR)'}, 'FontSize', 20, 'HorizontalAlignment', 'center');
        end

        text(0.6,ylims(variable_i,1)*0.85,['(' labels{variable_i+3} ')'],'fontsize',20,'FontWeight','bold');
    end


    % Overall figure adjustments
    set(gcf, 'Color', 'w')


    export_fig(['../../figure/Figure_ELM_MODIS_R_difference_' num2str(window_i) '_modify.pdf'], '-pdf', '-m2', '-painters');
    close all
end
