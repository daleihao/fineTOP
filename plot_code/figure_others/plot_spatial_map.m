function plot_spatial_map(lats, lons, sw_total, min_clr, max_clr, title_text, isxticklabel, isyticklabel,num_label)
axis equal

m_proj('miller','lat',[34.8 42.2],'lon',[-123.2 -117.5]); % robinson Mollweide

%m_coast('color','k','linewidth',1);
hold on

if isyticklabel && isxticklabel
    m_grid('tickdir','out','linestyle','none','backcolor',[.9 .99 1], ...
        'fontsize',15,'tickstyle','dd','xtick',4,'ytick',4);
elseif isyticklabel && ~isxticklabel
    m_grid('tickdir','out','linestyle','none','backcolor',[.9 .99 1], 'xticklabels',[], ...
        'fontsize',15,'tickstyle','dd','xtick',4,'ytick',4);
elseif ~isyticklabel && isxticklabel
    m_grid('tickdir','out','linestyle','none','backcolor',[.9 .99 1], 'yticklabels',[], ...
        'fontsize',15,'tickstyle','dd','xtick',4,'ytick',4);
else
    m_grid('tickdir','out','linestyle','none','backcolor',[.9 .99 1], 'xticklabels',[], 'yticklabels',[], ...
        'fontsize',15,'tickstyle','dd','xtick',4,'ytick',4);
end


%%
% load('elevations_TP.mat');
% sw_total(elevations<=1500 | isnan(elevations)) = nan;

m_pcolor(lons,lats,sw_total);

filename = '/Users/haod776/Documents/work/km_topography/study_region/shp/Sierra_Nevada';
gages_bounary = m_shaperead(filename);

tmp = gages_bounary.ncst;
for k=1:length(tmp)
    tmp_2 = tmp{k};
    basin_plot = m_line(tmp_2(:,1),tmp_2(:,2),'color','k','linewidth',1);
    %alpha(gage_plot, 0.5)
end


shading flat;
caxis([min_clr-1e-5,max_clr+1e-5])
%colormap(m_colmap('jet','step',10));
m_text(-118.5,42,['(' num_label ')'],'fontsize',20,'fontweight','bold');
%colorbar
%colormap(colors_single);

if title_text ~= ""
    t = title(title_text,'fontsize',12, 'fontweight', 'bold');
    set(t, 'horizontalAlignment', 'left');
    set(t, 'units', 'normalized');
    h1 = get(t, 'position');
    set(t, 'position', [0 h1(2) h1(3)]);
end

set(gca, 'FontName', 'Time New Roman','FontSize',18);

view(0,90);
hold off