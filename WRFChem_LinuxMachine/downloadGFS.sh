#!/bin/bash
export GFS_DONE=NO
unset ALL_GFS_DONE
#base_dir="/home/mtemimi/WRF/WRF_parallel_mpi_fog_hpcNov2017_downloadGFS_config/"
today=( `date +"%Y%m%d"` )
start_hour=( `date +"%T"` )
end_hour=( `date +"%T" -d "+2 hours" ` )
fhour=( 00 )
forecast_time=(000 006 012 018 024 030 036 042 048 054 060 066 072 078 084 090 096);
(( index_length= ${#forecast_time[@]} - 1 ))
forecast_time2=(102 108 114 120);

config=meteo_forecast/downloadGFS

#datafiledirect=200610
#cd $base_dir

###############################################################
##check the new listing for the Global Forecast System output 
###############################################################

#curl -o datalisting.log -O http://nomads.ncep.noaa.gov/pub/data/nccf/com/gfs/prod/
#grep "gfs.2" datalisting.log >& datalisting1.log
#last=`wc -l datalisting1.log |head -c 3`
#line=$((last-4 ))
##line=$last
#echo $line
#sed -n "${line},${line}p" datalisting1.log >& datalisting2.log
##i=`grep gfs datalisting2.log|tail -c -15`
#i=`grep gfs datalisting2.log|tail -c -71| head -c 14`
#echo $i
#newdata=$i;
#datadirectory1=$i;
#datadirectory=wrf.$today$fhour
datadirectory1=gfs.$today$fhour
#forecast_hour=`grep gfs datalisting2.log|tail -c -3`
#forecast_hour=`grep gfs datalisting2.log|head -c 23| tail -c -2`
forecast_hour=$fhour

ADIRECTORY=/research/cesam/$config/Datafog/$datadirectory1

mkdir -p /research/cesam/$config/Datafog/$datadirectory1
cd /research/cesam/$config/Datafog/$datadirectory1


for I in  `echo ${forecast_time[@]}`; do
loop=0
 while [ $loop -lt 1 ] ; do 
  echo $I
  s=`printf "%01d""${I#0}"`
  ###dataname=gfs.t"$forecast_hour"z.pgrb2.0p50.f"$s"
  dataname=gfs.t"$forecast_hour"z.pgrb2.0p25.f"$s"
  echo ${dataname}
  ####wget   ftp://ftp.ncep.noaa.gov/pub/data/nccf/com/gfs/prod/$datadirectory1/${dataname}
  ###wget   http://nomads.ncep.noaa.gov/pub/data/nccf/com/gfs/prod/$datadirectory1/${dataname}
  ###wget -c -O ${dataname} "http://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_0p50.pl?file=gfs.t"$forecast_hour"z.pgrb2full.0p50.f$s&all_lev=on&all_var=on&subregion=&leftlon=20.00&rightlon=120.00&toplat=40.00&bottomlat=00.00&dir=%2F$datadirectory1"
  
  # Check if the gfs file is greater than 28MB. If not, download. If yes, do nothing.
  if [ -e ${dataname} ]; then
   file_complete=( `find ${dataname} -size +28M`  )
  else
   file_complete=""
  fi

  nextfile=0
  #while [ $nextfile -lt 1 ]; do
   if [ -n "$file_complete"  ]; then
    loop=1
    #nextfile=1
    echo ""
    #continue 
   else
    rm ${dataname}
    wget -c -O ${dataname} "http://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_0p25.pl?file=gfs.t"$forecast_hour"z.pgrb2.0p25.f$s&all_lev=on&all_var=on&subregion=&leftlon=20.00&rightlon=120.00&toplat=40.00&bottomlat=00.00&dir=%2F$datadirectory1"
   fi
  #done
  # Check inf the last forecast time has been downloaded. If yes, set env variable that can be used to activate WRF.
 
  echo "Is the last file there?"
  last_file_ready=( `find gfs.t$forecast_hour"z".pgrb2.0p25.f${forecast_time[${index_length}]} -size +28M` )
  if [ -n "$last_file_ready" ] ; then
   echo "Last file is ready"
   export GFS_DONE=YES
   # Do a final check that all files have been downloaded to full size.
   all_file_ready=( `find gfs.t* -size +28M|wc -l` )
   if (( $all_file_ready == ${#forecast_time[@]}  )) ; then 
    export ALL_GFS_DONE=YES
    newdata=$datadirectory1
    export config newdata forecast_hour ADIRECTORY datadirectory1 #base_dir  
    #datadirectory base_dir
    loop=1
    echo "Running WRF now"
    #$base_dir/Mainrunwrfog.sh
   else
    #missing_files=( `find gfs.t* -size -28M` )
    #for miss in ${missing_files[@]}; do 
    # wget -c -O ${dataname} "http://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_0p25.pl?file=gfs.t"$forecast_hour"z.pgrb2.0p25.f$s&all_lev=on&all_var=on&subregion=&leftlon=20.00&rightlon=120.00&toplat=40.00&bottomlat=00.00&dir=%2F$datadirectory1"
    #done

    timestamp=( `date +%T` )
    start_t=( `date +%T -d "-5 minutes ${end_hour[@]}"` )  #"15:55:00"
    end=( `date +%T -d "+5 minutes ${end_hour[@]}"` )      #"16:05:00"
    echo $start_t $end
    if [[ "$timestamp" == "$start_t" ||
          "$timestamp" >  "$start_t" && "$timestamp" <  "$end" ||
                                      "$timestamp" == "$end" ]] ; then
     echo "Incomplete GFS download"
     #python $base_dir/sendmail_wrffail.py "WRF fail: Incomplete GFS download"
     exit
    else
     sleep 300
    fi
   fi
  else
   echo "last file is not ready"
   loop=0
  fi
  
  if [ -n "$file_complete"  ]; then
   loop=1
  else
   loop=0
   sleep 180
  fi

 done
done
