clc;
clear all;
close all;

load("kTOP_factors.mat");
load("mask_SN.mat");
load('LCELM_1km.mat');
load('LAISAI_1km.mat');
res_v = 0.01;
res_h = 0.01;
lon = (-124+res_h/2):res_h: (-117-res_h/2);
lat = (43-res_v/2):-res_v: (34 + res_v/2);

[lons,lats]=meshgrid(lon,lat);


season_i = 5;

%% annual


aspect_NS = aspect;
aspect_NS(:) = 0;
aspect_NS(aspect>90 & aspect<270) = 1;
aspect_NS = aspect_NS(:);




condition_names = {'Winter','Spring','Summer','Autumn','Annual'};
%
% figure;
% hold on
% line([0 6], [0 0], 'Color', 'k', 'LineWidth', 1, 'LineStyle', '--');
%
% h = daboxplot(FSH_all,'groups',aspect_NS,'outsymbol','kx',...
%     'xtlabels', condition_names,'fill',1,'mean',1,'outliers',0);
%
% box on

positions = [
    0.09, 0.68, 0.4, 0.27;  % Top subplot
    0.09, 0.38, 0.4, 0.27;  % Middle subplot
    0.09, 0.08, 0.4, 0.27;  % Bottom subplot
    0.59, 0.68, 0.4, 0.27;  % Top subplot
    0.59, 0.38, 0.4, 0.27;  % Middle subplot
    0.59, 0.08, 0.4, 0.27   % Bottom subplot
    ];

%labels = {'a','b','c','d','e','f'};
labels = {'a','c','e','b','d','f'};

ylims = [-35, 35;
    -1 1;
    -1 1;
    -5 5;
    -15 15;
    -0.04 0.04
    ];

violin_colors = [0.6350 0.7608 0.8784; 0.9765 0.7725 0.6941]; % Light blue, light orange, light purple
violin_colors = [0.6350 0.7608 0.8784; 0.9765 0.7725 0.6941; 0.8353 0.6471 0.8510]; % Light blue, light orange, light purple
condition_names = {'Winter','Spring','Summer','Autumn','Annual'};


figure;
set(gcf, 'Position', [100, 100, 900, 800]);

%variable_names = {"Snow cover fraction",'Daytime surface temperature','Nighttime surface temperature'};
variables = {'SW_DIR','SW_DIF','SW_ADJ','LW_SKY','LW_ADJ','ALBEDO'};
variable_names = {'\Delta\it{SW}_{dir} (W/m^2)','\Delta\it{SW}_{sky} (W/m^2)','\Delta\it{SW}_{adj} (W/m^2)','\Delta\it{LW}_{sky} (W/m^2)','\Delta\it{LW}_{adj} (W/m^2)','\Delta\it{A}_{sur}'};
for variable_i = 1:6
    subplot('Position', positions(variable_i,:))
    hold on

    data = get_variable_albedo(variables{variable_i});


    line([0 6], [0 0], 'Color', 'k', 'LineWidth', 1, 'LineStyle', '--');

    h = daboxplot(data,'groups',aspect_NS, 'outsymbol','kx',...
        'xtlabels', condition_names,'fill',1,'mean',1,'outliers',0);
 
     if variable_i == 2
         legend([h.bx(1,:)],{'North-facing Slope','South-facing Slope'}, 'Orientation', 'vertical', 'Location', 'north', 'Box', 'off');    % add the legend manually
     end

    ylabel(variable_names{variable_i});
    %ylabel('$\it{T}_{\mathrm{veg}}$ (K)', 'Interpreter', 'latex');
    if variable_i <3 || variable_i == 4 || variable_i == 5
        set(gca,'XTickLabel',[])
    end
    set(gca,'FontSize',10);



    set(gca, 'FontSize', 18,'linewidth',1)
    grid off
    ylim(ylims(variable_i,:))

    xlim([0.5 5.5])
    box on

    %        if variable_i == 1
    %           title({'Difference in correlation with', 'MODIS (\DeltaR)'}, 'FontSize', 20, 'HorizontalAlignment', 'center');
    %        end



    text(0.6,ylims(variable_i,1)*0.85,['(' labels{variable_i} ')'],'fontsize',20,'FontWeight','bold');
end


set(gcf, 'Color', 'w');
export_fig('../figure/Figure_seperate_radiation_SN.pdf', '-pdf', '-m2', '-painters','-nocrop');

close all

