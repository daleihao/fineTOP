
export RES=ELM_USRDAT
export COMPSET=IELMBC
export COMPILER=intel
export MACH=compy 
export CASE_NAME=ktop_SN_rad_surf_MODIS_spinup

export domainPath=/compyfs/haod776/e3sm_scratch/kTOP/surfdata/
export domainFile=domain_kTOP_SN_c240628.nc
export surfdataFile=surfdata_kTOP_SN_c240628.nc

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


./xmlchange NTASKS=1024,STOP_N=20,STOP_OPTION=nyears,JOB_WALLCLOCK_TIME="12:00:00",RUN_STARTDATE="1979-01-01",REST_N=10,REST_OPTION=nyears
./xmlchange DATM_MODE="CLMMOSARTTEST",DATM_CLMNCEP_YR_START='1979',DATM_CLMNCEP_YR_END='2020'

cat >> user_nl_elm << EOF
fsurdat = '${domainPath}${surfdataFile}'

hist_empty_htapes = .true.
hist_mfilt = 12
hist_nhtfrq = 0
hist_fincl1 = 'FSA','FSR','FSDS'


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
export CASE_NAME=ktop_SN_rad_nosurf_MODIS_spinup

export domainPath=/compyfs/haod776/e3sm_scratch/kTOP/surfdata/
export domainFile=domain_kTOP_SN_c240628.nc
export surfdataFile=surfdata_kTOP_SN_c240628.nc

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


./xmlchange NTASKS=1024,STOP_N=20,STOP_OPTION=nyears,JOB_WALLCLOCK_TIME="12:00:00",RUN_STARTDATE="1979-01-01",REST_N=10,REST_OPTION=nyears
./xmlchange DATM_MODE="CLMMOSARTTEST",DATM_CLMNCEP_YR_START='1979',DATM_CLMNCEP_YR_END='2020'

cat >> user_nl_elm << EOF
fsurdat = '${domainPath}${surfdataFile}'

hist_empty_htapes = .true.
hist_mfilt = 12
hist_nhtfrq = 0
hist_fincl1 = 'FSA','FSR','FSDS'

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
export CASE_NAME=ktop_SN_default_MODIS_spinup

export domainPath=/compyfs/haod776/e3sm_scratch/kTOP/surfdata/
export domainFile=domain_kTOP_SN_c240628.nc
export surfdataFile=surfdata_kTOP_SN_c240628.nc

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


./xmlchange NTASKS=1024,STOP_N=20,STOP_OPTION=nyears,JOB_WALLCLOCK_TIME="12:00:00",RUN_STARTDATE="1979-01-01",REST_N=10,REST_OPTION=nyears
./xmlchange DATM_MODE="CLMMOSARTTEST",DATM_CLMNCEP_YR_START='1979',DATM_CLMNCEP_YR_END='2020'

cat >> user_nl_elm << EOF
fsurdat = '${domainPath}${surfdataFile}'

hist_empty_htapes = .true.
hist_mfilt = 12
hist_nhtfrq = 0
hist_fincl1 = 'FSA','FSR','FSDS'

use_snicar_ad               = .true.
use_top_solar_rad           = .false.

use_ktop_rad                = .false.
use_ktop_surf               = .false.
EOF

./case.setup
./case.build
echo Build_SUCCESS!
./case.submit

