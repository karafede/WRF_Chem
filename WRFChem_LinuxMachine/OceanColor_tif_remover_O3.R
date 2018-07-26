

setwd("/home/cesam/WRFChem_outputs/O3/")
dir_O3 <- "/home/cesam/WRFChem_outputs/O3/"

# list files
files_O3 <- list.files(dir_O3, ".tif$")
# remove files
if (file.exists(files_O3)) file.remove(files_O3)





