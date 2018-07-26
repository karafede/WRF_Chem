

setwd("/home/cesam/WRFChem_outputs/PM25/")
dir_PM25 <- "/home/cesam/WRFChem_outputs/PM25/"

# list files
files_PM25 <- list.files(dir_PM25, ".tif$")
# remove files
if (file.exists(files_PM25)) file.remove(files_PM25) 

