numRows = 900;
numCols = 700;
gridSize = 10;
numGridsRow = numRows / gridSize;
numGridsCol = numCols / gridSize;

load('kTOP_factors.mat');
aspect_NS = aspect;
aspect_NS(aspect_NS>180) = aspect_NS(aspect_NS>180)-360;
aspect_NS = abs(aspect_NS);

% Example matrix (replace this with your actual matrix)
originalMatrix = rand(numRows, numCols); % Example random matrix

% Initialize arrays to store aspect ratios and values
aspects = zeros(numGridsRow, numGridsCol);
values = zeros(numGridsRow, numGridsCol);

R1 = nan(numGridsRow, numGridsCol);
R2 = nan(numGridsRow, numGridsCol);
R3 = nan(numGridsRow, numGridsCol);

R4 = nan(numGridsRow, numGridsCol);
R5 = nan(numGridsRow, numGridsCol);

% Loop through each 10x10 grid
for i = 1:numGridsRow
    for j = 1:numGridsCol
        % Extract 10x10 grid from original matrix
        aspects = aspect_NS((i-1)*gridSize+1:i*gridSize, (j-1)*gridSize+1:j*gridSize);
                
        % Example: Calculate mean value for each grid
        values1 = kTOP_surf_seasons((i-1)*gridSize+1:i*gridSize, (j-1)*gridSize+1:j*gridSize); % You can replace this with any statistical measure

        
       
        values2 = default_seasons((i-1)*gridSize+1:i*gridSize, (j-1)*gridSize+1:j*gridSize); % You can replace this with any statistical measure


        values3 = MODIS_data((i-1)*gridSize+1:i*gridSize, (j-1)*gridSize+1:j*gridSize); % You can replace this with any statistical measure

        R1(i,j) = corr(aspects(:), values1(:));
        R2(i,j) = corr(aspects(:), values2(:));

        R3(i,j) = corr(aspects(:), values3(:));

        R4(i,j) = corr(values1(:), values3(:));
        R5(i,j) = corr(values2(:), values3(:));

    end
end

% Compute correlation coefficient R between aspectRatio and values

% Display the correlation coefficient R
figure;
subplot(121)
hold on
histogram(R1(:),100)
histogram(R2(:),100)
histogram(R3(:),100)
legend('kTOP','default1','MODIS')
subplot(122)
hold on
histogram(R4(:),100)
histogram(R5(:),100)
legend('kTOP','default1')

%% boxplot
figure;
% First subplot
subplot(121)
hold on

data = [R2(:); R1(:); R3(:)];

group_inx = [ones(1,6300), 2.*ones(1,6300) 3.*ones(1,6300)];


group_names = {'PP','kTOP','MODIS'};
condition_names = {'season_1'};
%
h = daviolinplot(data,'groups',group_inx,...
    'xtlabels', condition_names,'violin','full',...
    'boxcolors','w','smoothing',0.05); 
ylabel('Performance');
xl = xlim; xlim([xl(1), xl(2)+0.25]);    % make space for the legend
legend([h.ds(1,:)],group_names);    % add the legend manually
set(gca,'FontSize',10);


title('Comparison of R1, R2, and R3')
xlabel('Categories')
ylabel('Values')
legend({'default1','kTOP', 'MODIS'}, 'Location', 'northeastoutside')
set(gca, 'FontSize', 12)
grid on
ylim([-1 0.4])

% Second subplot
subplot(122)
hold on


data = [R5(:) ; R4(:)];

group_inx = [ones(1,6300), 2.*ones(1,6300)];

group_names = {'PP','kTOP'};
condition_names = {'season_1'};
% full violin plots with white embedded boxplots for 3x2 data


h = daviolinplot(data,'groups',group_inx,...
    'xtlabels', condition_names,'violin','full',...
    'boxcolors','w','smoothing',0.1); 
ylabel('R');
xl = xlim; xlim([xl(1), xl(2)+0.25]);    % make space for the legend
legend([h.ds(1,:)],group_names);    % add the legend manually
set(gca,'FontSize',10);

title('Comparison of R4 and R5')
%legend({ 'default1','kTOP'}, 'Location', 'northeastoutside')
set(gca, 'FontSize', 12)
grid on
ylim([-1 1])


% Overall figure adjustments
set(gcf, 'Color', 'w')
