% Define your matrix
data = group1;
data = data';
% Define the directions (angles in radians)
angles = linspace(0, 2*pi, 9); % 8 directions plus the starting angle

% Define the seasons (just labels for the legend)
seasons = {'Spring', 'Summer', 'Fall', 'Winter'};

% Create a new polar plot
figure;
polarax = polaraxes; % Create polar axes

% Loop through each season and plot
hold on;
for i = 1:4
    % Extract the data for the current season
    values = data(i, :);
    
    % Create a polar plot for the current season
    polarplot(polarax, angles, [values, values(1)], 'DisplayName', seasons{i}, 'LineWidth', 1.5);
end

% Add a legend
legend(polarax, 'show');

% Add title
title(polarax, 'Seasonal Data in Polar Coordinates');

% Adjust polar plot properties
polarax.ThetaTickLabel = arrayfun(@num2str, 0:45:315, 'UniformOutput', false); % Customize theta labels if needed
