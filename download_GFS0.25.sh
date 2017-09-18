#!/bin/bash

###########################################################################################################################################
main=/home/fkaragulian/WRF_UAE/forcing_data/ ; input_path=${main}/
#date=`date +%Y%m%d` ;
date=$1 ; hh=$2 ; 
DIR=${date}${hh} ; DIRI=${date}${hh}
echo ${DIR} > ${input_path}/timestr00
echo "`date`" > ${input_path}/timestamp

#############################################################################################################################################

#killall -e wget ; 

cd ${input_path} ; mkdir -p ${DIR}


while [ ! -e "${DIR}/gfs.t${hh}z.pgrb2.0p25.f000" ]
do
wget -c  -t 200  -O ${DIR}/gfs.t${hh}z.pgrb2.0p25.f000 "http://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_0p25.pl?file=gfs.t${hh}z.pgrb2.0p25.f000&all_lev=on&all_var=on&subregion=&leftlon=20.00&rightlon=120.00&toplat=40.00&bottomlat=00.00&dir=%2Fgfs.$DIRI" >& ${input_path}/temp01 &
sleep 7
done


while [ ! -e "${DIR}/gfs.t${hh}z.pgrb2.0p25.f006" ]
do
wget -c  -t 200  -O ${DIR}/gfs.t${hh}z.pgrb2.0p25.f006 "http://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_0p25.pl?file=gfs.t${hh}z.pgrb2.0p25.f006&all_lev=on&all_var=on&subregion=&leftlon=20.00&rightlon=120.00&toplat=40.00&bottomlat=00.00&dir=%2Fgfs.$DIRI" >& ${input_path}/temp02 &
sleep 7
done

while [ ! -e "${DIR}/gfs.t${hh}z.pgrb2.0p25.f012" ]
do
wget -c  -t 200  -O ${DIR}/gfs.t${hh}z.pgrb2.0p25.f012 "http://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_0p25.pl?file=gfs.t${hh}z.pgrb2.0p25.f012&all_lev=on&all_var=on&subregion=&leftlon=20.00&rightlon=120.00&toplat=40.00&bottomlat=00.00&dir=%2Fgfs.$DIRI" >& ${input_path}/temp03 &
sleep 7
done

while [ ! -e "${DIR}/gfs.t${hh}z.pgrb2.0p25.f018" ]
do
wget -c  -t 200  -O ${DIR}/gfs.t${hh}z.pgrb2.0p25.f018 "http://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_0p25.pl?file=gfs.t${hh}z.pgrb2.0p25.f018&all_lev=on&all_var=on&subregion=&leftlon=20.00&rightlon=120.00&toplat=40.00&bottomlat=00.00&dir=%2Fgfs.$DIRI" >& ${input_path}/temp04 &
sleep 7
done

while [ ! -e "${DIR}/gfs.t${hh}z.pgrb2.0p25.f024" ]
do
wget -c  -t 200  -O ${DIR}/gfs.t${hh}z.pgrb2.0p25.f024 "http://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_0p25.pl?file=gfs.t${hh}z.pgrb2.0p25.f024&all_lev=on&all_var=on&subregion=&leftlon=20.00&rightlon=120.00&toplat=40.00&bottomlat=00.00&dir=%2Fgfs.$DIRI" >& ${input_path}/temp05 &
sleep 7
done

while [ ! -e "${DIR}/gfs.t${hh}z.pgrb2.0p25.f030" ]
do
wget -c  -t 200  -O ${DIR}/gfs.t${hh}z.pgrb2.0p25.f030 "http://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_0p25.pl?file=gfs.t${hh}z.pgrb2.0p25.f030&all_lev=on&all_var=on&subregion=&leftlon=20.00&rightlon=120.00&toplat=40.00&bottomlat=00.00&dir=%2Fgfs.$DIRI" >& ${input_path}/temp06 &
sleep 7
done

while [ ! -e "${DIR}/gfs.t${hh}z.pgrb2.0p25.f036" ]
do
wget -c  -t 200  -O ${DIR}/gfs.t${hh}z.pgrb2.0p25.f036 "http://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_0p25.pl?file=gfs.t${hh}z.pgrb2.0p25.f036&all_lev=on&all_var=on&subregion=&leftlon=20.00&rightlon=120.00&toplat=40.00&bottomlat=00.00&dir=%2Fgfs.$DIRI" >& ${input_path}/temp07 &
sleep 7
done

while [ ! -e "${DIR}/gfs.t${hh}z.pgrb2.0p25.f042" ]
do
wget -c  -t 200  -O ${DIR}/gfs.t${hh}z.pgrb2.0p25.f042 "http://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_0p25.pl?file=gfs.t${hh}z.pgrb2.0p25.f042&all_lev=on&all_var=on&subregion=&leftlon=20.00&rightlon=120.00&toplat=40.00&bottomlat=00.00&dir=%2Fgfs.$DIRI" >& ${input_path}/temp08 &
sleep 7
done

while [ ! -e "${DIR}/gfs.t${hh}z.pgrb2.0p25.f048" ]
do
wget -c  -t 200  -O ${DIR}/gfs.t${hh}z.pgrb2.0p25.f048 "http://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_0p25.pl?file=gfs.t${hh}z.pgrb2.0p25.f048&all_lev=on&all_var=on&subregion=&leftlon=20.00&rightlon=120.00&toplat=40.00&bottomlat=00.00&dir=%2Fgfs.$DIRI" >& ${input_path}/temp09 &
sleep 7
done

while [ ! -e "${DIR}/gfs.t${hh}z.pgrb2.0p25.f054" ]
do
wget -c  -t 200  -O ${DIR}/gfs.t${hh}z.pgrb2.0p25.f054 "http://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_0p25.pl?file=gfs.t${hh}z.pgrb2.0p25.f054&all_lev=on&all_var=on&subregion=&leftlon=20.00&rightlon=120.00&toplat=40.00&bottomlat=00.00&dir=%2Fgfs.$DIRI" >& ${input_path}/temp10 &
sleep 7
done

while [ ! -e "${DIR}/gfs.t${hh}z.pgrb2.0p25.f060" ]
do
wget -c  -t 200  -O ${DIR}/gfs.t${hh}z.pgrb2.0p25.f060 "http://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_0p25.pl?file=gfs.t${hh}z.pgrb2.0p25.f060&all_lev=on&all_var=on&subregion=&leftlon=20.00&rightlon=120.00&toplat=40.00&bottomlat=00.00&dir=%2Fgfs.$DIRI" >& ${input_path}/temp11 &
sleep 7
done

while [ ! -e "${DIR}/gfs.t${hh}z.pgrb2.0p25.f066" ]
do
wget -c  -t 200  -O ${DIR}/gfs.t${hh}z.pgrb2.0p25.f066 "http://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_0p25.pl?file=gfs.t${hh}z.pgrb2.0p25.f066&all_lev=on&all_var=on&subregion=&leftlon=20.00&rightlon=120.00&toplat=40.00&bottomlat=00.00&dir=%2Fgfs.$DIRI" >& ${input_path}/temp12 &
sleep 7
done

while [ ! -e "${DIR}/gfs.t${hh}z.pgrb2.0p25.f072" ]
do
wget -c  -t 200  -O ${DIR}/gfs.t${hh}z.pgrb2.0p25.f072 "http://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_0p25.pl?file=gfs.t${hh}z.pgrb2.0p25.f072&all_lev=on&all_var=on&subregion=&leftlon=20.00&rightlon=120.00&toplat=40.00&bottomlat=00.00&dir=%2Fgfs.$DIRI" >& ${input_path}/temp13 &
sleep 7
done

while [ ! -e "${DIR}/gfs.t${hh}z.pgrb2.0p25.f078" ]
do
wget -c  -t 200  -O ${DIR}/gfs.t${hh}z.pgrb2.0p25.f078 "http://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_0p25.pl?file=gfs.t${hh}z.pgrb2.0p25.f078&all_lev=on&all_var=on&subregion=&leftlon=20.00&rightlon=120.00&toplat=40.00&bottomlat=00.00&dir=%2Fgfs.$DIRI" >& ${input_path}/temp14 &
sleep 7
done

while [ ! -e "${DIR}/gfs.t${hh}z.pgrb2.0p25.f084" ]
do
wget -c  -t 200  -O ${DIR}/gfs.t${hh}z.pgrb2.0p25.f084 "http://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_0p25.pl?file=gfs.t${hh}z.pgrb2.0p25.f084&all_lev=on&all_var=on&subregion=&leftlon=20.00&rightlon=120.00&toplat=40.00&bottomlat=00.00&dir=%2Fgfs.$DIRI" >& ${input_path}/temp15 &
sleep 7
done

while [ ! -e "${DIR}/gfs.t${hh}z.pgrb2.0p25.f090" ]
do
wget -c  -t 200  -O ${DIR}/gfs.t${hh}z.pgrb2.0p25.f090 "http://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_0p25.pl?file=gfs.t${hh}z.pgrb2.0p25.f090&all_lev=on&all_var=on&subregion=&leftlon=20.00&rightlon=120.00&toplat=40.00&bottomlat=00.00&dir=%2Fgfs.$DIRI" >& ${input_path}/temp16 &
sleep 7
done

while [ ! -e "${DIR}/gfs.t${hh}z.pgrb2.0p25.f096" ]
do
wget -c  -t 200  -O ${DIR}/gfs.t${hh}z.pgrb2.0p25.f096 "http://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_0p25.pl?file=gfs.t${hh}z.pgrb2.0p25.f096&all_lev=on&all_var=on&subregion=&leftlon=20.00&rightlon=120.00&toplat=40.00&bottomlat=00.00&dir=%2Fgfs.$DIRI" >& ${input_path}/temp17 &
sleep 7
done


exit

#######################################################################
while [ ! -e "${DIR}/gfs.t${hh}z.pgrb2.0p25.f102" ]
do
wget -c  -t 200  -O ${DIR}/gfs.t${hh}z.pgrb2.0p25.f102 "http://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_0p25.pl?file=gfs.t${hh}z.pgrb2.0p25.f102&all_lev=on&all_var=on&subregion=&leftlon=20.00&rightlon=120.00&toplat=40.00&bottomlat=00.00&dir=%2Fgfs.$DIRI" >& ${input_path}/temp18 &
sleep 7
done

while [ ! -e "${DIR}/gfs.t${hh}z.pgrb2.0p25.f108" ]
do
wget -c  -t 200  -O ${DIR}/gfs.t${hh}z.pgrb2.0p25.f108 "http://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_0p25.pl?file=gfs.t${hh}z.pgrb2.0p25.f108&all_lev=on&all_var=on&subregion=&leftlon=20.00&rightlon=120.00&toplat=40.00&bottomlat=00.00&dir=%2Fgfs.$DIRI" >& ${input_path}/temp19 &
sleep 7
done

while [ ! -e "${DIR}/gfs.t${hh}z.pgrb2.0p25.f114" ]
do
wget -c  -t 200  -O ${DIR}/gfs.t${hh}z.pgrb2.0p25.f114 "http://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_0p25.pl?file=gfs.t${hh}z.pgrb2.0p25.f114&all_lev=on&all_var=on&subregion=&leftlon=20.00&rightlon=120.00&toplat=40.00&bottomlat=00.00&dir=%2Fgfs.$DIRI" >& ${input_path}/temp20 &
sleep 7
done

while [ ! -e "${DIR}/gfs.t${hh}z.pgrb2.0p25.f120" ]
do
wget -c  -t 200  -O ${DIR}/gfs.t${hh}z.pgrb2.0p25.f120 "http://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_0p25.pl?file=gfs.t${hh}z.pgrb2.0p25.f120&all_lev=on&all_var=on&subregion=&leftlon=20.00&rightlon=120.00&toplat=40.00&bottomlat=00.00&dir=%2Fgfs.$DIRI" >& ${input_path}/temp21 &
sleep 7
done

while [ ! -e "${DIR}/gfs.t${hh}z.pgrb2.0p25.f126" ]
do
wget -c  -t 200  -O ${DIR}/gfs.t${hh}z.pgrb2.0p25.f126 "http://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_0p25.pl?file=gfs.t${hh}z.pgrb2.0p25.f126&all_lev=on&all_var=on&subregion=&leftlon=20.00&rightlon=120.00&toplat=40.00&bottomlat=00.00&dir=%2Fgfs.$DIRI" >& ${input_path}/temp22 &
sleep 7
done

while [ ! -e "${DIR}/gfs.t${hh}z.pgrb2.0p25.f132" ]
do
wget -c  -t 200  -O ${DIR}/gfs.t${hh}z.pgrb2.0p25.f132 "http://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_0p25.pl?file=gfs.t${hh}z.pgrb2.0p25.f132&all_lev=on&all_var=on&subregion=&leftlon=20.00&rightlon=120.00&toplat=40.00&bottomlat=00.00&dir=%2Fgfs.$DIRI" >& ${input_path}/temp23 &
sleep 80
done

while [ ! -e "${DIR}/gfs.t${hh}z.pgrb2.0p25.f138" ]
do
wget -c  -t 200  -O ${DIR}/gfs.t${hh}z.pgrb2.0p25.f138 "http://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_0p25.pl?file=gfs.t${hh}z.pgrb2.0p25.f138&all_lev=on&all_var=on&subregion=&leftlon=20.00&rightlon=120.00&toplat=40.00&bottomlat=00.00&dir=%2Fgfs.$DIRI" >& ${input_path}/temp24 &
sleep 7
done

while [ ! -e "${DIR}/gfs.t${hh}z.pgrb2.0p25.f144" ]
do
wget -c  -t 200  -O ${DIR}/gfs.t${hh}z.pgrb2.0p25.f144 "http://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_0p25.pl?file=gfs.t${hh}z.pgrb2.0p25.f144&all_lev=on&all_var=on&subregion=&leftlon=20.00&rightlon=120.00&toplat=40.00&bottomlat=00.00&dir=%2Fgfs.$DIRI" >& ${input_path}/temp25 &
sleep 7
done

while [ ! -e "${DIR}/gfs.t${hh}z.pgrb2.0p25.f150" ]
do
wget -c  -t 200  -O ${DIR}/gfs.t${hh}z.pgrb2.0p25.f150 "http://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_0p25.pl?file=gfs.t${hh}z.pgrb2.0p25.f150&all_lev=on&all_var=on&subregion=&leftlon=20.00&rightlon=120.00&toplat=40.00&bottomlat=00.00&dir=%2Fgfs.$DIRI" >& ${input_path}/temp26 &
sleep 7
done

while [ ! -e "${DIR}/gfs.t${hh}z.pgrb2.0p25.f156" ]
do
wget -c  -t 200  -O ${DIR}/gfs.t${hh}z.pgrb2.0p25.f156 "http://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_0p25.pl?file=gfs.t${hh}z.pgrb2.0p25.f156&all_lev=on&all_var=on&subregion=&leftlon=20.00&rightlon=120.00&toplat=40.00&bottomlat=00.00&dir=%2Fgfs.$DIRI" >& ${input_path}/temp27 &
sleep 7
done

while [ ! -e "${DIR}/gfs.t${hh}z.pgrb2.0p25.f162" ]
do
wget -c  -t 200  -O ${DIR}/gfs.t${hh}z.pgrb2.0p25.f162 "http://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_0p25.pl?file=gfs.t${hh}z.pgrb2.0p25.f162&all_lev=on&all_var=on&subregion=&leftlon=20.00&rightlon=120.00&toplat=40.00&bottomlat=00.00&dir=%2Fgfs.$DIRI" >& ${input_path}/temp28 &
sleep 7
done

while [ ! -e "${DIR}/gfs.t${hh}z.pgrb2.0p25.f168" ]
do
wget -c  -t 200  -O ${DIR}/gfs.t${hh}z.pgrb2.0p25.f168 "http://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_0p25.pl?file=gfs.t${hh}z.pgrb2.0p25.f168&all_lev=on&all_var=on&subregion=&leftlon=20.00&rightlon=120.00&toplat=40.00&bottomlat=00.00&dir=%2Fgfs.$DIRI" >& ${input_path}/temp29 &
sleep 7
done

while [ ! -e "${DIR}/gfs.t${hh}z.pgrb2.0p25.f174" ]
do
wget -c  -t 200  -O ${DIR}/gfs.t${hh}z.pgrb2.0p25.f174 "http://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_0p25.pl?file=gfs.t${hh}z.pgrb2.0p25.f174&all_lev=on&all_var=on&subregion=&leftlon=20.00&rightlon=120.00&toplat=40.00&bottomlat=00.00&dir=%2Fgfs.$DIRI" >& ${input_path}/temp30 &
sleep 7
done

while [ ! -e "${DIR}/gfs.t${hh}z.pgrb2.0p25.f180" ]
do
wget -c  -t 200  -O ${DIR}/gfs.t${hh}z.pgrb2.0p25.f180 "http://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_0p25.pl?file=gfs.t${hh}z.pgrb2.0p25.f180&all_lev=on&all_var=on&subregion=&leftlon=20.00&rightlon=120.00&toplat=40.00&bottomlat=00.00&dir=%2Fgfs.$DIRI" >& ${input_path}/temp31 &
sleep 7
done

while [ ! -e "${DIR}/gfs.t${hh}z.pgrb2.0p25.f186" ]
do
wget -c  -t 200  -O ${DIR}/gfs.t${hh}z.pgrb2.0p25.f186 "http://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_0p25.pl?file=gfs.t${hh}z.pgrb2.0p25.f186&all_lev=on&all_var=on&subregion=&leftlon=20.00&rightlon=120.00&toplat=40.00&bottomlat=00.00&dir=%2Fgfs.$DIRI" >& ${input_path}/temp32 &
sleep 7
done

while [ ! -e "${DIR}/gfs.t${hh}z.pgrb2.0p25.f192" ]
do
wget -c  -t 200  -O ${DIR}/gfs.t${hh}z.pgrb2.0p25.f192 "http://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_0p25.pl?file=gfs.t${hh}z.pgrb2.0p25.f192&all_lev=on&all_var=on&subregion=&leftlon=20.00&rightlon=120.00&toplat=40.00&bottomlat=00.00&dir=%2Fgfs.$DIRI" >& ${input_path}/temp33 &
sleep 7
done
exit
