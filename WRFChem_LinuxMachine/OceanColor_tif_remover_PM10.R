
setwd("/home/cesam/WRFChem_outputs/PM10/")
dir_PM10 <- "/home/cesam/WRFChem_outputs/PM10/"

# list files
files_PM10 <- list.files(dir_PM10, ".tif$")
# remove files
if (file.exists(files_PM10)) file.remove(files_PM10) 

