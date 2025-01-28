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

labels = {'a','b','c','d','e','f'};

ylims = [
     -1 1;
    -1.5 1.5;
    -20, 20;
    -7 7;
    -0.1 0.1;
    -20 20;
    ];

violin_colors = [0.6350 0.7608 0.8784; 0.9765 0.7725 0.6941]; % Light blue, light orange, light purple
violin_colors = [0.6350 0.7608 0.8784; 0.9765 0.7725 0.6941; 0.8353 0.6471 0.8510]; % Light blue, light orange, light purple
condition_names = {'Winter','Spring','Summer','Autumn','Annual'};


figure;
set(gcf, 'Position', [100, 100, 900, 800]);

%variable_names = {"Snow cover fraction",'Daytime surface temperature','Nighttime surface temperature'};
variables = {'TV','t_rad_grc','FSH','EFLX_LH_TOT','FSNO','H2OSNO'};
variable_names = {'\Delta\it{T}_{veg} (K)','\Delta\it{T}_{sur} (K)','\Delta\it{F}_{sen} (W/m^2)','\Delta\it{F}_{lat} (W/m^2)','\Delta\it{f}_{sno}','\DeltaSWE (mm)'};
for variable_i = 1:6
    subplot('Position', positions(variable_i,:))
    hold on

    data = get_variable_all_oldtop(variables{variable_i});

    mean(data(aspect_NS==0,:),'omitnan')
    std(data(aspect_NS==0,:),1,'omitnan')
    mean(data(aspect_NS==1,:),1,'omitnan')
    std(data(aspect_NS==1,:),1,'omitnan')

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



    set(gca, 'FontSize', 20,'linewidth',1)
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
export_fig('../figure/Figure_energy_SN_oldTOP.pdf', '-pdf', '-m2', '-painters','-nocrop');

close all

