
setwd("/research/cesam/AirQuality/WRFChem_test_MW_ifort/RECREMA/PM10/")
dir_PM10 <- "/research/cesam/AirQuality/WRFChem_test_MW_ifort/RECREMA/PM10/"

# list files
files_PM10 <- list.files(dir_PM10, ".tif$")
# remove files
if (file.exists(files_PM10)) file.remove(files_PM10) 



setwd("/research/cesam/AirQuality/WRFChem_test_MW_ifort/RECREMA/PM25/")
dir_PM25 <- "/research/cesam/AirQuality/WRFChem_test_MW_ifort/RECREMA/PM25/"

# list files
files_PM25 <- list.files(dir_PM25, ".tif$")
# remove files
if (file.exists(files_PM25)) file.remove(files_PM25) 


setwd("/research/cesam/AirQuality/WRFChem_test_MW_ifort/RECREMA/NO2/")
dir_NO2 <- "/research/cesam/AirQuality/WRFChem_test_MW_ifort/RECREMA/NO2/"

# list files
files_NO2 <- list.files(dir_NO2, ".tif$")
# remove files
if (file.exists(files_NO2)) file.remove(files_NO2) 


setwd("/research/cesam/AirQuality/WRFChem_test_MW_ifort/RECREMA/SO2/")
dir_SO2 <- "/research/cesam/AirQuality/WRFChem_test_MW_ifort/RECREMA/SO2/"

# list files
files_SO2 <- list.files(dir_SO2, ".tif$")
# remove files
if (file.exists(files_SO2)) file.remove(files_SO2) 



setwd("/research/cesam/AirQuality/WRFChem_test_MW_ifort/RECREMA/CO/")
dir_CO <- "/research/cesam/AirQuality/WRFChem_test_MW_ifort/RECREMA/CO/"

# list files
files_CO <- list.files(dir_CO, ".tif$")
# remove files
if (file.exists(files_CO)) file.remove(files_CO)




setwd("/research/cesam/AirQuality/WRFChem_test_MW_ifort/RECREMA/O3/")
dir_O3 <- "/research/cesam/AirQuality/WRFChem_test_MW_ifort/RECREMA/O3/"

# list files
files_O3 <- list.files(dir_O3, ".tif$")
# remove files
if (file.exists(files_O3)) file.remove(files_O3)



setwd("/research/cesam/AirQuality/WRFChem_test_MW_ifort/RECREMA/AQI/")
dir_AQI <- "/research/cesam/AirQuality/WRFChem_test_MW_ifort/RECREMA/AQI/"

# list files
files_AQI <- list.files(dir_AQI, ".tif$")
# remove files
if (file.exists(files_AQI)) file.remove(files_AQI)





