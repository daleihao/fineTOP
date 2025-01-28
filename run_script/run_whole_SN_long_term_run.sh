
export RES=ELM_USRDAT
export COMPSET=IELMBC
export COMPILER=intel
export MACH=compy 
export CASE_NAME=ktop_SN_rad_surf_MODIS_run

export domainPath=/compyfs/haod776/e3sm_scratch/kTOP/surfdata/
export domainFile=domain_kTOP_SN_c240628.nc
export surfdataFile=surfdata_kTOP_SN_c240628.nc
export initPath=/compyfs/haod776/e3sm_scratch/kTOP/ELM_simulations/ktop_SN_rad_surf_MODIS_spinup/run/
export initFile=ktop_SN_rad_surf_MODIS_spinup.elm.r.1999-01-01-00000.nc

export output_dir=/compyfs/haod776/e3sm_scratch/kTOP/ELM_simulations
export case_dir=/$output_dir/$CASE_NAME
export case_scripts_dir=/$case_dir/case_scripts

if [ -d "$case_dir" ]; then
# Take action if $DIR exists. #
echo "Delete the old folder"
rm -rf $case_dir
fi

cd /qfs/people/haod776/E3SMv3/cime/scripts/
./create_newcase --compset ${COMPSET} --res ${RES} --case ${CASE_NAME} --script-root $case_scripts_dir --output-root ${output_dir} --compiler ${COMPILER} --mach ${MACH} --project ESMD   
cd ${case_scripts_dir}

./xmlchange LND_DOMAIN_FILE=${domainFile} 
./xmlchange ATM_DOMAIN_FILE=${domainFile} 
./xmlchange LND_DOMAIN_PATH=${domainPath}
./xmlchange ATM_DOMAIN_PATH=${domainPath}


./xmlchange NTASKS=1024,STOP_N=22,STOP_OPTION=nyears,JOB_WALLCLOCK_TIME="12:00:00",RUN_STARTDATE="1999-01-01",REST_N=10,REST_OPTION=nyears
./xmlchange DATM_MODE="CLMMOSARTTEST",DATM_CLMNCEP_YR_START='1979',DATM_CLMNCEP_YR_END='2019'

cat >> user_nl_elm << EOF
fsurdat = '${domainPath}${surfdataFile}'
finidat = '${initPath}${initFile}'

hist_empty_htapes = .true.
hist_mfilt = 12
hist_nhtfrq = 0
hist_fincl1 = 'ALBD','ALBI','ALBGRD','ALBGRI','FSA','FSR','FSDS','FSDSND','FSDSNI','FSDSVD','FSDSVI','FLDS','FIRE','FIRA','FSH','EFLX_LH_TOT','FSNO','SNOWDP','H2OSNO','QSNOMELT','QRUNOFF','QOVER','FPSN','SZA','SAA','COSINC','F_SHORT_DIR','F_SHORT_DIF','F_SHORT_REFL','F_LONG_DIF','F_LONG_REFL','COSZEN','COSINC2','TV','Tair','TG','RAIN','SNOW','RH','BTRAN','H2OSOI','SOILWATER_10CM','TSOI_10CM','TSOI','forc_solad_grc_pp','forc_solai_grc_pp','SWdown_PP','LWdown_PP','SWdown','LWdown','t_rad_grc','t_rad_grc_MODIS_daytime','t_rad_grc_MODIS_nighttime','FSNO_MODIS'



use_snicar_ad               = .true.
use_top_solar_rad           = .false.

use_ktop_rad                = .true.
use_ktop_surf               = .true.
EOF

./case.setup 
./case.build 
echo Build_SUCCESS!
./case.submit


############################
############################
############################
export RES=ELM_USRDAT
export COMPSET=IELMBC
export COMPILER=intel
export MACH=compy
export CASE_NAME=ktop_SN_rad_nosurf_MODIS_run

export domainPath=/compyfs/haod776/e3sm_scratch/kTOP/surfdata/
export domainFile=domain_kTOP_SN_c240628.nc
export surfdataFile=surfdata_kTOP_SN_c240628.nc
export initPath=/compyfs/haod776/e3sm_scratch/kTOP/ELM_simulations/ktop_SN_rad_nosurf_MODIS_spinup/run/
export initFile=ktop_SN_rad_nosurf_MODIS_spinup.elm.r.1999-01-01-00000.nc

export output_dir=/compyfs/haod776/e3sm_scratch/kTOP/ELM_simulations
export case_dir=/$output_dir/$CASE_NAME
export case_scripts_dir=/$case_dir/case_scripts

if [ -d "$case_dir" ]; then
# Take action if $DIR exists. #
echo "Delete the old folder"
rm -rf $case_dir
fi

cd /qfs/people/haod776/E3SMv3/cime/scripts/
./create_newcase --compset ${COMPSET} --res ${RES} --case ${CASE_NAME} --script-root $case_scripts_dir --output-root ${output_dir} --compiler ${COMPILER} --mach ${MACH} --project ESMD
cd ${case_scripts_dir}

./xmlchange LND_DOMAIN_FILE=${domainFile}
./xmlchange ATM_DOMAIN_FILE=${domainFile}
./xmlchange LND_DOMAIN_PATH=${domainPath}
./xmlchange ATM_DOMAIN_PATH=${domainPath}


./xmlchange NTASKS=1024,STOP_N=22,STOP_OPTION=nyears,JOB_WALLCLOCK_TIME="12:00:00",RUN_STARTDATE="1999-01-01",REST_N=10,REST_OPTION=nyears
./xmlchange DATM_MODE="CLMMOSARTTEST",DATM_CLMNCEP_YR_START='1979',DATM_CLMNCEP_YR_END='2019'

cat >> user_nl_elm << EOF
fsurdat = '${domainPath}${surfdataFile}'
finidat = '${initPath}${initFile}'

hist_empty_htapes = .true.
hist_mfilt = 12
hist_nhtfrq = 0
hist_fincl1 = 'ALBD','ALBI','ALBGRD','ALBGRI','FSA','FSR','FSDS','FSDSND','FSDSNI','FSDSVD','FSDSVI','FLDS','FIRE','FIRA','FSH','EFLX_LH_TOT','FSNO','SNOWDP','H2OSNO','QSNOMELT','QRUNOFF','QOVER','FPSN','SZA','SAA','COSINC','F_SHORT_DIR','F_SHORT_DIF','F_SHORT_REFL','F_LONG_DIF','F_LONG_REFL','COSZEN','COSINC2','TV','Tair','TG','RAIN','SNOW','RH','BTRAN','H2OSOI','SOILWATER_10CM','TSOI_10CM','TSOI','forc_solad_grc_pp','forc_solai_grc_pp','SWdown_PP','LWdown_PP','SWdown','LWdown','t_rad_grc','t_rad_grc_MODIS_daytime','t_rad_grc_MODIS_nighttime','FSNO_MODIS'


use_snicar_ad               = .true.
use_top_solar_rad           = .false.

use_ktop_rad                = .true.
use_ktop_surf               = .false.
EOF

./case.setup
./case.build
echo Build_SUCCESS!
./case.submit


############################
############################
############################

export RES=ELM_USRDAT
export COMPSET=IELMBC
export COMPILER=intel
export MACH=compy
export CASE_NAME=ktop_SN_default_MODIS_run

export domainPath=/compyfs/haod776/e3sm_scratch/kTOP/surfdata/
export domainFile=domain_kTOP_SN_c240628.nc
export surfdataFile=surfdata_kTOP_SN_c240628.nc
export initPath=/compyfs/haod776/e3sm_scratch/kTOP/ELM_simulations/ktop_SN_default_MODIS_spinup/run/
export initFile=ktop_SN_default_MODIS_spinup.elm.r.1999-01-01-00000.nc

export output_dir=/compyfs/haod776/e3sm_scratch/kTOP/ELM_simulations
export case_dir=/$output_dir/$CASE_NAME
export case_scripts_dir=/$case_dir/case_scripts

if [ -d "$case_dir" ]; then
# Take action if $DIR exists. #
echo "Delete the old folder"
rm -rf $case_dir
fi

cd /qfs/people/haod776/E3SMv3/cime/scripts/
./create_newcase --compset ${COMPSET} --res ${RES} --case ${CASE_NAME} --script-root $case_scripts_dir --output-root ${output_dir} --compiler ${COMPILER} --mach ${MACH} --project E3SM
cd ${case_scripts_dir}

./xmlchange LND_DOMAIN_FILE=${domainFile}
./xmlchange ATM_DOMAIN_FILE=${domainFile}
./xmlchange LND_DOMAIN_PATH=${domainPath}
./xmlchange ATM_DOMAIN_PATH=${domainPath}


./xmlchange NTASKS=1024,STOP_N=22,STOP_OPTION=nyears,JOB_WALLCLOCK_TIME="12:00:00",RUN_STARTDATE="1999-01-01",REST_N=10,REST_OPTION=nyears
./xmlchange DATM_MODE="CLMMOSARTTEST",DATM_CLMNCEP_YR_START='1979',DATM_CLMNCEP_YR_END='2019'

cat >> user_nl_elm << EOF
fsurdat = '${domainPath}${surfdataFile}'
finidat = '${initPath}${initFile}'

hist_empty_htapes = .true.
hist_mfilt = 12
hist_nhtfrq = 0
hist_fincl1 = 'ALBD','ALBI','ALBGRD','ALBGRI','FSA','FSR','FSDS','FSDSND','FSDSNI','FSDSVD','FSDSVI','FLDS','FIRE','FIRA','FSH','EFLX_LH_TOT','FSNO','SNOWDP','H2OSNO','QSNOMELT','QRUNOFF','QOVER','FPSN','TV','Tair','TG','RAIN','SNOW','RH','BTRAN','H2OSOI','SOILWATER_10CM','TSOI_10CM','TSOI','SWdown','LWdown','t_rad_grc','t_rad_grc_MODIS_daytime','t_rad_grc_MODIS_nighttime','FSNO_MODIS'


use_snicar_ad               = .true.
use_top_solar_rad           = .false.

use_ktop_rad                = .false.
use_ktop_surf               = .false.
EOF

./case.setup
./case.build
echo Build_SUCCESS!
./case.submit

