

setwd("/home/cesam/WRFChem_outputs/SO2/")
dir_SO2 <- "/home/cesam/WRFChem_outputs/SO2/"

# list files
files_SO2 <- list.files(dir_SO2, ".tif$")
# remove files
if (file.exists(files_SO2)) file.remove(files_SO2) 

