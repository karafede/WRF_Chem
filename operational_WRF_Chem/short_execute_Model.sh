#!/bin/bash -i
## script for automating WRF model
##24/09/2017
#### THIS SCRIPT IS ONLY TO POSTPORCESS wrfpost_d0* FILES WITH R AND TO SYNC THEM TO THE ATLAS-SERVER ###

source /home/fkaragulian/export.sh

#####################################################################################################################
date=`date +%Y%m%d`00
#####################################################################################################################

######################################  Source Env variables ##########################################################

module() { eval `/usr/bin/modulecmd $modules_shell $*`; }
module bash load /usr/share/Modules/modulefiles/PMPI/modulefile /apps/mi-env/modules/gcc/4.9.2 /apps/mi-env/modules/openmpi/1.8.4 /apps/mi-env/modules/ncview/2.1.7

export LC_LIBRARY_PATH=/apps/netcdf/installed/lib
# module load gcc/4.9.2
# module load openmpi/1.8.4
export LC_LIBRARY_PATH=/apps/libpng/libpng-1.4.13/lib:${LD_LIBRARY_PATH}
source "/home/fkaragulian/WRFV3/wrfchem_env.txt"  
export PATH=/apps/cdo/cdo-1.7.2/bin:${PATH}
# module load ncview
export PATH=/apps/ncl/ncl-6.3.0/bin:${PATH}
export NCARG_ROOT=/apps/ncl/ncl-6.3.0/


export LD_LIBRARY_PATH=/shared/ibm/platform_lsf/9.1/linux2.6-glibc2.3-x86_64/lib:$LD_LIBRARY_PATH
export PATH=/shared/ibm/platform_lsf/9.1/linux2.6-glibc2.3-x86_64/bin:$PATH
export LSF_ENVDIR=/shared/ibm/platform_lsf/conf
export LSF_SERVERDIR=/shared/ibm/platform_lsf/9.1/linux2.6-glibc2.3-x86_64/etc

#####################################################################################################################
wrfout=/research/cesam/WRFChem_outputs/${date} 

dir=${wrfout}
cd ${dir}/

# files=wrfout_d0*
# echo ${files}
# for i in ${files[@]}; do
# output=( `echo ${i##*/}|sed 's/wrfout/wrfpost/'`  )
# ncl 'file_in="'$i'"' 'file_out="./'$output'.nc"' /home/fkaragulian/WRF_UAE/scripts/wrfpost_dust_20170927_airquality.ncl
# done

# rm -rf ${wrfout}/wrfout_d0* 


########################################## R scripts to generate .TIFF Files ################################################################################

/apps/R/R-3.3.2/bin/Rscript /home/fkaragulian/WRF_UAE/scripts/nc_WRFChem_post_proc_d01.R ${date}

rsync -avz ${wrfout}/PM10/*.tif pvernier@atlas-prod.minet.ae:/home/pvernier/scripts_cron/forecast_wrf_chem/PM10 
rsync -avz ${wrfout}/PM25/*.tif pvernier@atlas-prod.minet.ae:/home/pvernier/scripts_cron/forecast_wrf_chem/PM25 
rsync -avz ${wrfout}/NO2/*.tif pvernier@atlas-prod.minet.ae:/home/pvernier/scripts_cron/forecast_wrf_chem/NO2 
rsync -avz ${wrfout}/SO2/*.tif pvernier@atlas-prod.minet.ae:/home/pvernier/scripts_cron/forecast_wrf_chem/SO2 
rsync -avz ${wrfout}/CO/*.tif pvernier@atlas-prod.minet.ae:/home/pvernier/scripts_cron/forecast_wrf_chem/CO 
rsync -avz ${wrfout}/O3/*.tif pvernier@atlas-prod.minet.ae:/home/pvernier/scripts_cron/forecast_wrf_chem/O3

rsync -avz ${wrfout}/PM10/*.tif fkaragulian@cesam-uat:/home/pvernier/scripts_cron/forecast_wrf_chem/PM10 
rsync -avz ${wrfout}/PM25/*.tif fkaragulian@cesam-uat:/home/pvernier/scripts_cron/forecast_wrf_chem/PM25 
rsync -avz ${wrfout}/NO2/*.tif fkaragulian@cesam-uat:/home/pvernier/scripts_cron/forecast_wrf_chem/NO2 
rsync -avz ${wrfout}/SO2/*.tif fkaragulian@cesam-uat:/home/pvernier/scripts_cron/forecast_wrf_chem/SO2 
rsync -avz ${wrfout}/CO/*.tif fkaragulian@cesam-uat:/home/pvernier/scripts_cron/forecast_wrf_chem/CO 
rsync -avz ${wrfout}/O3/*.tif fkaragulian@cesam-uat:/home/pvernier/scripts_cron/forecast_wrf_chem/O3

/apps/R/R-3.3.2/bin/Rscript /home/fkaragulian/WRF_UAE/scripts/AQI_WRFChem_HPC.R ${date}
rsync -avz ${wrfout}/AQI/*.tif pvernier@atlas-prod.minet.ae:/home/pvernier/scripts_cron/forecast_wrf_chem/AQI
