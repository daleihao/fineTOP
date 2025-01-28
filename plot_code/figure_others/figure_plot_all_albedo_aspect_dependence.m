clc;
clear all;
close all;


figure;
set(gcf,'unit','normalized','position',[0.1,0.05,0.6,0.62]);
set(gca, 'Position', [0 0 1 1]);

s=subplot('position', [0.08 + (1-1)*0.29 0.52 0.28 0.4]);
plot_polar_plot_albedo_dif(5,'FSA',5,'\Delta\it{SW}_{net}')

colorbar off
text(-1.1,0.95,'(a)','fontsize',20,'FontWeight','bold');

s=subplot('position', [0.08 + (2-1)*0.29 0.52 0.28 0.4]);
plot_polar_plot_albedo_dif(5,'FIRA',5,'\Delta\it{LW}_{net}')

colorbar off
text(-1.1,0.95,'(b)','fontsize',20,'FontWeight','bold');


s=subplot('position', [0.08 + (3-1)*0.29 0.52 0.28 0.4]);
plot_polar_plot_albedo_dif(5,'Rnet',5,'\Delta\it{R}_{net}')

clr = colorbar;
clr.Title.String = "W/m^2";
clr.Position = [0.05 + (4-1)*0.3 0.54 0.02 0.36];
text(-1.1,0.95,'(c)','fontsize',20,'FontWeight','bold');

%% ratio

load("kTOP_factors.mat");
load("mask_SN.mat");
load('LCELM_1km.mat');
load('LAISAI_1km.mat');
res_v = 0.01;
res_h = 0.01;
lon = (-124+res_h/2):res_h: (-117-res_h/2);
lat = (43-res_v/2):-res_v: (34 + res_v/2);

[lons,lats]=meshgrid(lon,lat);

aspect_NS = aspect;
aspect_NS(:) = 0;
aspect_NS(aspect>=90 & aspect<=270) = 1;
aspect_NS = aspect_NS(:);

condition_names = {'Winter','Spring','Summer','Autumn','Annual'};


positions = [
 [0.08 + (1-1)*0.3 0.1 0.28 0.4];
 [0.08 + (2-1)*0.3 0.1 0.28 0.4];
 [0.08 + (3-1)*0.3 0.1 0.28 0.4]
    ];

labels = {'d','e','f'};

ylims = [
    -30 50;
    -30 50;
    -30 50;
    ];

violin_colors = [0.6350 0.7608 0.8784; 0.9765 0.7725 0.6941]; % Light blue, light orange, light purple
violin_colors = [0.6350 0.7608 0.8784; 0.9765 0.7725 0.6941; 0.8353 0.6471 0.8510]; % Light blue, light orange, light purple
condition_names = {'Winter','Spring','Summer','Autumn','Annual'};



%variable_names = {"Snow cover fraction",'Daytime surface temperature','Nighttime surface temperature'};
variables = {'FSA','FIRA','Rnet','FSA','FIRA','Rnet'};
%variable_names = {'\Delta\it{SW}_{dir} (W/m^2)','\Delta\it{SW}_{sky} (W/m^2)','\Delta\it{SW}_{adj} (W/m^2)','\Delta\it{LW}_{sky} (W/m^2)','\Delta\it{LW}_{adj} (W/m^2)','\Delta\it{A}_{sur}'};
for variable_i = 1:3
    subplot('Position', positions(variable_i,:))
    hold on

    [data,data2 ]= get_variable_albedo_dif(variables{variable_i});

   
    data = data2;
   

    line([0 6], [0 0], 'Color', 'k', 'LineWidth', 1, 'LineStyle', '--');

    h = daboxplot(data,'groups',aspect_NS, 'outsymbol','kx',...
        'xtlabels', condition_names,'fill',1,'mean',1,'outliers',0);
 
     if variable_i == 1
         legend([h.bx(1,:)],{'North-facing Slope','South-facing Slope'}, 'Orientation', 'horizontal', 'Location', 'north', 'Box', 'off','NumColumns',1);    % add the legend manually
     end

    
    ylabel('\delta_{sur} (%)');
    %ylabel('$\it{T}_{\mathrm{veg}}$ (K)', 'Interpreter', 'latex');
    if variable_i > 1
        set(gca,'YLabel',[])
        set(gca,'YTickLabel',[])
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
export_fig('../figure/Figure_albedo_impact_aspect_modify.pdf', '-pdf', '-m2', '-painters','-nocrop');

close all

