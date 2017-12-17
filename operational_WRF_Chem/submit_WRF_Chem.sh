#!/bin/sh
#set -x
export PATH=/opt/ibm/platform_mpi/bin:/shared/ibm/platform_lsf/9.1/linux2.6-glibc2.3-x86_64/etc:/shared/ibm/platform_lsf/9.1/linux2.6-glibc2.3-x86_64/bin:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/opt/ibutils/bin
export HOME=/home/fkaragulian
export LSF_SERVERDIR=/shared/ibm/platform_lsf/9.1/linux2.6-glibc2.3-x86_64/etc
export LSF_LIBDIR=/shared/ibm/platform_lsf/9.1/linux2.6-glibc2.3-x86_64/lib
export LSF_VERSION=9.1
export LSF_BINDIR=/shared/ibm/platform_lsf/9.1/linux2.6-glibc2.3-x86_64/bin
export LSF_ENVDIR=/shared/ibm/platform_lsf/conf
cd /disk3/fkaragulian/WRF_UAE/scripts/
# General queque
# bsub -n 96 -K -R "span[ptile=24]" -W 6:00 -q general -J WRF_Chm -o WRF_Chm.%J.out -e WRF_Chm.%J.err "/disk3/fkaragulian/WRF_UAE/scripts/execute_Model_lsf.sh 1>/home/fkaragulian/log/chemrun.log 2>/home/fkaragulian/log/chem-error.log"

# reserved nodes
bsub -n 96 -K -U wrf_chem_00z -R "span[ptile=24]" -W 6:00 -q general -J WRF_Chm -o WRF_Chm.%J.out -e WRF_Chm.%J.err "/disk3/fkaragulian/WRF_UAE/scripts/execute_Model_lsf.sh 1>/home/fkaragulian/log/chemrun.log 2>/home/fkaragulian/log/chem-error.log"

#Post-processing (with NCL and R)
 bsub   -W 1:00 -q general -J WRF_Chm_Post -o WRF_Chm_Post.%J.out -e WRF_Chm_Post.%J.err /disk3/fkaragulian/WRF_UAE/scripts/POSTPROCESSING.sh
# bsub   -W 1:00 -q general -J WRF_Chm_Post -o WRF_Chm_Post.%J.out -e WRF_Chm_Post.%J.err /disk3/fkaragulian/WRF_UAE/scripts/short_execute_Model.sh


