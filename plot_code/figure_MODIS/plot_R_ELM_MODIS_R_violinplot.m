clc;
clear all;
close all;

for window_i = [10]
    load(['R_all' num2str(window_i) '_modify.mat']);

     filters = slopes >=0;
       filters2 = [filters(:); filters(:)];
     filters = [filters(:); filters(:); filters(:)];
    
   
    %% boxplot
    figure;
    set(gcf, 'Position', [100, 100, 600, 800]);

    % First subplot

    positions = [
        0.15, 0.64, 0.8, 0.275;  % Top subplot
        0.15, 0.36, 0.8, 0.275;  % Middle subplot
        0.15, 0.08, 0.8, 0.275   % Bottom subplot
        ];

    positions2 = [
        0.61, 0.64, 0.37, 0.275;  % Top subplot
        0.61, 0.36, 0.37, 0.275;  % Middle subplot
        0.61, 0.08, 0.37, 0.275   % Bottom subplot
        ];

    labels = {'a','b','c','d','e','f'};

    ylims = [-1.1, 1.1; -1.1 1.1; -1.1 1.1];
    violin_colors = [0.6350 0.7608 0.8784; 0.9765 0.7725 0.6941; 0.8353 0.6471 0.8510]; % Light blue, light orange, light purple

    variable_names = {"\it{f}_{sno}",'Daytime \it{T}_{sur}',' Nighttime \it{T}_{sur}'};
    variable_name1 = {'FSNO','LST_day','LST_night'};

    for variable_i = 1:3
        

%         subplot('Position', positions2(variable_i,:))
%         load(['R_' variable_name1{variable_i} '_' num2str(window_i) '.mat' ]);
% 
%         plot_spatial_map(lats, lons, R1, min_clr, max_clr, title_text, 1, 1,'a');


        subplot('Position', positions(variable_i,:))
        hold on
        data = squeeze(R_aspects(variable_i,:,:));
        data(:,~filters) = nan;
        data = data';
        
        group_inx = [ones(1,size(data,1)/3), 2.*ones(1,size(data,1)/3) 3.*ones(1,size(data,1)/3)];
        mean(data(group_inx == 1,:),'omitnan')
        mean(data(group_inx == 2,:),'omitnan')
         mean(data(group_inx == 3,:),'omitnan')

%              std(data(group_inx == 1,:),1,'omitnan')
%         std(data(group_inx == 2,:),1,'omitnan')
%          std(data(group_inx == 3,:),1,'omitnan')

         s = data(group_inx == 1,:); sum(s>0)./sum(~isnan(s))
         s = data(group_inx == 2,:); sum(s>0)./sum(~isnan(s))
         s = data(group_inx == 3,:); sum(s>0)./sum(~isnan(s))

        group_names = {'PP','fineTOP','MODIS'};
        condition_names = {'Winter','Spring','Summer','Autumn','Annual'};

        line([0 5], [0 0], 'Color', 'k', 'LineWidth', 1, 'LineStyle', '--');

        %
        h = daviolinplot(data,'groups',group_inx,...
            'xtlabels', condition_names,'violin','full',...
            'boxcolors','w','smoothing',0.05,'boxwidth',1.1,'boxspacing',1, ...
            'colors',violin_colors,'outliers',0);
        ylabel(variable_names{variable_i});

        if variable_i == 1
            legend([h.ds(1,:)],group_names, 'Orientation', 'horizontal', 'Location', 'north', 'Box', 'off');    % add the legend manually
        end
        if variable_i <3
            set(gca,'XTickLabel',[])
        end
        set(gca,'FontSize',10);



        set(gca, 'FontSize', 20,'linewidth',1)
        grid off
        ylim(ylims(variable_i,:))
        box on

        if variable_i == 1
          title('Correlation to aspect (R)', 'FontSize', 20);
        end

        text(0.6,ylims(variable_i,1)*0.85,['(' labels{variable_i} ')'],'fontsize',20,'FontWeight','bold');
    end

 
   


    % Overall figure adjustments
    set(gcf, 'Color', 'w')


    export_fig(['../../figure/Figure_ELM_MODIS_' num2str(window_i) '_modify.pdf'], '-pdf', '-m2', '-painters');
    close all
end
