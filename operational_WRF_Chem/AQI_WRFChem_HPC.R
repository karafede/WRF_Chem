
library(raster)
library(dplyr)
library(rgdal)
library(stringr)
library(lubridate)
library(RNetCDF)
library(ncdf4)
library(gstat)


# load function to calculate Air Quality Indexes
# source("Z:/_SHARED_FOLDERS/Air Quality/Phase 2/AQ_TIDY_Data/Scripts/aqi_fun_UAE.R")
source("/disk3/fkaragulian/WRF_UAE/scripts/aqi_fun_UAE.R")

# load function to find the Pollutant with the maximum AQI
# source("Z:/_SHARED_FOLDERS/Air Quality/Phase 2/AQ_TIDY_Data/Scripts/max_AQI_fun.R")
source("/disk3/fkaragulian/WRF_UAE/scripts/max_AQI_fun.R")

dir <- "/disk3/fkaragulian/WRF_UAE/scripts/UAE_boundary"
### shapefile for UAE
shp_UAE <- readOGR(dsn = dir, layer = "uae_emirates")

# ----- Transform to EPSG 4326 - WGS84 (required)
shp_UAE <- spTransform(shp_UAE, CRS("+init=epsg:4326"))

# set daily working directory
date <- commandArgs(trailingOnly = TRUE)
date
time <- Sys.time()
year <- year <- str_sub(time, start = 0, end = -16)
month <- str_sub(time, start = 6, end = -13)
day <- str_sub(time, start = 9, end = -10)

# folder_day <- paste0(year,month, day,"00")    # "2017120400"

folder_day <- date
# folder_day <- "2018043000"
setwd(paste0("/research/cesam/WRFChem_outputs/", folder_day))
# setwd("Z:/_SHARED_FOLDERS/Air Quality/Phase 2/AQI_WRFChem")

# create directory fro AQI
dir.create("AQI")
current_dir <- getwd()
output_dir <- paste0(current_dir, "/AQI")

dir_PM25 <- paste0(current_dir, "/PM25/")
dir_PM10 <- paste0(current_dir, "/PM10/")
dir_CO <- paste0(current_dir, "/CO/")
dir_NO2 <- paste0(current_dir, "/NO2/")
dir_O3 <- paste0(current_dir, "/O3/")
dir_SO2 <- paste0(current_dir, "/SO2/")

# list all tif files for each pollutant generated from WRF_Chem
filenames_PM25 <- list.files(path = dir_PM25, pattern = ".tif$")
filenames_PM10 <- list.files(path = dir_PM10, pattern = ".tif$")
filenames_CO <- list.files(path = dir_CO, pattern = ".tif$")
filenames_NO2 <- list.files(path = dir_NO2, pattern = ".tif$")
filenames_SO2 <- list.files(path = dir_SO2, pattern = ".tif$")
filenames_O3 <- list.files(path = dir_O3, pattern = ".tif$")

### Extract points from raster tiff ############################################
i <-3 
 
for(i in 1:length(filenames_PM25)) {
# for(i in 1:5) {

# create name for each file    
year <- str_sub(filenames_PM25[i], start = 0, end = -14)
month <- str_sub(filenames_PM25[i], start = 6, end = -11)
day <- str_sub(filenames_PM25[i], start = 9, end = -8)
time <- str_sub(filenames_PM25[i], start = 12, end = -5)
DateTime <- paste0(year,"_",month,"_", day,"_",time)

# PM2.5   
r_PM25 <- raster(paste0(dir_PM25,"/", filenames_PM25[i]))  
r_pts_PM25 <- rasterToPoints(r_PM25)
colnames(r_pts_PM25) <- c("Lon", "Lat", "PM25_1km")
r_pts_PM25 <- as.data.frame(r_pts_PM25) 
# r_pts_PM25 <- subset(r_pts_PM25, !is.na(PM25_1km) & PM25_1km>0)
PM25_data <- as.vector(r_pts_PM25$PM25_1km)
PM25_data <- round(PM25_data, digits = 0)
PM25_data <- as.numeric(PM25_data)


# PM10
r_PM10 <- raster(paste0(dir_PM10,"/", filenames_PM10[i]))  
r_pts_PM10 <- rasterToPoints(r_PM10)
colnames(r_pts_PM10) <- c("Lon", "Lat", "PM10_1km")
r_pts_PM10 <- as.data.frame(r_pts_PM10) 
PM10_data <- as.vector(r_pts_PM10$PM10_1km)
PM10_data <- round(PM10_data, digits = 0)
PM10_data <- as.numeric(PM10_data)


# CO
r_CO <- raster(paste0(dir_CO,"/", filenames_CO[i]))  
r_pts_CO <- rasterToPoints(r_CO)
colnames(r_pts_CO) <- c("Lon", "Lat", "CO_1km")
r_pts_CO <- as.data.frame(r_pts_CO) 
CO_data <- as.vector(r_pts_CO$CO_1km)
CO_data <- round(CO_data, digits = 0)
CO_data <- as.numeric(CO_data)


# NO2
r_NO2 <- raster(paste0(dir_NO2,"/", filenames_NO2[i]))  
r_pts_NO2 <- rasterToPoints(r_NO2)
colnames(r_pts_NO2) <- c("Lon", "Lat", "NO2_1km")
r_pts_NO2 <- as.data.frame(r_pts_NO2) 
NO2_data <- as.vector(r_pts_NO2$NO2_1km)
NO2_data <- round(NO2_data, digits = 0)
NO2_data <- as.numeric(NO2_data)

# SO2
r_SO2 <- raster(paste0(dir_SO2,"/", filenames_SO2[i]))   
r_pts_SO2 <- rasterToPoints(r_SO2)
colnames(r_pts_SO2) <- c("Lon", "Lat", "SO2_1km")
r_pts_SO2 <- as.data.frame(r_pts_SO2) 
SO2_data <- as.vector(r_pts_SO2$SO2_1km)
SO2_data <- round(SO2_data, digits = 0)
SO2_data <- as.numeric(SO2_data)

# O3
r_O3 <- raster(paste0(dir_O3,"/", filenames_O3[i]))   
r_pts_O3 <- rasterToPoints(r_O3)
colnames(r_pts_O3) <- c("Lon", "Lat", "O3_1km")
r_pts_O3 <- as.data.frame(r_pts_O3) 
O3_data <- as.vector(r_pts_O3$O3_1km)
O3_data <- round(O3_data, digits = 0)
O3_data <- as.numeric(O3_data)


# calculate Air Quality index for PM2.5
aqi_PM25 <- lapply(PM25_data, aqi_PM25_fun)
aqi_PM25 <- as.numeric(aqi_PM25)
aqi_PM25 <- as.data.frame(aqi_PM25)

# calculate Air Quality index for PM10
aqi_PM10 <- lapply(PM10_data, aqi_PM10_fun)
aqi_PM10 <- as.numeric(aqi_PM10)
aqi_PM10 <- as.data.frame(aqi_PM10)

# calculate Air Quality index for CO
aqi_CO <- lapply(CO_data, aqi_CO_fun)
aqi_CO <- as.numeric(aqi_CO)
aqi_CO <- as.data.frame(aqi_CO)

# calculate Air Quality index for NO2
aqi_NO2 <- lapply(NO2_data, aqi_NO2_fun)
aqi_NO2 <- as.numeric(aqi_NO2)
aqi_NO2 <- as.data.frame(aqi_NO2)

# calculate Air Quality index for SO2
aqi_SO2 <- lapply(SO2_data, aqi_SO2_fun)
aqi_SO2 <- as.numeric(aqi_SO2)
aqi_SO2 <- as.data.frame(aqi_SO2)

# calculate Air Quality index for O3
aqi_O3 <- lapply(O3_data, aqi_O3_fun)
aqi_O3 <- as.numeric(aqi_O3)
aqi_O3 <- as.data.frame(aqi_O3)

AQ_data_AQI <- cbind(r_pts_PM25$Lon, r_pts_PM25$Lat, aqi_O3, aqi_CO, aqi_PM25, aqi_PM10, aqi_SO2, aqi_NO2)
colnames(AQ_data_AQI) <- c("Lon", "Lat", "aqi_O3", "aqi_CO", "aqi_PM25", "aqi_PM10", "aqi_SO2",  "aqi_NO2")
# attach the maximum AQI
AQ_data_AQI$max_AQI <- apply(AQ_data_AQI[,3:8], 1, max_AQI_fun)

# select only the Maximum AQI
AQI <- AQ_data_AQI %>%
  select(Lon,
         Lat,
         max_AQI)

# make a raster for each filenames
# create spatial points data frame
spg <- AQI
coordinates(spg) <- ~ Lon + Lat
# coerce to SpatialPixelsDataFrame
gridded(spg) <- TRUE
# coerce to raster
r <- raster(spg)
# add reference system to the raster
crs(r) = "+proj=longlat +datum=WGS84"
# plot(r)
# plot(shp_UAE, add = TRUE)

writeRaster(r, paste0(output_dir,"/",DateTime, "_AQI.tif") , options= "INTERLEAVE=BAND", overwrite=T)

}




