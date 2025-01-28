#!/bin/bash

# Define the variable prefixes to iterate through
variable_prefixes=(
  ktop_SN_rad_surf_MODIS_run
  ktop_SN_rad_nosurf_MODIS_run
  ktop_SN_default_MODIS_run
)

# Iterate through each variable prefix
for variable_prefix in "${variable_prefixes[@]}"; do
  # Change directory to the specific run directory
  cd "/compyfs/haod776/e3sm_scratch/kTOP/ELM_simulations/${variable_prefix}/run"

  # Set the output file name
  output_file="/compyfs/haod776/e3sm_scratch/kTOP/multi_year_average/${variable_prefix}_multi_year_average.nc"

  # Execute ncea command with input files
  ncea \
    ${variable_prefix}.elm.h0.2001-02-01-00000.nc \
    ${variable_prefix}.elm.h0.2002-02-01-00000.nc \
    ${variable_prefix}.elm.h0.2003-02-01-00000.nc \
    ${variable_prefix}.elm.h0.2004-02-01-00000.nc \
    ${variable_prefix}.elm.h0.2005-02-01-00000.nc \
    ${variable_prefix}.elm.h0.2006-02-01-00000.nc \
    ${variable_prefix}.elm.h0.2007-02-01-00000.nc \
    ${variable_prefix}.elm.h0.2008-02-01-00000.nc \
    ${variable_prefix}.elm.h0.2009-02-01-00000.nc \
    ${variable_prefix}.elm.h0.2010-02-01-00000.nc \
    ${variable_prefix}.elm.h0.2011-02-01-00000.nc \
    ${variable_prefix}.elm.h0.2012-02-01-00000.nc \
    ${variable_prefix}.elm.h0.2013-02-01-00000.nc \
    ${variable_prefix}.elm.h0.2014-02-01-00000.nc \
    ${variable_prefix}.elm.h0.2015-02-01-00000.nc \
    ${variable_prefix}.elm.h0.2016-02-01-00000.nc \
    ${variable_prefix}.elm.h0.2017-02-01-00000.nc \
    ${variable_prefix}.elm.h0.2018-02-01-00000.nc \
    ${variable_prefix}.elm.h0.2019-02-01-00000.nc \
    ${output_file}
done



# Define the variable prefixes to iterate through
variable_prefixes=(
  ktop_SN_rad_nolw_nosurf_MODIS_run
)

# Iterate through each variable prefix
for variable_prefix in "${variable_prefixes[@]}"; do
  # Change directory to the specific run directory
  cd "/compyfs/haod776/e3sm_scratch/kTOP/ELM_simulations/${variable_prefix}/run"

  # Set the output file name
  output_file="/compyfs/haod776/e3sm_scratch/kTOP/multi_year_average/${variable_prefix}_multi_year_average.nc"

  # Execute ncea command with input files
  ncea \
    ${variable_prefix}.elm.h0.2001-02-01-00000.nc \
    ${variable_prefix}.elm.h0.2002-02-01-00000.nc \
    ${variable_prefix}.elm.h0.2003-02-01-00000.nc \
    ${variable_prefix}.elm.h0.2004-02-01-00000.nc \
    ${variable_prefix}.elm.h0.2005-02-01-00000.nc \
    ${variable_prefix}.elm.h0.2006-02-01-00000.nc \
    ${variable_prefix}.elm.h0.2007-02-01-00000.nc \
    ${variable_prefix}.elm.h0.2008-02-01-00000.nc \
    ${variable_prefix}.elm.h0.2009-02-01-00000.nc \
    ${variable_prefix}.elm.h0.2010-02-01-00000.nc \
    ${variable_prefix}.elm.h0.2011-02-01-00000.nc \
    ${variable_prefix}.elm.h0.2012-02-01-00000.nc \
    ${variable_prefix}.elm.h0.2013-02-01-00000.nc \
    ${variable_prefix}.elm.h0.2014-02-01-00000.nc \
    ${variable_prefix}.elm.h0.2015-02-01-00000.nc \
    ${variable_prefix}.elm.h0.2016-02-01-00000.nc \
    ${variable_prefix}.elm.h0.2017-02-01-00000.nc \
    ${variable_prefix}.elm.h0.2018-02-01-00000.nc \
    ${variable_prefix}.elm.h0.2019-02-01-00000.nc \
    ${output_file}
done





module load nco

# Define the variable prefixes to iterate through
variable_prefixes=(
  old_top_SN_MODIS_run
)

# Iterate through each variable prefix
for variable_prefix in "${variable_prefixes[@]}"; do
  # Change directory to the specific run directory
  cd "/compyfs/haod776/e3sm_scratch/kTOP/ELM_simulations/${variable_prefix}/run"

  # Set the output file name
  output_file="/compyfs/haod776/e3sm_scratch/kTOP/multi_year_average/${variable_prefix}_multi_year_average.nc"

  # Execute ncea command with input files
  ncea \
    ${variable_prefix}.elm.h0.2001-02-01-00000.nc \
    ${variable_prefix}.elm.h0.2002-02-01-00000.nc \
    ${variable_prefix}.elm.h0.2003-02-01-00000.nc \
    ${variable_prefix}.elm.h0.2004-02-01-00000.nc \
    ${variable_prefix}.elm.h0.2005-02-01-00000.nc \
    ${variable_prefix}.elm.h0.2006-02-01-00000.nc \
    ${variable_prefix}.elm.h0.2007-02-01-00000.nc \
    ${variable_prefix}.elm.h0.2008-02-01-00000.nc \
    ${variable_prefix}.elm.h0.2009-02-01-00000.nc \
    ${variable_prefix}.elm.h0.2010-02-01-00000.nc \
    ${variable_prefix}.elm.h0.2011-02-01-00000.nc \
    ${variable_prefix}.elm.h0.2012-02-01-00000.nc \
    ${variable_prefix}.elm.h0.2013-02-01-00000.nc \
    ${variable_prefix}.elm.h0.2014-02-01-00000.nc \
    ${variable_prefix}.elm.h0.2015-02-01-00000.nc \
    ${variable_prefix}.elm.h0.2016-02-01-00000.nc \
    ${variable_prefix}.elm.h0.2017-02-01-00000.nc \
    ${variable_prefix}.elm.h0.2018-02-01-00000.nc \
    ${variable_prefix}.elm.h0.2019-02-01-00000.nc \
    ${output_file}
done
