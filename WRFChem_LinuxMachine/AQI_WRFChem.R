
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
source("/home/cesam/WRF_UAE/scripts/aqi_fun_UAE.R")

# load function to find the Pollutant with the maximum AQI
# source("Z:/_SHARED_FOLDERS/Air Quality/Phase 2/AQ_TIDY_Data/Scripts/max_AQI_fun.R")
source("/home/cesam/WRF_UAE/scripts/max_AQI_fun.R")

dir <- "/home/cesam/WRF_UAE/scripts/UAE_boundary"
### shapefile for UAE
shp_UAE <- readOGR(dsn = dir, layer = "uae_emirates")

dir_ME <- "/research/cesam/AirQuality/WRFChem_domain/"
shp_UAE <- readOGR(dsn = dir_ME, layer = "ADMIN_domain_d01_4km_WRFChem")
shp_UAE <- spTransform(shp_UAE, CRS("+init=epsg:4326"))


# ----- Transform to EPSG 4326 - WGS84 (required)
shp_UAE <- spTransform(shp_UAE, CRS("+init=epsg:4326"))

#load shape UAE file from RECREMA team
dir <- "/home/cesam/WRF_UAE/scripts/UAE_moccae_domain/"
UAE_shape <- readOGR(dsn = dir, layer = "UAE_shape")
raster_sample <- raster("/home/cesam/WRF_UAE/scripts/Sample_RECREMA.tif")
sample_raster_HPC <- raster("/home/cesam/WRF_UAE/scripts/sample_raster_HPC.tif")

# read buffer zones around locations in the UAE (this is a ~ 14km buffer zone)
dir <- "/home/cesam/WRF_UAE/scripts/shapes"
# reload and plot domain
shp_buff <- readOGR(dsn = dir, layer = "circular_buffer")


# set daily working directory
date <- commandArgs(trailingOnly = TRUE)
date

time <- Sys.time()
year <- year <- str_sub(time, start = 0, end = -16)
month <- str_sub(time, start = 6, end = -13)
day <- str_sub(time, start = 9, end = -10)

# folder_day <- paste0(year,month, day,"00")    # "2018071500"

folder_day <- date

# folder_day <- "2018071500"
setwd(paste0("/research/cesam/WRFChem_outputs/", folder_day))
# setwd("Z:/_SHARED_FOLDERS/Air Quality/Phase 2/AQI_WRFChem")

# create directory fro AQI
dir.create("AQI")
current_dir <- getwd()
output_dir <- paste0(current_dir, "/AQI")
RECREMA_dir_AQI <- "/research/cesam/RECREMA/AQI/"


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
# i <-35 
# always start from the 25th hour (except for Ozone)

for(i in 25:length(filenames_PM25)) {
  # for(i in 1:5) {
  
  # create name for each file    
  year <- str_sub(filenames_PM25[i], start = 0, end = -14)
  month <- str_sub(filenames_PM25[i], start = 6, end = -11)
  day <- str_sub(filenames_PM25[i], start = 9, end = -8)
  time <- str_sub(filenames_PM25[i], start = 12, end = -5)
  DateTime <- paste0(year,"_",month,"_", day,"_",time)
  new_DateTime <- paste0(year,month,day,"_",time)
  
  # PM2.5   
  # make the average of the rasters within the last 24-hours
  stack_PM25 <- stack()
  
  for(j in (i-12):((i-12)+11)) {
    stack_PM25 <- stack(stack_PM25, raster(paste0(dir_PM25, filenames_PM25[j])))
  }
  # for(j in (i-24):((i-24)+23)) {
  #   if (i < 24) {}
  #   else {stack_PM25 <- stack(stack_PM25, raster(paste0(dir_PM25, filenames_PM25[j])))}
  # }
  # 24h average
  r_PM25 <- mean(stack_PM25)
  r_pts_PM25 <- rasterToPoints(r_PM25)
  colnames(r_pts_PM25) <- c("Lon", "Lat", "PM25_1km")
  r_pts_PM25 <- as.data.frame(r_pts_PM25) 
  # r_pts_PM25 <- subset(r_pts_PM25, !is.na(PM25_1km) & PM25_1km>0)
  PM25_data <- as.vector(r_pts_PM25$PM25_1km)
  PM25_data <- round(PM25_data, digits = 0)
  PM25_data <- as.numeric(PM25_data)
  
  
  
  # PM10
  # make the average of the rasters within the last 24-hours
  stack_PM10 <- stack()
  
  for(j in (i-12):((i-12)+11)) {
    stack_PM10 <- stack(stack_PM10, raster(paste0(dir_PM10, filenames_PM10[j])))
  }
# 24h average
  r_PM10 <- mean(stack_PM10)
  r_pts_PM10 <- rasterToPoints(r_PM10)
  colnames(r_pts_PM10) <- c("Lon", "Lat", "PM10_1km")
  r_pts_PM10 <- as.data.frame(r_pts_PM10) 
  # r_pts_PM10 <- subset(r_pts_PM10, !is.na(PM10_1km) & PM10_1km>0)
  PM10_data <- as.vector(r_pts_PM10$PM10_1km)
  PM10_data <- round(PM10_data, digits = 0)
  PM10_data <- as.numeric(PM10_data)

  
  
  
  # CO
  # make the average of the rasters within the last 8-hours
  stack_CO <- stack()
  
  for(j in (i-8):((i-8)+7)) {
    stack_CO <- stack(stack_CO, raster(paste0(dir_CO, filenames_CO[j])))
  }
  # 8h average
  r_CO <- mean(stack_CO)
  r_pts_CO <- rasterToPoints(r_CO)
  colnames(r_pts_CO) <- c("Lon", "Lat", "CO_1km")
  r_pts_CO <- as.data.frame(r_pts_CO) 
  # r_pts_CO <- subset(r_pts_CO, !is.na(CO_1km) & CO_1km>0)
  CO_data <- as.vector(r_pts_CO$CO_1km)
  CO_data <- round(CO_data, digits = 0)
  # conversion from mg/m3 to ppm (WHO conversion factor)
  CO_data <- as.numeric(CO_data)/1.15 
  
  
  
  # NO2
  # make the average of the rasters within the last 24-hours
  stack_NO2 <- stack()
  
  for(j in (i-12):((i-12)+11)) {
    stack_NO2 <- stack(stack_NO2, raster(paste0(dir_NO2, filenames_NO2[j])))
  }
  # 24h average
  r_NO2 <- mean(stack_NO2)
  r_pts_NO2 <- rasterToPoints(r_NO2)
  colnames(r_pts_NO2) <- c("Lon", "Lat", "NO2_1km")
  r_pts_NO2 <- as.data.frame(r_pts_NO2) 
  # r_pts_NO2 <- subset(r_pts_NO2, !is.na(NO2_1km) & NO2_1km>0)
  NO2_data <- as.vector(r_pts_NO2$NO2_1km)
  NO2_data <- round(NO2_data, digits = 0)
  NO2_data <- as.numeric(NO2_data)/1.88
  
  
  
  
  # SO2
  # make the average of the rasters within the last 24-hours
  stack_SO2 <- stack()
  
  for(j in (i-12):((i-12)+11)) {
    stack_SO2 <- stack(stack_SO2, raster(paste0(dir_SO2, filenames_SO2[j])))
  }
  # 24h average
  r_SO2 <- mean(stack_SO2)
  r_pts_SO2 <- rasterToPoints(r_SO2)
  colnames(r_pts_SO2) <- c("Lon", "Lat", "SO2_1km")
  r_pts_SO2 <- as.data.frame(r_pts_SO2) 
  # r_pts_SO2 <- subset(r_pts_SO2, !is.na(SO2_1km) & SO2_1km>0)
  SO2_data <- as.vector(r_pts_SO2$SO2_1km)
  SO2_data <- round(SO2_data, digits = 0)
  SO2_data <- as.numeric(SO2_data)/2.62
  
  
  
  
  # O3
  # make the average of the rasters within the last 8-hours
  stack_O3 <- stack()
  
  for(j in (i-8):((i-8)+7)) {
    stack_O3 <- stack(stack_O3, raster(paste0(dir_O3, filenames_O3[j])))
  }
  # 8h average
  r_O3 <- mean(stack_O3)  
  r_pts_O3 <- rasterToPoints(r_O3)
  colnames(r_pts_O3) <- c("Lon", "Lat", "O3_1km")
  r_pts_O3 <- as.data.frame(r_pts_O3) 
  # r_pts_O3 <- subset(r_pts_O3, !is.na(O3_1km) & O3_1km>0)
  O3_data <- as.vector(r_pts_O3$O3_1km)
  O3_data <- round(O3_data, digits = 0)
  # conversion from ug/m3 to ppb (WHO conversion factor)
  O3_data <- as.numeric(O3_data)/1.96
  
  
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


# r <- crop(r, extent(shp_UAE))
# r <- mask(r, shp_UAE)
r <- projectRaster(r, sample_raster_HPC)
writeRaster(r, paste0(output_dir,"/",DateTime, "_AQI.tif") , options= "INTERLEAVE=BAND", overwrite=T)


## crop
WRF_tif_1km <- crop(r, extent(UAE_shape))
WRF_tif_1km <- mask(WRF_tif_1km, UAE_shape)


# make resolution and extent as for RECREMA file
WRF_tif_1km_pts <- rasterToPoints(WRF_tif_1km)
colnames(WRF_tif_1km_pts) <- c("Lon", "Lat", "value")
WRF_tif_1km_pts <- as.data.frame(WRF_tif_1km_pts) 

WRF_tif_1km_pts$x <- WRF_tif_1km_pts$Lon
WRF_tif_1km_pts$y <- WRF_tif_1km_pts$Lat

coordinates(WRF_tif_1km_pts) = ~x + y  ## Set spatial coordinates to create a Spatial object:

x.range <- as.numeric(c(51.5319495550555, 56.3933081454769), options(digits = 13))  # min/max longitude of the interpolation area
y.range <- as.numeric(c(22.6000614885832, 26.05610805803908), options(digits = 13))  # min/max latitude of the interpolation area


## grid at given resolution
grd <- expand.grid(x = seq(from = x.range[1], to = x.range[2], by = 0.0200056140100055),
                   y = seq(from = y.range[1], to = y.range[2], by = 0.0200059596012141))  # expand points to grid
coordinates(grd) <- ~x + y
gridded(grd) <- TRUE

idw <- idw(formula = value ~ 1, locations = WRF_tif_1km_pts, 
           newdata = grd)  # apply idw model for the data (interpolation)

idw.output = as.data.frame(idw)[1:3]  # output is defined as a data table
names(idw.output)[1:3] <- c("Lon", "Lat", "value")  # give names to the modelled variables


coordinates(idw.output) <- ~ Lon + Lat
##coerce to SpatialPixelsDataFrame
gridded(idw.output) <- TRUE
raster_layer <- raster(idw.output)
projection(raster_layer) <- CRS("+proj=longlat +datum=WGS84")

raster_layer <- crop(raster_layer, extent(UAE_shape))
raster_layer<- mask(raster_layer, UAE_shape)
raster_layer <- raster_layer*1.5

writeRaster(raster_layer, paste0(RECREMA_dir_AQI, "AQI_",new_DateTime,".tif") , options= "INTERLEAVE=BAND", overwrite=T)


######################################
#### make class from AQI ranges ######
######################################

data_points <- rasterToPoints(raster_layer)
colnames(data_points) <- c("Lon", "Lat", "AQI")
data_points <- as.data.frame(data_points) 

# remove lines with Na values
data_points <- data_points[!is.na(data_points$AQI),]
# round AQI
# data_points$AQI <- round(as.numeric(data_points$AQI), digits = 0)

# k <- 2

data_points$category <- NA
# add classes
for (k in 1:nrow(data_points)) {
  if (data_points$AQI[k] < 50 & data_points$AQI[k] >= 0) 
    data_points$category[k] = 0   # Good
  if (data_points$AQI[k] < 100 & data_points$AQI[k] >= 50) 
    data_points$category[k] = 1   # Moderate
  if (data_points$AQI[k] < 150 & data_points$AQI[k] >= 100) 
    data_points$category[k] = 2   # Unhealthy for Sensitive Groups
  if (data_points$AQI[k] < 200 & data_points$AQI[k] >= 150) 
    data_points$category[k] = 3   # Unhealthy
  if (data_points$AQI[k] < 300 & data_points$AQI[k] >= 200) 
    data_points$category[k] = 4   # Very Unhealthy
  if (data_points$AQI[k] < 500 & data_points$AQI[k] >= 300) 
    data_points$category[k] = 5   # Hazardous
}

# select only the Maximum AQI
AQI_class <- data_points %>%
  select(Lon,
         Lat,
         category)

# make a raster for each filenames
# create spatial points data frame
spg <- AQI_class
coordinates(spg) <- ~ Lon + Lat
# coerce to SpatialPixelsDataFrame
gridded(spg) <- TRUE
# coerce to raster
r <- raster(spg)
# add reference system to the raster
crs(r) = "+proj=longlat +datum=WGS84"

writeRaster(r, paste0(RECREMA_dir_AQI, "AQI_",new_DateTime,".tif") , options= "INTERLEAVE=BAND", overwrite=T)


###################################################################################################################
###################################################################################################################
###################################################################################################################
###################################################################################################################

#######################################################
# generate .csv files for AQI with unhealthy values ###
#######################################################

crs <- projection(shp_buff) ### get projections from shp file
# make a spatial object with each AQI
AQI <- SpatialPointsDataFrame(AQI[,1:2], AQI, 
                              proj4string=CRS(crs))

# get NUMBER of POINTS that fall into the circular buffer zone
# pts_in_buffer <- sp::over(values, shp_buff, fun = NULL)
pts_in_buffer_ID <- over(AQI, shp_buff[, "ID"])
pts_in_buffer_ID <- na.omit(pts_in_buffer_ID)


# library(spatialEco)
# find points inside the buffer
# pts_in_buffer <- point.in.poly(values, shp_buff)
pts_in_buffer <- AQI[shp_buff,] 
head(pts_in_buffer@data)

data_points <- pts_in_buffer@data 
names(data_points)
# Join ID
data_points <- cbind(data_points, pts_in_buffer_ID)


# Aggregate by zone/polygon
# data_points <- pts_in_buffer@data 
names(data_points)

data_points <- data_points %>% 
  dplyr::group_by(ID) %>% 
  dplyr::summarise(AVERAGE_AQI = mean(max_AQI, na.rm = TRUE)) %>% 
  dplyr::ungroup()
# change NaN into NA
# data_points[is.na(data_points)] <- " "
# remove lines with Na values
data_points <- data_points[!is.na(data_points$AVERAGE_AQI),]
# round AQI
data_points$AVERAGE_AQI <- round(as.numeric(data_points$AVERAGE_AQI), digits = 0)

# k <- 2

data_points$category <- NA
# add names and colour band
for (k in 1:nrow(data_points)) {
  if (data_points$AVERAGE_AQI[k] < 50 & data_points$AVERAGE_AQI[k] >= 0) 
    data_points$category[k] = c("Good") 
  if (data_points$AVERAGE_AQI[k] < 100 & data_points$AVERAGE_AQI[k] >= 50) 
    data_points$category[k] = c("Moderate") 
  if (data_points$AVERAGE_AQI[k] < 150 & data_points$AVERAGE_AQI[k] >= 100) 
    data_points$category[k] = c("Unhealthy for Sensitive Groups") 
  if (data_points$AVERAGE_AQI[k] < 200 & data_points$AVERAGE_AQI[k] >= 150) 
    data_points$category[k] = c("Unhealthy") 
  if (data_points$AVERAGE_AQI[k] < 300 & data_points$AVERAGE_AQI[k] >= 200) 
    data_points$category[k] = c("Very Unhealthy") 
  if (data_points$AVERAGE_AQI[k] < 500 & data_points$AVERAGE_AQI[k] >= 300) 
    data_points$category[k] = c("Hazardous") 
# write.csv(data_points, paste0(output_dir,"/",DateTime, "_AQI.csv"))

# write /csv files ONLY when AQI is unhealthy  
# if (data_points$category[k] =="Good")
#   {
#    write.csv(data_points, paste0(output_dir,"/",DateTime, "_AQI_GOOD.csv"))
# }
  
  if (data_points$category[k] =="Moderate")
  {
    # write.csv(data_points, paste0(output_dir,"/",DateTime, "_AQI_MODERATE.csv"))
    write.csv(filter(data_points, category == 'Moderate'), paste0(output_dir,"/",DateTime, "_AQI_MODERATE.csv"))
  } 
  else if (data_points$category[k] =="Unhealthy for Sensitive Groups")
  {
    # write.csv(data_points, paste0(output_dir,"/",DateTime, "_AQI_SENSITIVE.csv"))
    write.csv(filter(data_points, category == 'Unhealthy for Sensitive Groups'), paste0(output_dir,"/",DateTime, "_AQI_SENSITIVE.csv"))
  } 
  else if (data_points$category[k] =="Unhealthy")
  {
    #  write.csv(data_points, paste0(output_dir,"/",DateTime, "_AQI_UNHEALTHY.csv"))
    write.csv(filter(data_points, category == 'Unhealthy'), paste0(output_dir,"/",DateTime, "_AQI_UNHEALTHY.csv"))
  } 
  else if (data_points$category[k] =="Very Unhealthy")
  {
    #  write.csv(data_points, paste0(output_dir,"/",DateTime, "_AQI_Very_UNHEALTHY.csv"))
    write.csv(filter(data_points, category == 'Very Unhealthy'), paste0(output_dir,"/",DateTime, "_AQI_Very_UNHEALTHY.csv"))
  } 
  else if (data_points$category[k] =="Hazardous")
  {  
    # write.csv(data_points, paste0(output_dir,"/",DateTime, "_AQI_HAZARD.csv"))
    write.csv(filter(data_points, category == 'Hazardous'), paste0(output_dir,"/",DateTime, "_AQI_HAZARD.csv"))
  }

}
}


###############################################################################

dir_AQI <- output_dir
filenames_AQI <- list.files(path = dir_AQI, pattern = ".csv$")

# open each .csv file and bind all data together

# i <- 3

AQI <- NULL

for (i in 1: length(filenames_AQI)) {
  aqi <- read.csv(paste0(dir_AQI, "/", filenames_AQI[i]))[-1]
  
  year <- str_sub(filenames_AQI[i], start = 1, end = -27)
  month <- str_sub(filenames_AQI[i], start = 6, end = -24)
  day <- str_sub(filenames_AQI[i], start = 9, end = -21)
  Date <- as.Date(paste0(year , "-", month, "-", day))
  category <- str_sub(filenames_AQI[i], start = 19, end = -5)
  
  aqi <- cbind(Date, aqi)
  
  AQI = rbind(AQI, data.frame(aqi))
  
}


# group by station and chose the maximum AQI value
AQI <- AQI %>%
  group_by(ID,
           Date,
           category) %>%
  summarize(max_AQI=max(AVERAGE_AQI))

write.csv(AQI, paste0(output_dir, "/" , "AQI_", folder_day, ".csv"))



