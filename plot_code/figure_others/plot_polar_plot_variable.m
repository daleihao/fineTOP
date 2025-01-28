function plot_polar_plot_variable(variables, maxvalue, title_text)

load('kTOP_factors.mat');


dif_variable = variables;

Pdata = nan(8,17);
for slope_i = 0:5:30
    row_i = round(slope_i/5)+2;
    for aspect_i = 0:22.5:(360-22.5)
        col_j = round(aspect_i/22.5)+1;
        filters = slope>=slope_i & slope< (slope_i+5) & aspect >= aspect_i & aspect< (aspect_i+22.5);

        tmp = dif_variable(filters);
        Pdata(row_i,col_j) = mean(tmp(:),'omitnan');
    end
end

Pdata(:,end) = Pdata(:,1); 
Pdata(1,:) = Pdata(2,:); 

R = 0:5:35; % (distance in km)
Az = linspace(0,360,17); % in degrees

pos = [0:5:35]; % Distance of the different circles from the origin
ncolor = 21;
Rticks = {'0°','5°','10°','15°','20°','25°','30°','35°'};

%% ,'colBar',0

[~,c]= polarPcolor(R,Az,Pdata,'Nspokes',9,'circlesPos',pos,'ncolor',ncolor,'colormap','hot','Rticklabel',Rticks,'autoOrigin','off');
colors = brewermap(21,'RdBu');
colormap(colors);
caxis([-maxvalue maxvalue]);
%shading interp
ylabel(c,title_text); %% 'FSDS (W/m^2)'
set(gcf,'color','w')