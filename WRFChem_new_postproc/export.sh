

#export PATH=/apps/gcc/gcc-4.9.2/bin:/apps/R/R-3.3.2/bin:/apps/readline/readline-6.3/bin:/apps/ncurses/ncurses-5.9/bin:/apps/m4/m4-1.4.17/bin:/apps/libtool/libtool-2.4.2/bin:/apps/autoconf/autoconf-2.69/bin:/apps/automake/automake-1.15/bin:/apps/numactl/numactl-2.0.10/bin:/apps/hwloc/hwloc-1.10.0/bin:/apps/openmpi/openmpi-1.8.4/bin:/apps/fftw/fftw-3.3.4/bin::/apps/ssl/openssl-1.0.2/bin:/apps/curl/curl-7.37.1/bin:/apps/ncurses/ncurses-5.9/bin:/apps/flex/flex-2.5.39/bin:/apps/bison/bison-3.0.2/bin:/apps/hdf5/hdf5-1.8.13/bin:/apps/cmake/cmake-3.0.0/bin:/apps/doxygen/doxygen-1.8.7/bin:/apps/xz/xz-5.2.2/bin:/apps/bzip2/bzip2-1.0.6/bin:/apps/readline/readline-6.3/bin:/apps/pcre/pcre-8.38/bin:/apps/libjpeg/jpeg-9/bin:/apps/libpng/libpng-1.4.13/bin:apps/netcdf/netcdf-4.3.2/bin:/apps/geos/geos-3.6.0/bin:/apps/proj/proj-4.9.3/bin:/apps/udunits/udunits-2.2.20/bin:$PATH
#:/home/fkaragulian/gdal/gdal-2.1.2/bin:/home/fkaragulian/FWtools/FWTools-2.0.6/bin:/apps/geos/geos-3.6.0/bin:/apps/proj/proj-4.9.3/bin:/apps/udunits/udunits-2.2.20/bin:$PATH

#export LD_LIBRARY_PATH=/apps/gcc/gcc-4.9.2/lib64:/apps/gcc/gcc-4.9.2/lib:/apps/R/R-3.3.2/lib64/R/lib:/apps/readline/readline-6.3/lib:/apps/ncurses/ncurses-5.9/lib:/apps/R/R-3.3.2/lib64:/apps/libtool/libtool-2.4.2/lib:/apps/lapack/lapack-3.5.0-meep:/apps/blas/BLAS-3.5.0-meep:/apps/numactl/numactl-2.0.10/lib:/apps/hwloc/hwloc-1.10.0/lib:/apps/openmpi/openmpi-1.8.4/lib:/apps/fftw/fftw-3.3.4/lib:/apps/scalapack/scalapack-2.0.2:/apps/ssl/openssl-1.0.2/lib:/apps/curl/curl-7.37.1/lib:/apps/szip/szip-2.1/lib:/apps/zlib/zlib-1.2.8/lib:/apps/ncurses/ncurses-5.9/lib:/apps/flex/flex-2.5.39/lib:/apps/bison/bison-3.0.2/lib:/apps/hdf5/hdf5-1.8.13/lib:/apps/xz/xz-5.2.2/lib:/apps/bzip2/bzip2-1.0.6/lib:/apps/zlib/zlib-1.2.8/lib:/apps/readline/readline-6.3/lib:/apps/pcre/pcre-8.38/lib:/apps/libjpeg/jpeg-9/lib:/apps/libpng/libpng-1.4.13/lib:/apps/geos/geos-3.6.0/lib:/apps/proj/proj-4.9.3/lib:/apps/udunits/udunits-2.2.20/lib:$LD_LIBRARY_PATH
#:/apps/netcdf/netcdf-4.3.2/lib:/home/fkaragulian/gdal/gdal-2.1.2/lib:/home/fkaragulian/FWtools/FWTools-2.0.6/lib:/apps/geos/geos-3.6.0/lib:/apps/proj/proj-4.9.3/lib:/apps/udunits/udunits-2.2.20/lib:$LD_LIBRARY_PATH


#export LIBRARY_PATH=/apps/R/R-3.3.2/lib64/R/lib:$LIBRARY_PATH
#export MANPATH=/apps/R/R-3.3.2/share/man:$MANPATH
#export FPATH=/apps/R/R-3.3.2/lib64/R/include:$FPATH
#export CPATH=/apps/R/R-3.3.2/lib64/R/include:$CPATH
#export BLAS=/apps/blas/BLAS-3.5.0-meep/librefblas.a
#export LAPACK=/apps/lapack/lapack-3.5.0-meep/liblapack.a
#export SCALAPACKLIB=/apps/scalapack/scalapack-2.0.2/libscalapack.a
#export PKG_CONFIG_PATH=/apps/curl/curl-7.37.1/lib/pkgconfig:$PKG_CONFIG_PATH

# Mike R env
#export LD_LIBRARY_PATH=/apps/gcc/gcc-4.9.2/lib64:/apps/gcc/gcc-4.9.2/lib:/apps/sublime/sublime-2.0.2/lib:/apps/python/python-3.6.0/lib #:/shared/ibm/platform_lsf/9.1/linux2.6-glibc2.3-x86_64/lib

#export PATH=/apps/gcc/gcc-4.9.2/bin:/apps/geos/geos-3.6.0/bin:/apps/R/R-3.3.2/bin:$PATH
#export LD_LIBRARY_PATH=/apps/R/R-3.3.2/lib64/R/lib:$LD_LIBRARY_PATH
#export LIBRARY_PATH=/apps/geos/geos-3.6.0/lib:/apps/R/R-3.3.2/lib64/R/lib:$LIBRARY_PATH
#export MANPATH=/apps/R/R-3.3.2/share/man:$MANPATH
#export FPATH=/apps/R/R-3.3.2/lib64/R/include:$FPATH
#export CPATH=/apps/R/R-3.3.2/lib64/R/include:$CPATH
#module load gcc/4.9.2
#module load gdal/2.1.2
#module load proj/4.9.3
## need png-devel
#module load libpng/1.4.13
#module load R/3.3.2


# Mike from HPC for intel 2015 compile of WRF
module load gcc/4.9.2
module load flex/2.5.39
module load bison/3.0.2
module load intel/v3
module load hdf5/1.8.16-intel2015
module load netcdf/fortran-4.4.3-intel2015
module load netcdf/c-4.4.0-intel2015
module load parallel-netcdf/1.7.0-intel2015
module load jasper/1.900.1-intel2015
module load libpng/1.2.50-intel2015
module load zlib/1.2.7-intel2015

export CC=icc
export CXX=icpc
export FC=ifort


export EM_CORE=1
export WRF_CHEM=1
export WRF_KPP=1
export BUFR=1
export CRTM=1


export DM_FC=mpiifort
export DM_CC=mpiicc

export PHDF5=/apps/hdf5/hdf5-1.8.16-intel2015
export NETCDF=/apps/netcdf/netcdf-fortran-4.4.3-intel2015
export PNETCDF=/apps/parallel-netcdf/parallel-netcdf-1.7.0-intel2015
export JASPERLIB=/apps/jasper/jasper-1.900.1-intel2015/lib
export JASPERINC=/apps/jasper/jasper-1.900.1-intel2015/include
export FLEX_LIB_DIR=/apps/flex/flex-2.5.39/lib
export YACC='/apps/bison/bison-3.0.2/bin/yacc -d'


export WRFIO_NCD_LARGE_FILE_SUPPORT=1


