
setwd("/home/cesam/WRFChem_outputs/NO2/")
dir_NO2 <- "/home/cesam/WRFChem_outputs/NO2/"

# list files
files_NO2 <- list.files(dir_NO2, ".tif$")
# remove files
if (file.exists(files_NO2)) file.remove(files_NO2) 

