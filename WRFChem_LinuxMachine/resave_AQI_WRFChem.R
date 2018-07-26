
library(raster)
library(dplyr)
library(rgdal)
library(stringr)
library(lubridate)
library(RNetCDF)
library(ncdf4)
library(gstat)


# set daily working directory
date <- commandArgs(trailingOnly = TRUE)
date

time <- Sys.time()
year <- year <- str_sub(time, start = 0, end = -16)
month <- str_sub(time, start = 6, end = -13)
day <- str_sub(time, start = 9, end = -10)

# folder_day <- paste0(year,month, day,"00")    # "2018071800"

folder_day <- date

# folder_day <- "2018071800"
setwd(paste0("/research/cesam/WRFChem_outputs/", folder_day, "/AQI"))


output_dir <- "/home/cesam/WRFChem_outputs/AQI"
sample_raster_HPC <- raster("/home/cesam/WRF_UAE/scripts/sample_raster_HPC.tif")

filenames_AQI <- list.files(pattern = ".tif$")

# filenames_AQI <- filenames_AQI[1:10]

i <- 2

for (i in 1:length(filenames_AQI)) {
  
  year <- str_sub(filenames_AQI[i], start = 0, end = -18)
  month <- str_sub(filenames_AQI[i], start = 6, end = -15)
  day <- str_sub(filenames_AQI[i], start = 9, end = -12)
  time <- str_sub(filenames_AQI[i], start = 12, end = -9)
  DateTime <- paste0(year,"_",month,"_", day,"_",time)
  
  r <- raster(filenames_AQI[i])

  # r <- crop(r, extent(shp_UAE))
  # r <- mask(r, shp_UAE)
  r <- projectRaster(r, sample_raster_HPC)
  writeRaster(r, paste0(output_dir,"/",DateTime, "_AQI.tif") , options= "INTERLEAVE=BAND", overwrite=T)
  
}



