
setwd("/home/cesam/WRFChem_outputs/AQI/")
dir_AQI <- "/home/cesam/WRFChem_outputs/AQI/"

# list files
files_AQI <- list.files(dir_AQI, ".tif$")
# remove files
if (file.exists(files_AQI)) file.remove(files_AQI)





