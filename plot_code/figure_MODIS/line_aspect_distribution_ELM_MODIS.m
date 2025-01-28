clc;
clear all;
close all;

load(['ELM_MODIS_all_modify.mat']);
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

season_i = 1;

for variable_i = 1:3

hold on
data1 = squeeze(default_seasons_all(variable_i,season_i,:));
data1(slope_all<15) = nan;

group_inx = repmat(aspects_all,1,4);
data2 = squeeze(kTOP_surf_seasons_all(variable_i,season_i,:));

data2(slope_all<15) = nan;


data3 = squeeze(MODIS_data_all(variable_i,season_i,:));
data3(slope_all<15) = nan;

data = [data1 data2 data3]; 


group1 = groupsummary(data1, group_inx, 'mean');
group2 = groupsummary(data2, group_inx, 'mean');
group3 = groupsummary(data3, group_inx, 'mean');

figure;
hold on
plot(group3,group1,'.')
plot(group3,group2,'.')

corrcoef(group3,group1)
corrcoef(group3,group2)

end

