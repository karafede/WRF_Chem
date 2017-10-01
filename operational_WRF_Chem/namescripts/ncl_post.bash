#!/bin/bash
######################################  Source Env variables ##########################################################
export LC_LIBRARY_PATH=/apps/netcdf/installed/lib
module load gcc/4.9.2
module load openmpi/1.8.4
export LC_LIBRARY_PATH=/apps/libpng/libpng-1.4.13/lib:${LD_LIBRARY_PATH}
source "/home/fkaragulian/WRFV3/wrfchem_env.txt"  
export PATH=/apps/cdo/cdo-1.7.2/bin:${PATH}
module load ncview
export PATH=/apps/ncl/ncl-6.3.0/bin:${PATH}
export NCARG_ROOT=/apps/ncl/ncl-6.3.0/
#######################################################################################################################

dir=/research/cesam/AirQuality/WRF_outputs/2017100100_WRF_output
cd ${dir}/
files=wrfout_d0*
 echo ${files}
for i in ${files[@]}; do
 output=( `echo ${i##*/}|sed 's/wrfout/wrfpost/'`  )
 #echo file_in is $i 
 #echo file_out is $output 
 #ncl 'file_in="'$i'"' 'file_out="./'$output'.nc"' ./wrfpost_dust_20170927_airquality.ncl
 ncl 'file_in="'$i'"' 'file_out="./'$output'.nc"' /home/fkaragulian/bin/wrfpost_dust_20170927_airquality.ncl
 done
