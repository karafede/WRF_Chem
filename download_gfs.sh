#!/bin/bash

date_day=20150331
date_month=`date +%Y%m -d$date_day`
hours=( `seq -f%03.0f 0 6 120` )
initial=( 06  ) # 06 00

for i in ${initial[@]}; do
 for h in ${hours[@]}; do
  #ftp://nomads.ncdc.noaa.gov/GFS/Grid4/201603/20160310/
  echo ftp://nomads.ncdc.noaa.gov/GFS/Grid4/$date_month/$date_day/gfs_4_$date_day"_"$i"00"_$h.grb2
  wget -c ftp://nomads.ncdc.noaa.gov/GFS/Grid4/$date_month/$date_day/gfs_4_$date_day"_"$i"00"_$h.grb2
 done
done

