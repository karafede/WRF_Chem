
# set daily working directory
date <- commandArgs(trailingOnly = TRUE)

folder_day <- date

# folder_day <- "2018051400"
setwd(paste0("/research/cesam/WRFChem_outputs/", folder_day, "/AQI"))
dir_AQI <- paste0("/research/cesam/WRFChem_outputs/", folder_day, "/AQI")


# list files
files_AQI <- list.files(dir_AQI, ".tif$")
# remove files
if (file.exists(files_AQI)) file.remove(files_AQI) 