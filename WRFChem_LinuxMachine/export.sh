#!/bin/bash
export PATH=/data/software/ncl/bin:/data/models/WRF/wrf_libraries/flex/installed_2.5.3/bin:/data/models/WRF/wrf_libraries/netcdf/local/bin:/data/models/WRF/wrf_libraries/libpng/installed/bin:/data/models/WRF/wrf_libraries/jpeg/installed/bin:/data/models/WRF/wrf_libraries/flex/installed/bin:/data/models/WRF/wrf_libraries/byacc/installed/bin:/data/models/WRF/wrf_libraries/hdf5/installed/bin:/data/models/WRF/wrf_libraries/mpich/installed/bin:$PATH

export LD_LIBRARY_PATH=/data/models/WRF/wrf_libraries/netcdf/local/lib:/data/models/WRF/wrf_libraries/libpng/installed/lib:/data/models/WRF/wrf_libraries/jpeg/installed/lib:/data/models/WRF/wrf_libraries/flex/installed/lib:/data/models/WRF/wrf_libraries/hdf5/installed/lib:/data/models/WRF/wrf_libraries/mpich/installed/lib:/data/models/WRF/wrf_libraries/zlib/installed/lib:/data/models/WRF/wrf_libraries/szip/installed/lib:$LD_LIBRARY_PATH

export YACC='/data/models/WRF/wrf_libraries/byacc/installed/bin/yacc -d'

export NETCDF=/data/models/WRF/wrf_libraries/netcdf/local/
export JASPERLIB=/data/models/WRF/wrf_libraries/jasper/installed/lib
export JASPERINC=/data/models/WRF/wrf_libraries/jasper/installed/include

export WRF_CHEM=1
export EM_CORE=1
export WRF_KPP=1
export WRFIO_NCD_LARGE_FILE_SUPPORT=1

#export FLEX_LIB_DIR=/data/models/WRF/wrf_libraries/flex/installed/lib
export FLEX_LIB_DIR=/data/models/WRF/wrf_libraries/flex/installed_2.5.3/lib
#export FLEX=/data/models/WRF/wrf_libraries/flex/installed/bin/flex
export FLEX=/data/models/WRF/wrf_libraries/flex/installed_2.5.3/bin/flex
