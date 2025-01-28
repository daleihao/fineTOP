clc;
clear all;
close all;

for window_i = [10]
load(['R_all' num2str(window_i) '_modify.mat']);


%% boxplot
figure;
set(gcf, 'Position', [100, 100, 600, 800]);

% First subplot

positions = [
    0.12, 0.69, 0.85, 0.275;  % Top subplot
    0.12, 0.37, 0.85, 0.275;  % Middle subplot
    0.12, 0.05, 0.85, 0.275   % Bottom subplot
];

ylims = [-1.1, 1.1; -1.1 1.1; -1.1 1.1];
violin_colors = [0.6350 0.7608 0.8784; 0.9765 0.7725 0.6941]; % Light blue, light orange, light purple
violin_colors = [0.6350 0.7608 0.8784; 0.9765 0.7725 0.6941; 0.8353 0.6471 0.8510]; % Light blue, light orange, light purple


variable_names = {"Snow cover fraction",'Daytime surface temperature','Nighttime surface temperature'};
for variable_i = 1:3
subplot('Position', positions(variable_i,:))
hold on
data = squeeze(Bias_MODISs(variable_i,:,:));
data = data';
group_inx = [ones(1,size(data,1)/2), 2.*ones(1,size(data,1)/2)];

data(group_inx == 1,:) = abs(data(group_inx == 2,:)) - abs(data(group_inx == 1,:));
data(group_inx == 2,:) = 0;

group_names = {'PP','fineTOP'};
condition_names = {'Winter','Spring','Summer','Autumn'};

line([0 5], [0 0], 'Color', 'k', 'LineWidth', 1, 'LineStyle', '--');

%
h = daviolinplot(data,'groups',group_inx,...
    'xtlabels', condition_names,'violin','full',...
    'boxcolors','w','smoothing',0.05,'boxwidth',1.1,'boxspacing',1, ...
    'colors',violin_colors);
ylabel('R');

if variable_i == 1
legend([h.ds(1,:)],group_names, 'Orientation', 'horizontal', 'Location', 'south', 'Box', 'off');    % add the legend manually
end
if variable_i <3
set(gca,'XTickLabel',[])
end
set(gca,'FontSize',10);



set(gca, 'FontSize', 20,'linewidth',1)
grid off
ylim([-0.2 0.2])
box on

title(variable_names{variable_i}, 'FontSize', 20);
end

% Overall figure adjustments
set(gcf, 'Color', 'w')


export_fig(['../../figure/Figure_MODIS_' num2str(window_i) '_RMSE.pdf'], '-pdf', '-transparent', '-m2', '-painters');
close all

end
