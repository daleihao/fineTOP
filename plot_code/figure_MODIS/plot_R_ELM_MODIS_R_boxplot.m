clc;
clear all;
close all;

for window_i = [10]
    load(['R_all' num2str(window_i) '_modify.mat']);
    %% boxplot

    %% boxplot
    figure;
    set(gcf, 'Position', [100, 100, 450, 600]);

    % First subplot

    positions = [
        0.16, 0.70, 0.8, 0.27;  % Top subplot
        0.16, 0.39, 0.8, 0.27;  % Middle subplot
        0.16, 0.08, 0.8, 0.27   % Bottom subplot
        ];

    ylims = [-0.4, 0.4; -0.6 0.6; -0.4 0.4];

    violin_colors = [0.6350 0.7608 0.8784; 0.9765 0.7725 0.6941]; % Light blue, light orange, light purple
    violin_colors = [0.6350 0.7608 0.8784; 0.9765 0.7725 0.6941; 0.8353 0.6471 0.8510]; % Light blue, light orange, light purple


    variable_names = {"Snow cover fraction",'Daytime surface temperature','Nighttime surface temperature'};
    for variable_i = 1:3
        subplot('Position', positions(variable_i,:))
        hold on
        data = squeeze(R_MODISs(variable_i,:,:));
        data = data';
        group_inx = [ones(1,size(data,1)/2), 2.*ones(1,size(data,1)/2)];
        data(group_inx == 1,:) = data(group_inx == 2,:) - data(group_inx == 1,:);
        data  = data(group_inx == 1,:);
        mean(data,'omitnan')

        group_names = {'PP','fineTOP'};
        condition_names = {'Winter','Spring','Summer','Autumn','Annual'};

        line([0 5], [0 0], 'Color', 'k', 'LineWidth', 1, 'LineStyle', '--');

        h = daboxplot(data,'outsymbol','kx',...
    'xtlabels', condition_names,'fill',1,'mean',1);

%         h = daviolinplot(data,'groups',group_inx,...
%             'xtlabels', condition_names,'violin','full',...
%             'boxcolors','w','smoothing',0.01,'boxwidth',1.1,'boxspacing',1, ...
%             'colors',violin_colors);
        ylabel('\DeltaR');

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

        title(variable_names{variable_i}, 'FontSize', 20);
    end

    % Overall figure adjustments
    set(gcf, 'Color', 'w')


    export_fig(['../../figure/Figure_MODIS_' num2str(window_i) '_modify.pdf'], '-pdf', '-transparent', '-m2', '-painters');
    close all

end

