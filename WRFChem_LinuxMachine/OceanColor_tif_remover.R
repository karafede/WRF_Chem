
setwd("/home/cesam/WRFChem_outputs/PM10/")
dir_PM10 <- "/home/cesam/WRFChem_outputs/PM10/"

# list files
files_PM10 <- list.files(dir_PM10, ".tif$")
# remove files
if (file.exists(files_PM10)) file.remove(files_PM10) 



setwd("/home/cesam/WRFChem_outputs/PM25/")
dir_PM25 <- "/home/cesam/WRFChem_outputs/PM25/"

# list files
files_PM25 <- list.files(dir_PM25, ".tif$")
# remove files
if (file.exists(files_PM25)) file.remove(files_PM25) 


setwd("/home/cesam/WRFChem_outputs/NO2/")
dir_NO2 <- "/home/cesam/WRFChem_outputs/NO2/"

# list files
files_NO2 <- list.files(dir_NO2, ".tif$")
# remove files
if (file.exists(files_NO2)) file.remove(files_NO2) 


setwd("/home/cesam/WRFChem_outputs/SO2/")
dir_SO2 <- "/home/cesam/WRFChem_outputs/SO2/"

# list files
files_SO2 <- list.files(dir_SO2, ".tif$")
# remove files
if (file.exists(files_SO2)) file.remove(files_SO2) 



setwd("/home/cesam/WRFChem_outputs/CO/")
dir_CO <- "/home/cesam/WRFChem_outputs/CO/"

# list files
files_CO <- list.files(dir_CO, ".tif$")
# remove files
if (file.exists(files_CO)) file.remove(files_CO)




setwd("/home/cesam/WRFChem_outputs/O3/")
dir_O3 <- "/home/cesam/WRFChem_outputs/O3/"

# list files
files_O3 <- list.files(dir_O3, ".tif$")
# remove files
if (file.exists(files_O3)) file.remove(files_O3)



setwd("/home/cesam/WRFChem_outputs/AQI/")
dir_AQI <- "/home/cesam/WRFChem_outputs/AQI/"

# list files
files_AQI <- list.files(dir_AQI, ".tif$")
# remove files
if (file.exists(files_AQI)) file.remove(files_AQI)





