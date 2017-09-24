#!/bin/bash
## script for automating WRF model
##24/09/2017
#####################################################################################################################
main=/home/fkaragulian/WRF_UAE/ ; scripts=$main/scripts/ ; wrf=$main/WRFV3/test/em_real/ ; wps=$main/WPS/ ; 
input=$main/forcing_data/ ; date=$1 ; no_days=3

#################################### download Data ###################################################################
mkdir -p ${input}/${date} ; cd ${input}/${date}/

#for i in `seq -f %03.0f 0 6 72`; do

#wget -c  -t 200  -O gfs.t${date:8:2}z.pgrb2.0p25.f$i "http://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_0p25.pl?file=gfs.t${date:8:2}z.pgrb2.0p25.f$i&all_lev=on&all_var=on&subregion=&leftlon=20.00&rightlon=120.00&toplat=40.00&bottomlat=00.00&dir=%2Fgfs.${date}" 
#done

######################################  Source Env variables ##########################################################

export LC_LIBRARY_PATH=/apps/netcdf/installed/lib
module load gcc/4.9.2
module load openmpi/1.8.4
export LC_LIBRARY_PATH=/apps/libpng/libpng-1.4.13/lib:$LD_LIBRARY_PATH
source "/home/fkaragulian/WRFV3/wrfchem_env.txt"  
export PATH=/apps/cdo/cdo-1.7.2/bin:$PATH
module load ncview
export PATH=/apps/ncl/ncl-6.3.0/bin:$PATH
export NCARG_ROOT=/apps/ncl/ncl-6.3.0/

############################################Set up namelist ################################################################
cd ${scripts}/namescripts/
st_date=${date:0:4}-${date:4:2}-${date:6:2}_${date:8:2}:00:00
ed_date=`date -d"${date:0:8} + ${no_days} days" +%Y-%m-%d_${date:8:2}:00:00`

echo $st_date ; echo $ed_date

cat << EOF >${scripts}/namescripts/namelist.wps
&share
wrf_core = 'ARW',
max_dom = 2,
start_date = '${st_date}','${st_date}',
end_date   = '${ed_date}','${ed_date}'
interval_seconds = 21600
io_form_geogrid = 2,
/
EOF
cat ${scripts}/namescripts/namelist.wps_tail >>${scripts}/namescripts/namelist.wps
cp ${scripts}/namescripts/namelist.wps ${wps} 

cat << EOF >${scripts}/namescripts/namelist.input
&time_control
 start_year                          = ${date:0:4}, ${date:0:4},${date:0:4}
 start_month                         = ${date:4:2}, ${date:4:2},${date:4:2}
 start_day                           = ${date:6:2}, ${date:6:2},${date:6:2}
 start_hour                          = ${date:8:2}, ${date:8:2},${date:8:2}
 start_minute                        = 00,   00,   00,
 start_second                        = 00,   00,   00,
 end_year                            = ${ed_date:0:4},${ed_date:0:4},${ed_date:0:4}
 end_month                           = ${ed_date:5:2},${ed_date:5:2},${ed_date:5:2}
 end_day                             = ${ed_date:8:2},${ed_date:8:2},${ed_date:8:2}
 end_hour                            = ${ed_date:11:2},${ed_date:11:2},${ed_date:11:2}
 end_minute                          = 00,   00,   00,
 end_second                          = 00,   00,   00,
EOF
cat ${scripts}/namescripts/namelist.input_tail >>${scripts}/namescripts/namelist.input
cp ${scripts}/namescripts/namelist.input ${wrf}

############################################ WPS #############################################################################
cd ${wps}

#./geogrid.exe
#./link_grib.csh ${input}/${date}/gfs.t${date:8:10}z.pgrb2.0p25* .
#./ungrib.exe >ungrib.log
#./metgrid.exe >metgrid.log 

############################################# WRF#############################################################################
cd ${wrf}
bsub -I -n 2 -J job_name -o run.%J.out -e run.%J.err -q normal mpirun ./real.exe

#bsub -n 60 -J job_name -o vk.%J.out -e vk.%J.err -q normal mpirun ./wrf.exe

exit














