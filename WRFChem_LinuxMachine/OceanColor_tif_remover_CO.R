

setwd("/home/cesam/WRFChem_outputs/CO/")
dir_CO <- "/home/cesam/WRFChem_outputs/CO/"

# list files
files_CO <- list.files(dir_CO, ".tif$")
# remove files
if (file.exists(files_CO)) file.remove(files_CO)


