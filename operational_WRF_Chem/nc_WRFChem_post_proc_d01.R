
library(RNetCDF)
library(rgdal)
library(ncdf4)
library(raster)
library(stringr)
library(gstat)


# list .nc files
# 12km

### shapefile for WRF_domain UAE REGION ONLY
dir_ME <- "/research/cesam/AirQuality/WRFChem_domain/"
shp_UAE <- readOGR(dsn = dir_ME, layer = "ADMIN_domain_d01_4km_WRFChem")
shp_UAE <- spTransform(shp_UAE, CRS("+init=epsg:4326"))


PM25_2015_GRW <- raster("/disk3/fkaragulian/MODIS_AOD/GlobalGWR_PM25_GL_201501_201512-RH35.nc")
#   PM25_2015_GRW <- raster("D:/MODIS_AOD/GlobalGWR_PM25_GL_201501_201512-RH35.nc")
projection(PM25_2015_GRW) <- CRS("+proj=longlat +datum=WGS84")

### crop raster over the UAE shp file  ###############################
PM25_2015_GRW <- crop(PM25_2015_GRW, extent(shp_UAE))
PM25_2015_GRW <- mask(PM25_2015_GRW, shp_UAE)


setwd("/research/cesam/WRFChem_outputs/")
# dirs <- list.dirs()
### get the most recent directory ####
# dirs <- sort(dirs, decreasing = T)

# folder_day <- str_sub(dirs[1], start = 3, end = -1)

date <- commandArgs(trailingOnly = TRUE)
date

time <- Sys.time()
year <- year <- str_sub(time, start = 0, end = -16)
month <- str_sub(time, start = 6, end = -13)
day <- str_sub(time, start = 9, end = -10) 
# folder_day <- paste0(year,month, day,"00")    # "2017120400"


folder_day <- date
# suffix <- str_sub(folder_day, start =9 , end = -1)

# date=Sys.arg[1]
# folder_day <- "2017100500"
# year <- "2017"
# month <- "10"
# day <- "01"

setwd(paste0("/research/cesam/WRFChem_outputs/", folder_day))

filenames <- list.files(pattern = c("d01", ".nc"))
filenames <- filenames

#############################################
## function to import multiple .nc files ####
#############################################

# filenames <- filenames[1]


# gerate a time sequence for the WRF-Chem run at intervals of 1 hour (it should be 73 images), 3 days


start <- as.POSIXct(paste0(year,"-",month,"-", day, " ", "00:", " ", "01"))
# start <- as.POSIXct("2017-09-28 00:01")
interval <- 60 #minutes
end <- start + as.difftime(6, units="days")
TS <- seq(from=start, by=interval*60, to=end)
TS <- TS[1:73]


#################
##### PM10  #####
#################

dir.create("PM10")
current_dir <- getwd()


 # j = 5
qq <- 0

   for(j in 1:length(filenames)) {
     qq <- qq +1
     WRF_file <- open.nc(filenames[j])
     WRF_file <- read.nc(WRF_file)
     name_vari <- names(WRF_file)
     name <- str_sub(filenames[j], start = 1, end = -14)

     # all concnetrations ar in ug/m3 (CO is in mg/m3)
     PM10 <- (WRF_file[32])    #  total PM10
     PM25 <- (WRF_file[33])    #  total PM2.5
     CO <- (WRF_file[38])    #  total CO
     NO2 <- (WRF_file[37])    #  total NO2
     SO2 <- (WRF_file[36])    #  total SO2
     O3 <- (WRF_file[39])    #  total O3
     
     names(PM10)<- "xxyyzz"
     names(PM25)<- "xxyyzz"
     names(CO)<- "xxyyzz"
     names(NO2)<- "xxyyzz"
     names(SO2)<- "xxyyzz"
     names(O3)<- "xxyyzz"
     PM10 <- (PM10$xxyyzz)
     PM25 <- (PM25$xxyyzz)
     CO <- (CO$xxyyzz)
     NO2 <- (NO2$xxyyzz)
     SO2 <- (SO2$xxyyzz)
     O3 <- (O3$xxyyzz)
     LON <- WRF_file$lon
     LAT <- WRF_file$lat

     xmn= min(LON)
     xmx=max(LON)
     ymn=min(LAT)
     ymx=max(LAT)

     name_time <- TS[qq]
     year <- str_sub(name_time, start = 0, end = -16)
     month <- str_sub(name_time, start = 6, end = -13)
     day <- str_sub(name_time, start = 9, end = -10)
     time <- str_sub(name_time, start = 12, end = -7)
     DateTime <- paste0(year,"_",month,"_", day,"_",time)


    MMM <-  t(PM10[ , ,1])   # map is upside down  (only consider surface level)
    MMM <- MMM[nrow(MMM):1, ]
    r <- raster(MMM, xmn, xmx, ymn,  ymx, crs="+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")
   # plot(r)
   # writeRaster(r, paste0(DateTime,".tif") , options= "INTERLEAVE=BAND", overwrite=T)

    r <- crop(r, extent(shp_UAE))
    r <- mask(r, shp_UAE)

    ###################

    ## make resolution of MODIS-data as the one of GWR-------------------------------
    WRF_tif_1km = projectRaster(r, PM25_2015_GRW)


    #  plot(WRF_tif_1km)
    # save rasters
    writeRaster(WRF_tif_1km, paste0(current_dir, "/PM10/",DateTime,".tif") , options= "INTERLEAVE=BAND", overwrite=T)
    # CONVERISON FILES FOR MOCCAE BIG WEBSITE
    
    # new date format
    
    # new extent and projection
    
   }



#################
##### PM2.5  #####
#################

dir.create("PM25")
current_dir <- getwd()


# j = 5
qq <- 0

for(j in 1:length(filenames)) {
  qq <- qq +1
  WRF_file <- open.nc(filenames[j])
  WRF_file <- read.nc(WRF_file)
  name_vari <- names(WRF_file)
  name <- str_sub(filenames[j], start = 1, end = -14)
  
  # all concnetrations ar in ug/m3 (CO is in mg/m3)
  PM10 <- (WRF_file[32])    #  total PM10
  PM25 <- (WRF_file[33])    #  total PM2.5
  CO <- (WRF_file[38])    #  total CO
  NO2 <- (WRF_file[37])    #  total NO2
  SO2 <- (WRF_file[36])    #  total SO2
  O3 <- (WRF_file[39])    #  total O3
  
  names(PM10)<- "xxyyzz"
  names(PM25)<- "xxyyzz"
  names(CO)<- "xxyyzz"
  names(NO2)<- "xxyyzz"
  names(SO2)<- "xxyyzz"
  names(O3)<- "xxyyzz"
  PM10 <- (PM10$xxyyzz)
  PM25 <- (PM25$xxyyzz)
  CO <- (CO$xxyyzz)
  NO2 <- (NO2$xxyyzz)
  SO2 <- (SO2$xxyyzz)
  O3 <- (O3$xxyyzz)
  LON <- WRF_file$lon
  LAT <- WRF_file$lat
  
  xmn= min(LON)
  xmx=max(LON)
  ymn=min(LAT)
  ymx=max(LAT)
  
  name_time <- TS[qq]
  year <- str_sub(name_time, start = 0, end = -16)
  month <- str_sub(name_time, start = 6, end = -13)
  day <- str_sub(name_time, start = 9, end = -10)
  time <- str_sub(name_time, start = 12, end = -7)
  DateTime <- paste0(year,"_",month,"_", day,"_",time)
  
  
  MMM <-  t(PM25[ , ,1])   # map is upside down  (only consider surface level)
  MMM <- MMM[nrow(MMM):1, ]
  r <- raster(MMM, xmn, xmx, ymn,  ymx, crs="+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")
  # plot(r)
  # writeRaster(r, paste0(DateTime,".tif") , options= "INTERLEAVE=BAND", overwrite=T)
  
  r <- crop(r, extent(shp_UAE))
  r <- mask(r, shp_UAE)
  
  ###################
  
  ## make resolution of MODIS-data as the one of GWR-------------------------------
  WRF_tif_1km = projectRaster(r, PM25_2015_GRW)
  
  
  #  plot(WRF_tif_1km)
  # save rasters
  writeRaster(WRF_tif_1km, paste0(current_dir, "/PM25/",DateTime,".tif") , options= "INTERLEAVE=BAND", overwrite=T)
}



#################
##### NO2  #####
#################

dir.create("NO2")
current_dir <- getwd()


# j = 5
qq <- 0

for(j in 1:length(filenames)) {
  qq <- qq +1
  WRF_file <- open.nc(filenames[j])
  WRF_file <- read.nc(WRF_file)
  name_vari <- names(WRF_file)
  name <- str_sub(filenames[j], start = 1, end = -14)
  
  # all concnetrations ar in ug/m3 (CO is in mg/m3)
  PM10 <- (WRF_file[32])    #  total PM10
  PM25 <- (WRF_file[33])    #  total PM2.5
  CO <- (WRF_file[38])    #  total CO
  NO2 <- (WRF_file[37])    #  total NO2
  SO2 <- (WRF_file[36])    #  total SO2
  O3 <- (WRF_file[39])    #  total O3
  
  names(PM10)<- "xxyyzz"
  names(PM25)<- "xxyyzz"
  names(CO)<- "xxyyzz"
  names(NO2)<- "xxyyzz"
  names(SO2)<- "xxyyzz"
  names(O3)<- "xxyyzz"
  PM10 <- (PM10$xxyyzz)
  PM25 <- (PM25$xxyyzz)
  CO <- (CO$xxyyzz)
  NO2 <- (NO2$xxyyzz)
  SO2 <- (SO2$xxyyzz)
  O3 <- (O3$xxyyzz)
  LON <- WRF_file$lon
  LAT <- WRF_file$lat
  
  xmn= min(LON)
  xmx=max(LON)
  ymn=min(LAT)
  ymx=max(LAT)
  
  name_time <- TS[qq]
  year <- str_sub(name_time, start = 0, end = -16)
  month <- str_sub(name_time, start = 6, end = -13)
  day <- str_sub(name_time, start = 9, end = -10)
  time <- str_sub(name_time, start = 12, end = -7)
  DateTime <- paste0(year,"_",month,"_", day,"_",time)
  
  
  MMM <-  t(NO2[ , ,1])   # map is upside down  (only consider surface level)
  MMM <- MMM[nrow(MMM):1, ]
  r <- raster(MMM, xmn, xmx, ymn,  ymx, crs="+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")
  # plot(r)
  # writeRaster(r, paste0(DateTime,".tif") , options= "INTERLEAVE=BAND", overwrite=T)
  
  r <- crop(r, extent(shp_UAE))
  r <- mask(r, shp_UAE)
  
  ###################
  
  ## make resolution of MODIS-data as the one of GWR-------------------------------
  WRF_tif_1km = projectRaster(r, PM25_2015_GRW)
  
  
  #  plot(WRF_tif_1km)
  # save rasters
  writeRaster(WRF_tif_1km, paste0(current_dir, "/NO2/",DateTime,".tif") , options= "INTERLEAVE=BAND", overwrite=T)
}



#################
##### SO2  #####
#################

dir.create("SO2")
current_dir <- getwd()


# j = 5
qq <- 0

for(j in 1:length(filenames)) {
  qq <- qq +1
  WRF_file <- open.nc(filenames[j])
  WRF_file <- read.nc(WRF_file)
  name_vari <- names(WRF_file)
  name <- str_sub(filenames[j], start = 1, end = -14)
  
  # all concnetrations ar in ug/m3 (CO is in mg/m3)
  PM10 <- (WRF_file[32])    #  total PM10
  PM25 <- (WRF_file[33])    #  total PM2.5
  CO <- (WRF_file[38])    #  total CO
  NO2 <- (WRF_file[37])    #  total NO2
  SO2 <- (WRF_file[36])    #  total SO2
  O3 <- (WRF_file[39])    #  total O3
  
  names(PM10)<- "xxyyzz"
  names(PM25)<- "xxyyzz"
  names(CO)<- "xxyyzz"
  names(NO2)<- "xxyyzz"
  names(SO2)<- "xxyyzz"
  names(O3)<- "xxyyzz"
  PM10 <- (PM10$xxyyzz)
  PM25 <- (PM25$xxyyzz)
  CO <- (CO$xxyyzz)
  NO2 <- (NO2$xxyyzz)
  SO2 <- (SO2$xxyyzz)
  O3 <- (O3$xxyyzz)
  LON <- WRF_file$lon
  LAT <- WRF_file$lat
  
  xmn= min(LON)
  xmx=max(LON)
  ymn=min(LAT)
  ymx=max(LAT)
  
  name_time <- TS[qq]
  year <- str_sub(name_time, start = 0, end = -16)
  month <- str_sub(name_time, start = 6, end = -13)
  day <- str_sub(name_time, start = 9, end = -10)
  time <- str_sub(name_time, start = 12, end = -7)
  DateTime <- paste0(year,"_",month,"_", day,"_",time)
  
  
  MMM <-  t(SO2[ , ,1])   # map is upside down  (only consider surface level)
  MMM <- MMM[nrow(MMM):1, ]
  r <- raster(MMM, xmn, xmx, ymn,  ymx, crs="+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")
  # plot(r)
  # writeRaster(r, paste0(DateTime,".tif") , options= "INTERLEAVE=BAND", overwrite=T)
  
  r <- crop(r, extent(shp_UAE))
  r <- mask(r, shp_UAE)
  
  ###################
  
  ## make resolution of MODIS-data as the one of GWR-------------------------------
  WRF_tif_1km = projectRaster(r, PM25_2015_GRW)
  
  
  #  plot(WRF_tif_1km)
  # save rasters
  writeRaster(WRF_tif_1km, paste0(current_dir, "/SO2/",DateTime,".tif") , options= "INTERLEAVE=BAND", overwrite=T)
}



#################
##### CO  #####
#################

dir.create("CO")
current_dir <- getwd()


# j = 5
qq <- 0

for(j in 1:length(filenames)) {
  qq <- qq +1
  WRF_file <- open.nc(filenames[j])
  WRF_file <- read.nc(WRF_file)
  name_vari <- names(WRF_file)
  name <- str_sub(filenames[j], start = 1, end = -14)
  
  # all concnetrations ar in ug/m3 (CO is in mg/m3)
  PM10 <- (WRF_file[32])    #  total PM10
  PM25 <- (WRF_file[33])    #  total PM2.5
  CO <- (WRF_file[38])    #  total CO
  NO2 <- (WRF_file[37])    #  total NO2
  SO2 <- (WRF_file[36])    #  total SO2
  O3 <- (WRF_file[39])    #  total O3
  
  names(PM10)<- "xxyyzz"
  names(PM25)<- "xxyyzz"
  names(CO)<- "xxyyzz"
  names(NO2)<- "xxyyzz"
  names(SO2)<- "xxyyzz"
  names(O3)<- "xxyyzz"
  PM10 <- (PM10$xxyyzz)
  PM25 <- (PM25$xxyyzz)
  CO <- (CO$xxyyzz)
  NO2 <- (NO2$xxyyzz)
  SO2 <- (SO2$xxyyzz)
  O3 <- (O3$xxyyzz)
  LON <- WRF_file$lon
  LAT <- WRF_file$lat
  
  xmn= min(LON)
  xmx=max(LON)
  ymn=min(LAT)
  ymx=max(LAT)
  
  name_time <- TS[qq]
  year <- str_sub(name_time, start = 0, end = -16)
  month <- str_sub(name_time, start = 6, end = -13)
  day <- str_sub(name_time, start = 9, end = -10)
  time <- str_sub(name_time, start = 12, end = -7)
  DateTime <- paste0(year,"_",month,"_", day,"_",time)
  
  
  MMM <-  t(CO[ , ,1])   # map is upside down  (only consider surface level)
  MMM <- MMM[nrow(MMM):1, ]
  r <- raster(MMM, xmn, xmx, ymn,  ymx, crs="+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")
  # plot(r)
  # writeRaster(r, paste0(DateTime,".tif") , options= "INTERLEAVE=BAND", overwrite=T)
  
  r <- crop(r, extent(shp_UAE))
  r <- mask(r, shp_UAE)
  
  ###################
  
  ## make resolution of MODIS-data as the one of GWR-------------------------------
  WRF_tif_1km = projectRaster(r, PM25_2015_GRW)
  
  
  #  plot(WRF_tif_1km)
  # save rasters
  writeRaster(WRF_tif_1km, paste0(current_dir, "/CO/",DateTime,".tif") , options= "INTERLEAVE=BAND", overwrite=T)
}




#################
##### O3  #####
#################

dir.create("O3")
current_dir <- getwd()


# j = 5
qq <- 0

for(j in 1:length(filenames)) {
  qq <- qq +1
  WRF_file <- open.nc(filenames[j])
  WRF_file <- read.nc(WRF_file)
  name_vari <- names(WRF_file)
  name <- str_sub(filenames[j], start = 1, end = -14)
  
  # all concnetrations ar in ug/m3 (CO is in mg/m3)
  PM10 <- (WRF_file[32])    #  total PM10
  PM25 <- (WRF_file[33])    #  total PM2.5
  CO <- (WRF_file[38])    #  total CO
  NO2 <- (WRF_file[37])    #  total NO2
  SO2 <- (WRF_file[36])    #  total SO2
  O3 <- (WRF_file[39])    #  total O3
  
  names(PM10)<- "xxyyzz"
  names(PM25)<- "xxyyzz"
  names(CO)<- "xxyyzz"
  names(NO2)<- "xxyyzz"
  names(SO2)<- "xxyyzz"
  names(O3)<- "xxyyzz"
  PM10 <- (PM10$xxyyzz)
  PM25 <- (PM25$xxyyzz)
  CO <- (CO$xxyyzz)
  NO2 <- (NO2$xxyyzz)
  SO2 <- (SO2$xxyyzz)
  O3 <- (O3$xxyyzz)
  LON <- WRF_file$lon
  LAT <- WRF_file$lat
  
  xmn= min(LON)
  xmx=max(LON)
  ymn=min(LAT)
  ymx=max(LAT)
  
  name_time <- TS[qq]
  year <- str_sub(name_time, start = 0, end = -16)
  month <- str_sub(name_time, start = 6, end = -13)
  day <- str_sub(name_time, start = 9, end = -10)
  time <- str_sub(name_time, start = 12, end = -7)
  DateTime <- paste0(year,"_",month,"_", day,"_",time)
  
  
  MMM <-  t(O3[ , ,1])   # map is upside down  (only consider surface level)
  MMM <- MMM[nrow(MMM):1, ]
  r <- raster(MMM, xmn, xmx, ymn,  ymx, crs="+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")
  # plot(r)
  # writeRaster(r, paste0(DateTime,".tif") , options= "INTERLEAVE=BAND", overwrite=T)
  
  r <- crop(r, extent(shp_UAE))
  r <- mask(r, shp_UAE)
  
  ###################
  
  ## make resolution of MODIS-data as the one of GWR-------------------------------
  WRF_tif_1km = projectRaster(r, PM25_2015_GRW)
  
  
  #  plot(WRF_tif_1km)
  # save rasters
  writeRaster(WRF_tif_1km, paste0(current_dir, "/O3/",DateTime,".tif") , options= "INTERLEAVE=BAND", overwrite=T)
}
