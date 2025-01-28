
clc;
clear all;
close all;

Bias_MADs = nan(11,20);

variables = {'FSDS','FSA','FLDS','FIRA','Rnet','TV','t_rad_grc','FSH','EFLX_LH_TOT','FSNO','H2OSNO'};

for i=1:11
    Bias_MADs(i,:) = calculate_Bias_MAD_TOP(variables{i});
end
