clc;
clear all;
close all;

load('LCELM_1km.mat');

load('data/FSA_seasonal_ELM_only_1_with_oldtop.mat');
season_i = 1;

diff1 = kTOP_nosurf_seasons - default_seasons;
diff2 = oldTOP_seasons - default_seasons;

diff1(LC_ELM_Data>=17) = nan;
diff2(LC_ELM_Data>=17) = nan;

figure;
subplot(121)
hold on

plot([0 0],[-60 60],'k','linewidth',2)
plot([-60 60],[0 0],'k','linewidth',2)

scatter(diff1(:),diff2(:),'red','filled')
alpha(0.05)
xlim([-60 60])
ylim([-60 60])


xlabel('kTOP - PP')
ylabel('TOP - PP')

text(-50, 50,[ 'kTOP mean: ' num2str(nanmean(diff1(:)),'%4.2f')],'fontsize',18)
text(-50, 40,[ 'TOP mean: ' num2str(nanmean(diff2(:)),'%4.2f')],'fontsize',18)


filters = ~isnan(diff1) & ~isnan(diff2);
f = fit(diff1(filters), diff2(filters), 'poly1'); % 'poly1' indicates a linear fit

% Plot the data and the fit
plot(f,'b');


box on

set(gca, 'linewidth',2,'fontsize',18)

title('SW_{net}');

xlabel('kTOP - PP')
ylabel('TOP - PP')


%% Rnet
variable_name = 'FSA';
load(['data/' variable_name '_seasonal_ELM_only_' num2str(season_i) '_with_oldtop.mat']);

dif_variable1 = oldTOP_seasons - default_seasons;

variable_name = 'FIRA';
load(['data/' variable_name '_seasonal_ELM_only_' num2str(season_i) '_with_oldtop.mat']);

% Reshape the differences to have seasons in columns
dif_variable2 = oldTOP_seasons - default_seasons;

diff2 = dif_variable1 - dif_variable2;

variable_name = 'FSA';
load(['data/' variable_name '_seasonal_ELM_only_' num2str(season_i) '_with_oldtop.mat']);

dif_variable1 = kTOP_nosurf_seasons - default_seasons;

variable_name = 'FIRA';
load(['data/' variable_name '_seasonal_ELM_only_' num2str(season_i) '_with_oldtop.mat']);

% Reshape the differences to have seasons in columns
dif_variable2 = kTOP_nosurf_seasons - default_seasons;

diff1 = dif_variable1 - dif_variable2;

diff1(LC_ELM_Data>=17) = nan;
diff2(LC_ELM_Data>=17) = nan;


subplot(122)
hold on

plot([0 0],[-60 60],'k','linewidth',2)
plot([-60 60],[0 0],'k','linewidth',2)

scatter(diff1(:),diff2(:),'red','filled')
alpha(0.05)
xlim([-60 60])
ylim([-60 60])



text(-50, 50,[ 'kTOP mean: ' num2str(nanmean(diff1(:)),'%4.2f')],'fontsize',18)
text(-50, 40,[ 'TOP mean: ' num2str(nanmean(diff2(:)),'%4.2f')],'fontsize',18)

filters = ~isnan(diff1) & ~isnan(diff2);
f = fit(diff1(filters), diff2(filters), 'poly1'); % 'poly1' indicates a linear fit

% Plot the data and the fit
plot(f,'b');

box on

title('R_{net}');

xlabel('kTOP - PP')
ylabel('TOP - PP')

set(gca, 'linewidth',2,'fontsize',18)


%% Tsur
clc;
clear all;
close all;

load('LCELM_1km.mat');

load('data/FSH_seasonal_ELM_only_5_with_oldtop.mat');
season_i = 5;

diff1 = kTOP_nosurf_seasons - default_seasons;
diff2 = oldTOP_seasons - default_seasons;

diff1(LC_ELM_Data>=17) = nan;
diff2(LC_ELM_Data>=17) = nan;

figure;
subplot(121)
hold on

plot([0 0],[-2 2],'k','linewidth',2)
plot([-2 2],[0 0],'k','linewidth',2)

scatter(diff1(:),diff2(:),'red','filled')
alpha(0.05)
xlim([-2 2])
ylim([-2 2])


xlabel('kTOP - PP')
ylabel('TOP - PP')

text(-1.5, 2,[ 'kTOP mean: ' num2str(nanmean(diff1(:)),'%4.4f')],'fontsize',18)
text(-1.5, 1.5,[ 'TOP mean: ' num2str(nanmean(diff2(:)),'%4.4f')],'fontsize',18)
