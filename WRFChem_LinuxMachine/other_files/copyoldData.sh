#!/bin/bash

cd /research/cesam/WRFChem_outputs/ ; 

c_date=$1 ; y_date=`date -d"${c_date:0:8} -1 days" +%Y%m%d`00


mkdir -p ${c_date}/PM25
mkdir -p ${c_date}/CO
mkdir -p ${c_date}/NO2
mkdir -p ${c_date}/O3
mkdir -p ${c_date}/PM10
mkdir -p ${c_date}/SO2

for (( ii=0 ; ii<73 ; ii++ )) ; do 
 	c_date1=`date -d"${c_date:0:8} $ii hours" +%Y_%m_%d_%H` ; echo $c_date1
 	y_date1=`date -d"${y_date:0:8} $ii hours" +%Y_%m_%d_%H` ; echo $y_date1
 
        cp ${y_date}/PM25/${y_date1}.tif  ${c_date}/PM25/${c_date1}.tif
        cp ${y_date}/CO/${y_date1}.tif  ${c_date}/CO/${c_date1}.tif
        cp ${y_date}/NO2/${y_date1}.tif  ${c_date}/NO2/${c_date1}.tif
        cp ${y_date}/O3/${y_date1}.tif  ${c_date}/O3/${c_date1}.tif
        cp ${y_date}/PM10/${y_date1}.tif  ${c_date}/PM10/${c_date1}.tif
        cp ${y_date}/SO2/${y_date1}.tif  ${c_date}/SO2/${c_date1}.tif

done

exit










