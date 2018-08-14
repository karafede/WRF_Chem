#!/bin/bash -i
## script for automating WRF model
##24/09/2017

echo "mpirun is `which mpirun`"
source /research/cesam/fog/WRF/WRF_UAE/scripts/export.sh
echo "mpirun is `which mpirun`"
#####################################################################################################################
main=/research/cesam/fog/WRF/WRF_UAE/ ; scripts=$main/scripts/ ; wrf=$main/WRFV3/test/em_real/ ; wps=$main/WPS/ ; 
input=$main/forcing_data/ ; date=$1 ; 
no_days=3
date=`date +%Y%m%d`00
#####################################################################################################################
cd ${wrf}/
#rm wrfbdy_d01 wrfinput_d0* met_em.d* rsl.* run.*.err run.*.out   
rm wrfbdy_d01 wrfinput_d0*  rsl.* run.*.err run.*.out   
cd ${wps}/
#rm FILE* GRIBFILE* ungrib.log metgrid.log 

#################################### download Data ###################################################################
 mkdir -p ${input}/${date} ; cd ${input}/${date}/

 for i in `seq -f %03.0f 0 6 72`; do

      wget -c  -t 200  -O gfs.t${date:8:2}z.pgrb2.0p25.f$i "http://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_0p25.pl?file=gfs.t${date:8:2}z.pgrb2.0p25.f$i&all_lev=on&all_var=on&subregion=&leftlon=20.00&rightlon=120.00&toplat=40.00&bottomlat=00.00&dir=%2Fgfs.${date}" 
 done

######################################  Source Env variables ##########################################################

module() { eval `/usr/bin/modulecmd $modules_shell $*`; }
#module bash load /usr/share/Modules/modulefiles/PMPI/modulefile /apps/mi-env/modules/gcc/4.9.2 /apps/mi-env/modules/openmpi/1.8.4 /apps/mi-env/modules/ncview/2.1.7

export LC_LIBRARY_PATH=/apps/netcdf/installed/lib
# module load gcc/4.9.2
# module load openmpi/1.8.4
export LC_LIBRARY_PATH=/apps/libpng/libpng-1.4.13/lib:${LD_LIBRARY_PATH}
#source "/home/fkaragulian/WRFV3/wrfchem_env.txt"  
export PATH=/apps/cdo/cdo-1.7.2/bin:${PATH}
# module load ncview
export PATH=/apps/ncl/ncl-6.3.0/bin:${PATH}
export NCARG_ROOT=/apps/ncl/ncl-6.3.0/


export LD_LIBRARY_PATH=/shared/ibm/platform_lsf/9.1/linux2.6-glibc2.3-x86_64/lib:$LD_LIBRARY_PATH
export PATH=/shared/ibm/platform_lsf/9.1/linux2.6-glibc2.3-x86_64/bin:$PATH
export LSF_ENVDIR=/shared/ibm/platform_lsf/conf
export LSF_SERVERDIR=/shared/ibm/platform_lsf/9.1/linux2.6-glibc2.3-x86_64/etc


echo "mpirun is `which mpirun`"
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
echo "WPS  STARTS"
echo "mpirun is `which mpirun`"
for i in 1; do
#break 
############################################
# only when required
#./geogrid.exe
#############################################
./link_grib.csh ${input}/${date}/gfs.t${date:8:10}z.pgrb2.0p25* .
./ungrib.exe >ungrib.log
./metgrid.exe >metgrid.log 
done
echo WPS END""
############################################# WRF#############################################################################
cd ${wrf}
echo "WRF MET STARTS"
# bsub -I -n 6 -J job_name -o run.%J.out -e run.%J.err -q normal mpirun ./real.exe
#bsub -K -n 96 -q general -W 45 -J example -o example.%J.out -e example.J.err "mpirun ./real.exe"
which mpirun > check_which_mpirun.log
mpirun -np 48 ./real.exe

#bsub -n 60 -J job_name -o vk.%J.out -e vk.%J.err -q normal mpirun ./wrf.exe
echo WRF MET END""
############################################# WRF Met Ends ####################################################################
############################################# WRF CHEM ########################################################################
wrf_chem=/research/cesam/fog/WRF/WRF_UAE/WRF_chem_run/WRFV3/test/em_real/ ; an_ems=/research/cesam/fog/WRF/WRF_UAE/ANTHRO/src ; wrf_met=/research/cesam/fog/WRF/WRF_UAE/ANTHRO/metFiles 
db_ems=/research/cesam1/federico-data/EDGAR-HTAP/MOZCART/   ; wes=/research/cesam/fog/WRF/WRF_UAE/WRFV3/wesely
wrfout=/research/cesam/AirQuality/WRFChem_test_MW_ifort/${date} ; mkdir -p ${wrfout}  
##############################################################################################################################

cd ${wrf_chem}

rm rsl.* wrfinput_d0* wrfchemi_* run.*.out run.*.err exo_coldens_d0*
rm rsl.* wrfchemi_* run.*.out run.*.err exo_coldens_d0*

cd ${an_ems}
rm wrfchemi_* 

cd ${wes}
rm exo_coldens_d0*

############################################## Anthro Ems  ###################################################################
cd ${wrf_met}
echo "Anthro Emission Starts"

cp ${wrf}/wrfinput_d01 .
cp namelist.input_d01 namelist.input

cd ${an_ems}
cat <<EOF > ${an_ems}/MOZCART.inp
&CONTROL
 anthro_dir = '${db_ems}'
 wrf_dir    = '${wrf_met}'
 src_file_prefix = 'EDGAR_HTAP_emi_'
 src_file_suffix = '_2010.0.1x0.1.nc'
 src_names = 'CO(28)','NOx(30)','SO2(64)','NH3(17)','BC(12)','OC(12)','PM2.5(1)','PM10(1)',
             'BIGALK(72)','BIGENE(56)','C2H4(28)','C2H5OH(46)','C2H6(30)','CH2O(30)',
             'CH3CHO(44)','CH3COCH3(58)','CH3OH(32)','MEK(72)','TOLUENE(92)','C3H6(42)','C3H8(44)'
 sub_categories  = 'emis_tot'
 cat_var_prefix  = ' '
 serial_output   = .false.
 start_output_time = '2010-${date:4:2}-01_${date:8:2}:00:00'
 stop_output_time  = '2010-${date:4:2}-04_${date:8:2}:00:00' 
 emissions_zdim_stag = 10
 emis_map = 'CO->CO','NO->NOx','SO2->SO2','NH3->NH3','BC(a)->BC','OC(a)->OC','PM_25(a)->PM2.5','PM_10(a)->PM10',
            'BIGALK->BIGALK','BIGENE->BIGENE','C2H4->C2H4','C2H5OH->C2H5OH','C2H6->C2H6',
            'CH2O->CH2O','CH3CHO->CH3CHO','CH3COCH3->CH3COCH3','CH3OH->CH3OH','MEK->MEK',
            'TOLUENE->TOLUENE','C3H6->C3H6','C3H8->C3H8','NO2->0.0*NOx','ISOP->0.0*CO',
            'C10H16->0.0*CO','SULF->0.0*SO2'
/
EOF



# start_output_time = '2010-${date:4:2}-${date:6:2}_${date:8:2}:00:00'
# stop_output_time  = '2010-${ed_date:5:2}-${ed_date:8:2}_${ed_date:11:2}:00:00'

############################################# Domain 01 #######################################################################################
##bsub -I -n 1 -J job_name -o run.%J.out -e run.%J.err -q normal ./anthro_emis < MOZCART.inp > MOZCART_FK.out

ulimit -s unlimited
./anthro_emis < MOZCART.inp > MOZCART_FK.out

 mv wrfchemi_00z_d01 wrfchemi_00z_d01_coarse ; mv wrfchemi_12z_d01 wrfchemi_12z_d01_coarse

cd ${wes}
cat << EOF >${wes}/namelist.input
&control
 wrf_dir = '${wrf_met}'
 domains = 1,
/
EOF

./exo_coldens < namelist.input

mv exo_coldens_d01 exo_coldens_d01_coarse

########################### Domain 02 ############################################################################################################
cd ${wrf_met}
 cp ${wrf}/wrfinput_d02 wrfinput_d01 ; cp namelist.input_d02 namelist.input

cd ${an_ems}
 ./anthro_emis < MOZCART.inp > MOZCART_FK.out

 mv wrfchemi_00z_d01 wrfchemi_00z_d02 ; mv wrfchemi_12z_d01 wrfchemi_12z_d02
 mv wrfchemi_00z_d01_coarse wrfchemi_00z_d01 ; mv wrfchemi_12z_d01_coarse wrfchemi_12z_d01

cd ${wes}
./exo_coldens < namelist.input

mv exo_coldens_d01 exo_coldens_d02 ; mv exo_coldens_d01_coarse exo_coldens_d01

echo "Anthro Emission Ends"
############################################# WRF chem namelists ##############################################################################
echo "WRF Chem Starts"
cd ${scripts}/namescripts/

cat << EOF >${scripts}/namescripts/namelist.input.chem
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
 history_outname                     = '${wrfout}/wrfout_d<domain>_<date>',
EOF
cat ${scripts}/namescripts/namelist.input.chem_tail >>${scripts}/namescripts/namelist.input.chem
cp ${scripts}/namescripts/namelist.input.chem ${wrf_chem}
cp ${scripts}/namescripts/namelist.input.chem ${wrf_chem}/namelist.input
################################################################################################################################################
cd ${wrf_chem}

ln -sf ${an_ems}/wrfchemi_*d0* . ; ln -sf ${wes}/exo_coldens_d0* . ; ln -sf ${wrf}/met_em.d* .

echo "WRF Chem Real Starts"
# bsub -I -n 2 -J chem-real -o run.%J.out -e run.%J.err -q normal mpirun ./real.exe
#bsub -K -n 2 -q general -W 20 -J example -o example.%J.out -e example.J.err "mpirun ./real.exe"
#mpirun -np 48 ./real.exe
ln -sf ${wrf}/wrfinput_d* ./
ln -sf ${wrf}/wrfbdy_d* ./
echo "WRF Chem Real Ends"

# bsub -I -n 96 -J chem-wrf -o vk.%J.out -e vk.%J.err -q normal mpirun ./wrf.exe
#bsub -K -n 96 -q general -W 600 -J example -o example.%J.out -e example.J.err "mpirun ./wrf.exe"
mpirun -np 96 ./wrf.exe

if [ `grep -c SUCCESS rsl.out.0000` -lt 1 ]; then
         echo WRF Chem failed for ${date}
#         /usr/bin/python ${scripts}/sendMail.py "WRF Chem Run failed:$date" 
else
	echo "WRF Chem Ends"
fi

################################################################################################################################################


