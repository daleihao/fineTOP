clc;
clear all;
close all;

load(['ELM_MODIS_all_modify_NS.mat']);
%% boxplot

% First subplot

positions = [
    0.12, 0.69, 0.85, 0.275;  % Top subplot
    0.12, 0.37, 0.85, 0.275;  % Middle subplot
    0.12, 0.05, 0.85, 0.275   % Bottom subplot
];

ylims = [-1.1, 1.1; -1.1 1.1; -1.1 1.1];
%violin_colors = [0.6350 0.7608 0.8784; 0.9765 0.7725 0.6941; 0.8353 0.6471 0.8510]; % Light blue, light orange, light purple

variable_names = {"Snow cover fraction",'Daytime surface temperature','Nighttime surface temperature'};


NS_dif = nan(5,3,3);

for season_i = 1:5

for variable_i = 1:3

hold on
data1 = squeeze(default_seasons_all(variable_i,season_i,:));
data1(slope_all<5) = nan;

group_inx = repmat(aspects_all,1,4);
data2 = squeeze(kTOP_surf_seasons_all(variable_i,season_i,:));

data2(slope_all<5) = nan;


data3 = squeeze(MODIS_data_all(variable_i,season_i,:));
data3(slope_all<15) = nan;

NS_dif(season_i, variable_i,1) = mean(data1(aspects_all==0),'omitnan') - mean(data1(aspects_all==1),'omitnan');
NS_dif(season_i, variable_i,2) = mean(data2(aspects_all==0),'omitnan') - mean(data2(aspects_all==1),'omitnan');
NS_dif(season_i, variable_i,3) = mean(data3(aspects_all==0),'omitnan') - mean(data3(aspects_all==1),'omitnan');
end

end


figure;
hold on
% figure;
% group1 = groupsummary(data1, group_inx, 'mean');
% group2 = groupsummary(data2, group_inx, 'mean');
% group3 = groupsummary(data3, group_inx, 'mean');
% 
% 
% hold on
% plot(group1 -repmat(mean(group1),8,1) ,'r')
% plot(group2-repmat(mean(group2),8,1),'g')
% plot(group3-repmat(mean(group3),8,1),'b')
% %
% h = daviolinplot(data,'groups',group_inx,...
%     'xtlabels', condition_names,'violin','full',...
%     'boxcolors','w','smoothing',0.05,'boxwidth',1.1,'boxspacing',1);
% ylabel('R');
% 
% if variable_i == 3
% legend([h.ds(1,:)],group_names, 'Orientation', 'horizontal', 'Location', 'north', 'Box', 'off');    % add the legend manually
% end
% if variable_i <3
% set(gca,'XTickLabel',[])
% end
% set(gca,'FontSize',10);
% 
% 
% 
% set(gca, 'FontSize', 20,'linewidth',1)
% grid off
% ylim(ylims(variable_i,:))
% box on
% 
% title(variable_names{variable_i}, 'FontSize', 20);
% 
% 
% % Overall figure adjustments
% set(gcf, 'Color', 'w')
% 
% 
% export_fig(['../../figure/Figure_aspect_ELM_MODIS_' '.pdf'], '-pdf', '-transparent', '-m2', '-painters');
% close all
% 
