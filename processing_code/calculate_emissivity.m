clc;
clear all;
close all;


%% load LAI
load("../study_region/surfdata/LAISAI_1km.mat");
load("../study_region/surfdata/kTOP_factors.mat");
load("../study_region/surfdata/mask_SN.mat");

LAIs = nan([size(LAI_1_Data), 12]);
LAIs(:,:,1) = LAI_1_Data;
LAIs(:,:,2) = LAI_2_Data;
LAIs(:,:,3) = LAI_3_Data;
LAIs(:,:,4) = LAI_4_Data;
LAIs(:,:,5) = LAI_5_Data;
LAIs(:,:,6) = LAI_6_Data;
LAIs(:,:,7) = LAI_7_Data;
LAIs(:,:,8) = LAI_8_Data;
LAIs(:,:,9) = LAI_9_Data;
LAIs(:,:,10) = LAI_10_Data;
LAIs(:,:,11) = LAI_11_Data;
LAIs(:,:,12) = LAI_12_Data;

SAIs = nan([size(SAI_1_Data), 12]);
SAIs(:,:,1) = SAI_1_Data;
SAIs(:,:,2) = SAI_2_Data;
SAIs(:,:,3) = SAI_3_Data;
SAIs(:,:,4) = SAI_4_Data;
SAIs(:,:,5) = SAI_5_Data;
SAIs(:,:,6) = SAI_6_Data;
SAIs(:,:,7) = SAI_7_Data;
SAIs(:,:,8) = SAI_8_Data;
SAIs(:,:,9) = SAI_9_Data;
SAIs(:,:,10) = SAI_10_Data;
SAIs(:,:,11) = SAI_11_Data;
SAIs(:,:,12) = SAI_12_Data;

slopes = repmat(slope, [1, 1, 12]);
inSNs = repmat(inSN, [1, 1, 12]);
EVF_flat = 1-exp(-(LAIs+SAIs));
EVF_kTOP = 1-exp(-((LAIs+SAIs).*cos(slopes*pi/180)));

EVF_dif = EVF_kTOP - EVF_flat;

EVF_dif(~inSNs) = nan;
%% diff
EVI_dif_mean = mean(EVF_dif, [3],'omitnan'); 

imagesc(EVI_dif_mean,[-0.1 0 ])