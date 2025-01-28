clc;
clear all;
close all;

for gridSize = [5 10 20]
    numRows = 900;
    numCols = 700;
    numGridsRow = numRows / gridSize;
    numGridsCol = numCols / gridSize;

    load('../kTOP_factors.mat');
    load('mask_SN.mat');
    aspect_NS = aspect;
    aspect_NS(aspect_NS>180) = aspect_NS(aspect_NS>180)-360;
    aspect_NS = abs(aspect_NS);

  
    slopes = nan(numGridsRow, numGridsCol);
    R_aspects = nan(3,5,numGridsRow*numGridsCol*3);
    R_MODISs = nan(3,5,numGridsRow*numGridsCol*2);
    Bias_MODISs = nan(3,5,numGridsRow*numGridsCol*2);
    RMSE_MODISs = nan(3,5,numGridsRow*numGridsCol*2);

    variable_names = {'FSNO','LST_day','LST_night'};
    for variable_name_i = 1:3
        variable_name = variable_names{variable_name_i};
        for season_i = 1:5

            load([ '../data/' variable_name '_seasonal_ELM_MODIS_' num2str(season_i) '_modify.mat']);

            % load([ '../data/' 'FLDS_seasonal_ELM_only_5.mat']);

            R1 = nan(numGridsRow, numGridsCol);
            R2 = nan(numGridsRow, numGridsCol);
            R3 = nan(numGridsRow, numGridsCol);
            R4 = nan(numGridsRow, numGridsCol);
            R5 = nan(numGridsRow, numGridsCol);

            Bias4 = nan(numGridsRow, numGridsCol);
            Bias5 = nan(numGridsRow, numGridsCol);

            RMSE4 = nan(numGridsRow, numGridsCol);
            RMSE5 = nan(numGridsRow, numGridsCol);

            % Loop through each 10x10 grid
            for i = 1:numGridsRow
                for j = 1:numGridsCol
                    % Extract 10x10 grid from original matrix
                    aspects = aspect_NS((i-1)*gridSize+1:i*gridSize, (j-1)*gridSize+1:j*gridSize);
                    slope_ij = slope((i-1)*gridSize+1:i*gridSize, (j-1)*gridSize+1:j*gridSize);
                    inSN_ij = inSN((i-1)*gridSize+1:i*gridSize, (j-1)*gridSize+1:j*gridSize);

                    if(sum(inSN_ij(:)) < (gridSize*gridSize))
                    continue;
                    end

                    slopes(i,j) = nanmean(slope_ij(:));
                    % Example: Calculate mean value for each grid
                    values1 = kTOP_surf_seasons((i-1)*gridSize+1:i*gridSize, (j-1)*gridSize+1:j*gridSize); % You can replace this with any statistical measure
                    values2 = default_seasons((i-1)*gridSize+1:i*gridSize, (j-1)*gridSize+1:j*gridSize); % You can replace this with any statistical measure
                    values3 = MODIS_data((i-1)*gridSize+1:i*gridSize, (j-1)*gridSize+1:j*gridSize); % You can replace this with any statistical measure

                    if (variable_name_i == 1)
                        values1(values1<=0) = nan;
                        values2(values2<=0) = nan;
                        values3(values3<=0) = nan;
                    end
                    R1(i,j) = corr(aspects(:), values1(:));
                    R2(i,j) = corr(aspects(:), values2(:));
                    R3(i,j) = corr(aspects(:), values3(:));
                    R4(i,j) = corr(values1(:), values3(:));
                    R5(i,j) = corr(values2(:), values3(:));

                    Bias4(i,j) = mean(values1(:)-values3(:));
                    Bias5(i,j) = mean(values2(:)-values3(:));

                    RMSE4(i,j) = sqrt(mean((values1(:)-values3(:)).^2));
                    RMSE5(i,j) = sqrt(mean((values2(:)-values3(:)).^2));

                end
            end

            save(['R_' variable_name '_' num2str(gridSize) num2str(season_i) '_modify.mat'],'R1','R2',"R3","R4","R5");

%             figure;
%             colors = flipud(brewermap(11,'RdBu'));
%             colormap(colors)
%             subplot(231)
%             imagesc(R2, [-0.8 0.8])
%              subplot(232)
%             imagesc(R1, [-0.8 0.8])
%              subplot(233)
%             imagesc(R3, [-0.8 0.8])
% 
%             subplot(234)
%             imagesc(R4, [-0.8 0.8])
%             subplot(235)
%             imagesc(R4-R5, [-0.2 0.2])

            R_aspects(variable_name_i, season_i, :) = [R2(:); R1(:); R3(:)];
            R_MODISs(variable_name_i, season_i, :)  = [R5(:); R4(:)];
            Bias_MODISs(variable_name_i, season_i, :)  = [Bias5(:); Bias4(:)];
            RMSE_MODISs(variable_name_i, season_i, :)  = [RMSE5(:); RMSE4(:)];
        end
    end

    save(['R_all' num2str(gridSize) '_modify.mat'],'R_aspects','R_MODISs',"Bias_MODISs","RMSE_MODISs","slopes");
end