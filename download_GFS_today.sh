#!/bin/bash

###########################################################################################################################################
# main=/home/mike/masdar/models/gfs/ ; input_path=${main}/input/
main=/home/fkaragulian/WRF_UAE/forcing_data/ ; input_path=${main}/input/
date=`date +%Y%m%d` ; DIR=${date} ; DIRI=${date}00
west=( 20 )
east=( 64  )
north=( 40  )
south=( 08 )
#date=$1 ; DIR=${date} ; DIRI=${date}00
echo ${DIR} > ${input_path}/timestr00
echo "`date`" > ${input_path}/timestamp
#############################################################################################################################################

#killall -e wget ; 

#mkdir -p ${main}/${input_path}
cd ${main}/${input_path} ; mkdir -p ${DIR}


#while [ ! -e "${DIR}/gfs.t00z.pgrb2full.0p50.f000" ]
#do

for i in `seq -f %03.0f 0 6 72`; do 

 #wget -c    -O ${DIR}/gfs.t00z.pgrb2full.0p50.f$i "http://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_0p50.pl?file=gfs.t00z.pgrb2full.0p50.f$i&all_lev=on&all_var=on&subregion=&leftlon=20.00&rightlon=120.00&toplat=40.00&bottomlat=00.00&lev_10_m_above_ground=on&var_UGRD=on&var_VGRD=on&dir=%2Fgfs.$DIRI" > ${input_path}/temp01 
 wget -c    -O ${DIR}/gfs.t00z.pgrb2full.0p50.f$i "http://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_0p50.pl?file=gfs.t00z.pgrb2full.0p50.f$i&all_lev=on&all_var=on&subregion=&leftlon=${west}.00&rightlon=${east}.00&toplat=${north}.00&bottomlat=${south}.00&lev_10_m_above_ground=on&var_UGRD=on&var_VGRD=on&dir=%2Fgfs.$DIRI" > ${input_path}/temp01 
#sleep 15
done




#echo "`date`" >> ${input_path}/timestamp
#exit
