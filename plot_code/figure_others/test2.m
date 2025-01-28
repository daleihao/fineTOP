
diff_seasons = nan(900*700, 5);
for season_i = 1:5
    load(['data/FSDS_seasonal_ELM_only_' num2str(season_i) '.mat']);
% Reshape the differences to have seasons in columns
dif_variable = kTOP_surf_seasons - default_seasons;

dif_variable(slope<15) = nan;
diff_seasons(:,season_i) = (dif_variable(:));
end

% Create a boxplot
figure;
boxplot(diff_seasons, 'Labels', {'Season 1', 'Season 2', 'Season 3', 'Season 4','Annual'});
title('Boxplot of Differences Between kTOP\_surf\_seasons and default\_seasons Across Seasons');
ylabel('Difference');

% Optionally customize the plot for better readability
grid on;
xlabel('Seasons');



%% heat map
% Assuming kTOP_surf_seasons and default_seasons are 700x900 matrices
% with the 4 seasons arranged along the third dimension (size: 700x900x4)

% Generate synthetic data for demonstration purposes
% Remove the below lines if you already have kTOP_surf_seasons and default_seasons
for season_i = 4
    load(['data/FSNO_seasonal_ELM_only_' num2str(season_i) '.mat']);
% Reshape the differences to have seasons in columns
dif_variable = kTOP_surf_seasons - default_seasons;
diff_seasons(:,season_i) = dif_variable(:);
end
% Calculate the differences for one season (e.g., season 1)
differences = kTOP_surf_seasons - default_seasons;

% Generate synthetic slope and aspect data for demonstration purposes
% Remove the below lines if you already have slope and aspect data

% Define slope and aspect intervals
slope_intervals = 0:5:30;
aspect_intervals = 0:30:360;

% Initialize the heatmap matrix
heatmap_data = zeros(length(slope_intervals)-1, length(aspect_intervals)-1);

% Calculate mean differences for each slope-aspect interval
for i = 1:length(slope_intervals)-1
    for j = 1:length(aspect_intervals)-1
        % Find the indices for the current slope and aspect interval
        slope_indices = slope >= slope_intervals(i) & slope < slope_intervals(i+1);
        aspect_indices = aspect >= aspect_intervals(j) & aspect < aspect_intervals(j+1);
        
        % Find the combined indices
        combined_indices = slope_indices & aspect_indices;
        
        % Calculate the mean difference for the current interval
        heatmap_data(i, j) = mean(differences(combined_indices), 'omitnan');
    end
end

color_1 = brewermap(100, 'BrBG');

% Plot the heatmap
figure;
colormap(color_1)
imagesc(heatmap_data);
colorbar;
title('Heatmap of Differences by Slope and Aspect Intervals');
xlabel('Aspect Intervals (45-degree steps)');
ylabel('Slope Intervals (5-degree steps)');

% Set x-axis and y-axis labels
%xticks(1:length(aspect_intervals)-1);
%yticks(1:length(slope_intervals)-1);
%xticklabels(arrayfun(@(x) sprintf('%d-%d', aspect_intervals(x), aspect_intervals(x+1)), 1:length(aspect_intervals)-1, 'UniformOutput', false));
%yticklabels(arrayfun(@(x) sprintf('%d-%d', slope_intervals(x), slope_intervals(x+1)), 1:length(slope_intervals)-1, 'UniformOutput', false));


%% dif 2

diff_seasons1 = nan(900*700, 5);
diff_seasons2 = nan(900*700, 5);
for season_i = 1:5
    load(['data/FSA_seasonal_ELM_only_' num2str(season_i) '.mat']);
    load(['data/FSDS_seasonal_ELM_only_' num2str(season_i) '.mat']);
   

    % Reshape the differences to have seasons in columns
dif_variable1 = kTOP_surf_seasons - default_seasons;
dif_variable2 = kTOP_nosurf_seasons - default_seasons;

dif_variable1(slope<15) = nan;
diff_seasons1(:,season_i) = (dif_variable1(:));
dif_variable2(slope<15) = nan;
diff_seasons2(:,season_i) = (dif_variable2(:));
end

dif_ratio = abs(diff_seasons2./diff_seasons1);
% Create a boxplot
figure;
boxplot(dif_ratio, 'Labels', {'Season 1', 'Season 2', 'Season 3', 'Season 4','Annual'});
ylim([-1 1])
title('Boxplot of Differences Between kTOP\_surf\_seasons and default\_seasons Across Seasons');
ylabel('Difference');

% Optionally customize the plot for better readability
grid on;
xlabel('Seasons');


%% albedo
diff_seasons1 = nan(900*700, 5);
diff_seasons2 = nan(900*700, 5);
for season_i = 1:5
    load(['data/FSA_seasonal_ELM_only_' num2str(season_i) '.mat']);
   FSA_ktop = kTOP_surf_seasons;
   FSA_ktop2 = kTOP_nosurf_seasons;
   FSA_PP = default_seasons;
   
    load(['data/FSDS_seasonal_ELM_only_' num2str(season_i) '.mat']);
   FSDS_ktop = kTOP_surf_seasons;
   FSDS_ktop2 = kTOP_nosurf_seasons;
   FSDS_PP = default_seasons;
    
   Albedo_ktop = 1 - FSA_ktop./FSDS_ktop;
    Albedo_ktop2 = 1 - FSA_ktop2./FSDS_ktop2;
   Albedo_pp = 1 - FSA_PP./FSDS_PP;

    Albedo_ktop = 1 - FSA_ktop./FSDS_ktop;
    Albedo_ktop2 = 1 - FSA_ktop2./FSDS_ktop2;
   Albedo_pp = 1 - FSA_PP./FSDS_PP;
   
    dif_variable1 = Albedo_ktop - Albedo_pp;
dif_variable2 = Albedo_ktop2 - Albedo_pp;
    % Reshape the differences to have seasons in columns


dif_variable1(slope<15) = nan;
diff_seasons1(:,season_i) = (dif_variable1(:)./Albedo_pp(:));
dif_variable2(slope<15) = nan;
diff_seasons2(:,season_i) = (dif_variable2(:));
end

dif_ratio = abs(diff_seasons1);
% Create a boxplot
figure;
boxplot(dif_ratio, 'Labels', {'Season 1', 'Season 2', 'Season 3', 'Season 4','Annual'});
ylim([-1 1])
title('Boxplot of Differences Between kTOP\_surf\_seasons and default\_seasons Across Seasons');
ylabel('Difference');

% Optionally customize the plot for better readability
grid on;
xlabel('Seasons');