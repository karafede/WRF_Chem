#!/bin/bash -i
## script for automating WRF model
##24/09/2017
#### THIS SCRIPT IS ONLY TO POSTPORCESS wrfpost_d0* FILES WITH R AND TO SYNC THEM TO THE ATLAS-SERVER ###

source /research/cesam/fog/WRF/WRF_UAE/scripts/export_R.sh

#####################################################################################################################
date=`date +%Y%m%d`00
dest_folder_RECREMA="/research/cesam/AirQuality/WRFChem_test_MW_ifort/RECREMA/"
# previous day date
date_yesterday=`date --date="-1 day" +%Y%m%d`00
#####################################################################################################################

######################################  Source Env variables ##########################################################

#module() { eval `/usr/bin/modulecmd $modules_shell $*`; }
#module bash load /usr/share/Modules/modulefiles/PMPI/modulefile /apps/mi-env/modules/gcc/4.9.2 /apps/mi-env/modules/openmpi/1.8.4 /apps/mi-env/modules/ncview/2.1.7
 
#export LC_LIBRARY_PATH=/apps/netcdf/installed/lib
# module load gcc/4.9.2
# module load openmpi/1.8.4
#export LC_LIBRARY_PATH=/apps/libpng/libpng-1.4.13/lib:${LD_LIBRARY_PATH}
#source "/home/fkaragulian/WRFV3/wrfchem_env.txt"  
#export PATH=/apps/cdo/cdo-1.7.2/bin:${PATH}
# module load ncview
export PATH=/apps/ncl/ncl-6.3.0/bin:${PATH}
export NCARG_ROOT=/apps/ncl/ncl-6.3.0/


#export LD_LIBRARY_PATH=/shared/ibm/platform_lsf/9.1/linux2.6-glibc2.3-x86_64/lib:$LD_LIBRARY_PATH
#export PATH=/shared/ibm/platform_lsf/9.1/linux2.6-glibc2.3-x86_64/bin:$PATH
#export LSF_ENVDIR=/shared/ibm/platform_lsf/conf
#export LSF_SERVERDIR=/shared/ibm/platform_lsf/9.1/linux2.6-glibc2.3-x86_64/etc

########################################### Post Processing (to run for each output hour ##################################################################

wrfout=/research/cesam/AirQuality/WRFChem_test_MW_ifort/${date} 

dir=${wrfout}
cd ${dir}/
files=wrfout_d0*
 echo ${files}
for i in ${files[@]}; do
#break
 output=( `echo ${i##*/}|sed 's/wrfout/wrfpost/'`  )
 #echo file_in is $i 
 #echo file_out is $output 
 #ncl 'file_in="'$i'"' 'file_out="./'$output'.nc"' ./wrfpost_dust_20170927_airquality.ncl
 # ncl 'file_in="'$i'"' 'file_out="./'$output'.nc"' /home/fkaragulian/bin/wrfpost_dust_20170927_airquality.ncl
 ncl 'file_in="'$i'"' 'file_out="./'$output'.nc"' /research/cesam/fog/WRF/WRF_UAE/scripts/wrfpost_dust_20170927_airquality.ncl
done

rm -rf ${wrfout}/wrfout_d0* 


########################################## R scripts to generate .TIFF Files ################################################################################

#/apps/R/R-3.3.2/bin/Rscript /research/cesam/fog/WRF/WRF_UAE/scripts/nc_WRFChem_post_proc_d01_cesam.R ${date}
/apps/R/R-3.3.2/bin/Rscript /research/cesam/fog/WRF/WRF_UAE/scripts/nc_WRFChem_post_proc_d01_cesam_raster_mask.R ${date}
#exit

echo Starting to move yesterdays files
# copy first 24h data from the previous day
/apps/R/R-3.3.2/bin/Rscript /research/cesam/fog/WRF/WRF_UAE/scripts/move_AQ_data_24h_day_before.R ${date} ${date_yesterday} 

echo Starting AQI
# process AQI data
/apps/R/R-3.3.2/bin/Rscript /research/cesam/fog/WRF/WRF_UAE/scripts/AQI_WRFChem_HPC_cesam.R ${date}

echo Starting to remove yesterdays files
#exit
# remove 24h day before .tif files
/apps/R/R-3.3.2/bin/Rscript /research/cesam/fog/WRF/WRF_UAE/scripts/remove_tif_24h_day_before.R ${date}

echo Starting rsync 
# Mike reactivate next two lines
rsync -avz ${wrfout}/AQI/*.tif mjweston@cesam-web-prod:/data/scripts_cron/forecast_wrf_chem/AQI


####################################################################################################################
# Mike activate these again when persmissions are granted
####################################################################################################################
rsync -avz ${wrfout}/PM10/*.tif mjweston@cesam-web-prod:/data/scripts_cron/forecast_wrf_chem/PM10 
rsync -avz ${wrfout}/PM25/*.tif mjweston@cesam-web-prod:/data/scripts_cron/forecast_wrf_chem/PM25 
rsync -avz ${wrfout}/NO2/*.tif mjweston@cesam-web-prod:/data/scripts_cron/forecast_wrf_chem/NO2 
rsync -avz ${wrfout}/SO2/*.tif mjweston@cesam-web-prod:/data/scripts_cron/forecast_wrf_chem/SO2 
rsync -avz ${wrfout}/CO/*.tif mjweston@cesam-web-prod:/data/scripts_cron/forecast_wrf_chem/CO 
rsync -avz ${wrfout}/O3/*.tif mjweston@cesam-web-prod:/data/scripts_cron/forecast_wrf_chem/O3
#
#rsync -avz ${wrfout}/PM10/*.tif mjweston@cesam-web-uat:/data/scripts_cron/forecast_wrf_chem/PM10 
#rsync -avz ${wrfout}/PM25/*.tif mjweston@cesam-web-uat:/data/scripts_cron/forecast_wrf_chem/PM25 
#rsync -avz ${wrfout}/NO2/*.tif mjweston@cesam-web-uat:/data/scripts_cron/forecast_wrf_chem/NO2 
#rsync -avz ${wrfout}/SO2/*.tif mjweston@cesam-web-uat:/data/scripts_cron/forecast_wrf_chem/SO2 
#rsync -avz ${wrfout}/CO/*.tif mjweston@cesam-web-uat:/data/scripts_cron/forecast_wrf_chem/CO 
#rsync -avz ${wrfout}/O3/*.tif mjweston@cesam-web-uat:/data/scripts_cron/forecast_wrf_chem/O3
#
#rsync -avz ${wrfout}/PM10/*.tif mjweston@cesam-web-dev:/data/scripts_cron/forecast_wrf_chem/PM10 
#rsync -avz ${wrfout}/PM25/*.tif mjweston@cesam-web-dev:/data/scripts_cron/forecast_wrf_chem/PM25 
#rsync -avz ${wrfout}/NO2/*.tif mjweston@cesam-web-dev:/data/scripts_cron/forecast_wrf_chem/NO2 
#rsync -avz ${wrfout}/SO2/*.tif mjweston@cesam-web-dev:/data/scripts_cron/forecast_wrf_chem/SO2 
#rsync -avz ${wrfout}/CO/*.tif mjweston@cesam-web-dev:/data/scripts_cron/forecast_wrf_chem/CO 
#rsync -avz ${wrfout}/O3/*.tif mjweston@cesam-web-dev:/data/scripts_cron/forecast_wrf_chem/O3

# copy files to RECREMA server for MOCCAE website
scp ${dest_folder_RECREMA}/PM10/*.tif cesamuser@masdar-stratobus:/data_moccae/weather_aq/CESAM/PM10/
scp ${dest_folder_RECREMA}/PM25/*.tif cesamuser@masdar-stratobus:/data_moccae/weather_aq/CESAM/PM25/
scp ${dest_folder_RECREMA}/NO2/*.tif cesamuser@masdar-stratobus:/data_moccae/weather_aq/CESAM/NO2/
scp ${dest_folder_RECREMA}/SO2/*.tif cesamuser@masdar-stratobus:/data_moccae/weather_aq/CESAM/SO2/
scp ${dest_folder_RECREMA}/CO/*.tif cesamuser@masdar-stratobus:/data_moccae/weather_aq/CESAM/CO/
scp ${dest_folder_RECREMA}/O3/*.tif cesamuser@masdar-stratobus:/data_moccae/weather_aq/CESAM/O3/
scp ${dest_folder_RECREMA}/AQI/*.tif cesamuser@masdar-stratobus:/data_moccae/weather_aq/CESAM/AQI/


# remove files
Rscript /research/cesam/fog/WRF/WRF_UAE/scripts/RECREMA_tif_remover.R

# Up to here
####################################################################################################################




# rm -rf ${wrfout}/wrfpost_d0*  

