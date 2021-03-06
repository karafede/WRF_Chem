#!/bin/sh
#set -x
export PATH=/opt/ibm/platform_mpi/bin:/shared/ibm/platform_lsf/9.1/linux2.6-glibc2.3-x86_64/etc:/shared/ibm/platform_lsf/9.1/linux2.6-glibc2.3-x86_64/bin:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/opt/ibutils/bin
#export HOME=/home/fkaragulian
export LSF_SERVERDIR=/shared/ibm/platform_lsf/9.1/linux2.6-glibc2.3-x86_64/etc
export LSF_LIBDIR=/shared/ibm/platform_lsf/9.1/linux2.6-glibc2.3-x86_64/lib
export LSF_VERSION=9.1
export LSF_BINDIR=/shared/ibm/platform_lsf/9.1/linux2.6-glibc2.3-x86_64/bin
export LSF_ENVDIR=/shared/ibm/platform_lsf/conf

#export PATH=/opt/ibm/platform_mpi/bin:/shared/ibm/platform_lsf/9.1/linux2.6-glibc2.3-x86_64/etc:/shared/ibm/platform_lsf/9.1/linux2.6-glibc2.3-x86_64/bin:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/opt/ibutils/bin
#export LSF_SERVERDIR=/shared/ibm/platform_lsf/9.1/linux2.6-glibc2.3-x86_64/etc
#export LSF_LIBDIR=/shared/ibm/platform_lsf/9.1/linux2.6-glibc2.3-x86_64/lib
#export LSF_VERSION=9.1
#export LSF_BINDIR=/shared/ibm/platform_lsf/9.1/linux2.6-glibc2.3-x86_64/bin
#export LSF_ENVDIR=/shared/ibm/platform_lsf/conf


cd /research/cesam/fog/WRF/WRF_UAE/scripts
#which mpirun > error_which_mpirun.log
# General queque
# bsub -n 96 -K -R "span[ptile=24]" -W 6:00 -q general -J WRF_Chm -o WRF_Chm.%J.out -e WRF_Chm.%J.err "/disk3/fkaragulian/WRF_UAE/scripts/execute_Model_lsf.sh 1>/home/fkaragulian/log/chemrun.log 2>/home/fkaragulian/log/chem-error.log"

# reserved nodes
# bsub -n 96 -K -U wrf_chem_00z -R "span[ptile=24]" -W 6:00 -q general -J WRF_Chm -o WRF_Chm.%J.out -e WRF_Chm.%J.err "/disk3/fkaragulian/WRF_UAE/scripts/execute_Model_lsf.sh 1>/home/fkaragulian/log/chemrun.log 2>/home/fkaragulian/log/chem-error.log"

#bsub -n 96 -m haswell -K -R "span[ptile=24]" -W 240 -q general -J WRF_Chm -o WRF_Chm.%J.out -e WRF_Chm.%J.err "/research/cesam/fog/WRF/WRF_UAE/scripts/execute_Model_lsf.sh 1>/research/cesam/AirQuality/log/chemrun.log 2>/research/cesam/AirQuality/log/chem-error.log"

bsub -n 96 -K -R "span[ptile=24]" -W 240 -q high -J WRF_Chm -o WRF_Chm.%J.out -e WRF_Chm.%J.err "/research/cesam/fog/WRF/WRF_UAE/scripts/execute_Model_lsf.sh 1>/research/cesam/AirQuality/log/chemrun.log 2>/research/cesam/AirQuality/log/chem-error.log"


#Post-processing (with NCL and R)
#bsub   -W 180 -q general -J WRF_Chm_Post -o WRF_Chm_Post.%J.out -e WRF_Chm_Post.%J.err /research/cesam/fog/WRF/WRF_UAE/scripts/POSTPROCESSING.sh
bsub  -K  -W 120 -q general -J WRF_Chm_Post -o WRF_Chm_Post.%J.out -e WRF_Chm_Post.%J.err /research/cesam/fog/WRF/WRF_UAE/scripts/POSTPROCESSING_cesam.sh

#bsub -K  -W 360 -q general -J WRF_Chm_Post -o WRF_Chm_Post.%J.out -e WRF_Chm_Post.%J.err /research/cesam/fog/WRF/WRF_UAE/scripts/POSTPROCESSING_recrema.sh

# bsub   -W 1:00 -q general -J WRF_Chm_Post -o WRF_Chm_Post.%J.out -e WRF_Chm_Post.%J.err /disk3/fkaragulian/WRF_UAE/scripts/short_execute_Model.sh


