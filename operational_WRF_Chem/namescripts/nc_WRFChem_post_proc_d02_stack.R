
library(RNetCDF)
library(rgdal)
library(ncdf4)
library(raster)
library(stringr)
library(gstat)


# list .nc files
# 4km
setwd("D:/Op_WRF_Chem/2017092800")

filenames <- list.files(pattern = c("d02", ".nc"))
filenames <- filenames
# filenames <- filenames[1:4]

#############################################
## function to import multiple .nc files ####
#############################################

# filenames <- filenames[4]

# gerate a time sequence for the WRF-Chem run at intervals of 1 hour (should be 145 images), 6 days
start <- as.POSIXct("2017-09-28 00:01")
interval <- 60 #minutes
end <- start + as.difftime(6, units="days")
TS <- seq(from=start, by=interval*60, to=end)
TS <- TS[1:5]


  ######
  #### looping the variables of the nc files

##################################################################     
##### PM10  ######################################################
##################################################################

import_nc_WRF_PM10 <- function(filenames){
 # j = 1
  all_rasters <- stack()
  qq<- 0
 
  for(j in 1:length(filenames)) {
    
     qq <- qq +1
     WRF_file <- open.nc(filenames[j])
     WRF_file <- read.nc(WRF_file)
     name_vari <- names(WRF_file)
     name <- str_sub(filenames[j], start = 1, end = -14)
     
     # all concnetrations ar in ug/m3
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
     DateTime <- paste0(year,"_",month,"_", day,"_",time,"_00")
     

    MMM <-  t(PM10[ , ,1])   # map is upside down  (only consider surface level)
    MMM <- MMM[nrow(MMM):1, ]
    r <- raster(MMM, xmn, xmx, ymn,  ymx, crs="+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")
    plot(r)
    name_time <- TS[qq]
    all_rasters <- stack(all_rasters,r)
  #  writeRaster(r, paste0(DateTime,".tif") , options= "INTERLEAVE=BAND", overwrite=T)
   }

return(all_rasters)

}

BBB <- import_nc_WRF_PM10(filenames)
writeRaster(BBB, "AQ_4km_WRFChem_2017092800_PM10.tif" , options= "INTERLEAVE=BAND", overwrite=T)


##################################################################     
##### PM2.5  #####################################################
##################################################################

import_nc_WRF_PM25 <- function(filenames){
  # j = 1
  all_rasters <- stack()
  qq<- 0
  
  for(j in 1:length(filenames)) {
    
    qq <- qq +1
    WRF_file <- open.nc(filenames[j])
    WRF_file <- read.nc(WRF_file)
    name_vari <- names(WRF_file)
    name <- str_sub(filenames[j], start = 1, end = -14)
    
    # all concnetrations ar in ug/m3
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
    DateTime <- paste0(year,"_",month,"_", day,"_",time,"_00")
    
    
    MMM <-  t(PM25[ , ,1])   # map is upside down  (only consider surface level)
    MMM <- MMM[nrow(MMM):1, ]
    r <- raster(MMM, xmn, xmx, ymn,  ymx, crs="+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")
    plot(r)
    name_time <- TS[qq]
    all_rasters <- stack(all_rasters,r)
    #  writeRaster(r, paste0(DateTime,".tif") , options= "INTERLEAVE=BAND", overwrite=T)
  }
  
  return(all_rasters)
  
}

BBB <- import_nc_WRF_PM25(filenames)
writeRaster(BBB, "AQ_4km_WRFChem_2017092800_PM25.tif" , options= "INTERLEAVE=BAND", overwrite=T)

##################################################################     
##### NO2  #######################################################
##################################################################

import_nc_WRF_NO2 <- function(filenames){
  # j = 1
  all_rasters <- stack()
  qq<- 0
  
  for(j in 1:length(filenames)) {
    
    qq <- qq +1
    WRF_file <- open.nc(filenames[j])
    WRF_file <- read.nc(WRF_file)
    name_vari <- names(WRF_file)
    name <- str_sub(filenames[j], start = 1, end = -14)
    
    # all concnetrations ar in ug/m3
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
    DateTime <- paste0(year,"_",month,"_", day,"_",time,"_00")
    
    
    MMM <-  t(NO2[ , ,1])   # map is upside down  (only consider surface level)
    MMM <- MMM[nrow(MMM):1, ]
    r <- raster(MMM, xmn, xmx, ymn,  ymx, crs="+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")
    plot(r)
    name_time <- TS[qq]
    all_rasters <- stack(all_rasters,r)
    #  writeRaster(r, paste0(DateTime,".tif") , options= "INTERLEAVE=BAND", overwrite=T)
  }
  
  return(all_rasters)
  
}

BBB <- import_nc_WRF_NO2(filenames)
writeRaster(BBB, "AQ_4km_WRFChem_2017092800_NO2.tif" , options= "INTERLEAVE=BAND", overwrite=T)

##################################################################     
##### CO  ########################################################
##################################################################

import_nc_WRF_CO <- function(filenames){
  # j = 1
  all_rasters <- stack()
  qq<- 0
  
  for(j in 1:length(filenames)) {
    
    qq <- qq +1
    WRF_file <- open.nc(filenames[j])
    WRF_file <- read.nc(WRF_file)
    name_vari <- names(WRF_file)
    name <- str_sub(filenames[j], start = 1, end = -14)
    
    # all concnetrations ar in ug/m3
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
    DateTime <- paste0(year,"_",month,"_", day,"_",time,"_00")
    
    
    MMM <-  t(CO[ , ,1])   # map is upside down  (only consider surface level)
    MMM <- MMM[nrow(MMM):1, ]
    r <- raster(MMM, xmn, xmx, ymn,  ymx, crs="+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")
    plot(r)
    name_time <- TS[qq]
    all_rasters <- stack(all_rasters,r)
    #  writeRaster(r, paste0(DateTime,".tif") , options= "INTERLEAVE=BAND", overwrite=T)
  }
  
  return(all_rasters)
  
}

BBB <- import_nc_WRF_CO(filenames)
writeRaster(BBB, "AQ_4km_WRFChem_2017092800_CO.tif" , options= "INTERLEAVE=BAND", overwrite=T)

##################################################################     
##### SO2  ########################################################
##################################################################

import_nc_WRF_SO2 <- function(filenames){
  # j = 1
  all_rasters <- stack()
  qq<- 0
  
  for(j in 1:length(filenames)) {
    
    qq <- qq +1
    WRF_file <- open.nc(filenames[j])
    WRF_file <- read.nc(WRF_file)
    name_vari <- names(WRF_file)
    name <- str_sub(filenames[j], start = 1, end = -14)
    
    # all concnetrations ar in ug/m3
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
    DateTime <- paste0(year,"_",month,"_", day,"_",time,"_00")
    
    
    MMM <-  t(SO2[ , ,1])   # map is upside down  (only consider surface level)
    MMM <- MMM[nrow(MMM):1, ]
    r <- raster(MMM, xmn, xmx, ymn,  ymx, crs="+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")
    plot(r)
    name_time <- TS[qq]
    all_rasters <- stack(all_rasters,r)
    #  writeRaster(r, paste0(DateTime,".tif") , options= "INTERLEAVE=BAND", overwrite=T)
  }
  
  return(all_rasters)
  
}

BBB <- import_nc_WRF_SO2(filenames)
writeRaster(BBB, "AQ_4km_WRFChem_2017092800_SO2.tif" , options= "INTERLEAVE=BAND", overwrite=T)

##### O3  ########################################################
##################################################################

import_nc_WRF_O3 <- function(filenames){
  # j = 1
  all_rasters <- stack()
  qq<- 0
  
  for(j in 1:length(filenames)) {
    
    qq <- qq +1
    WRF_file <- open.nc(filenames[j])
    WRF_file <- read.nc(WRF_file)
    name_vari <- names(WRF_file)
    name <- str_sub(filenames[j], start = 1, end = -14)
    
    # all concnetrations ar in ug/m3
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
    DateTime <- paste0(year,"_",month,"_", day,"_",time,"_00")
    
    
    MMM <-  t(O3[ , ,1])   # map is upside down  (only consider surface level)
    MMM <- MMM[nrow(MMM):1, ]
    r <- raster(MMM, xmn, xmx, ymn,  ymx, crs="+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")
    plot(r)
    name_time <- TS[qq]
    all_rasters <- stack(all_rasters,r)
    #  writeRaster(r, paste0(DateTime,".tif") , options= "INTERLEAVE=BAND", overwrite=T)
  }
  
  return(all_rasters)
  
}

BBB <- import_nc_WRF_O3(filenames)
writeRaster(BBB, "AQ_4km_WRFChem_2017092800_O3.tif" , options= "INTERLEAVE=BAND", overwrite=T)




#########################################################################################
#### plot maps ##########################################################################

library(leaflet)
library(webshot)
library(htmlwidgets)
library(RColorBrewer)
library(raster)
library(classInt)
library(stringr)
library(ggplot2)

library(RNetCDF)
library(rgdal)
library(ncdf4)
library(raster)
library(stringr)
library(gstat)

library(viridis)
library(lattice)

#### import the Arabian Peninsusula domain #############

# dir_ME <- "Z:/_SHARED_FOLDERS/Air Quality/Phase 2/Dust_Event_UAE_2015/WRFChem_domain"
dir_ME <- "D:/Dust_Event_UAE_2015/WRFChem_domain"
### shapefile for WRF_domain
shp_ME <- readOGR(dsn = dir_ME, layer = "ADMIN_domain_d01_4km_WRFChem")
shp_ME <- spTransform(shp_ME, CRS("+init=epsg:4326"))

plot(shp_ME)

# gerate a time sequence for a given day every 60 minuntes 
start <- as.POSIXct("2017-09-28 00:01")
interval <- 60 #minutes
end <- start + as.difftime(6, units="days")
TS <- seq(from=start, by=interval*60, to=end)
TS <- TS[1:5]


##################################################################     
##### PM10  ######################################################
##################################################################

# set directory where we want to save the images
setwd("D:/Op_WRF_Chem/2017092800/images_png/4km_PM10")
# setwd("Z:/_SHARED_FOLDERS/Air Quality/Phase 2/Op_WRF_Chem/2017092800/images_png")
# setwd("Z:/_SHARED_FOLDERS/Air Quality/Phase 2/Dust_Event_UAE_2015/WRF_trial_runs/images_png")

# i = 4

# load raster stack ---------------------------------

WRF_STACK_image <- stack("D:/Op_WRF_Chem/2017092800/AQ_4km_WRFChem_2017092800_PM10.tif")
output_folder <- "D:/Op_WRF_Chem/2017092800/images_png/4km_PM10/"

####### color pallet

vec_all <- as.vector(WRF_STACK_image)

min_val<- (min(vec_all,  na.rm = T))
# min_val <- 0
max_val<- (max(vec_all, na.rm = T))
# max_val <- 30



stat_dat <- summary(as.vector(WRF_STACK_image))
IQR <- (as.numeric((stat_dat[5]-stat_dat[2])* 2))# n is the space after IQR

low_IQR<- if(floor(min_val) > floor(as.numeric((stat_dat[2]- IQR)))) floor(min_val) else floor(as.numeric((stat_dat[2]- IQR)))
high_IQR <-if ( max_val > (as.numeric((stat_dat[5]+IQR)))) max_val else (as.numeric((stat_dat[5]+IQR)))

# cool = rainbow(25, start=rgb2hsv(col2rgb('cyan'))[1], end=rgb2hsv(col2rgb('blue'))[1])
cool = rainbow(50, start=rgb2hsv(col2rgb('green'))[1], end=rgb2hsv(col2rgb('royalblue2'))[1])
cool_2 = rainbow(25, start=rgb2hsv(col2rgb('yellow'))[1], end=rgb2hsv(col2rgb('green'))[1])
warm = rainbow(125, start=rgb2hsv(col2rgb('red'))[1], end=rgb2hsv(col2rgb('yellow'))[1])
cols = c(rev(cool), rev(cool_2), rev(warm))

# i <- 3


########################
### plots of maps ######
########################

MASS_images <- stack("D:/Op_WRF_Chem/2017092800/AQ_4km_WRFChem_2017092800_PM10.tif")

for (i in 1:length(MASS_images@layers)) {
  TITLE <- paste(TS[i], " (UTC)")
  name_time <- TS[i]
  MASS_images <- raster("D:/Op_WRF_Chem/2017092800/AQ_4km_WRFChem_2017092800_PM10.tif", band = i)
  # plot(MASS_images)
  
  h <- rasterVis::levelplot(MASS_images, 
                            margin=FALSE, main= as.character(TITLE),
                            xlab = "",
                            ylab = "",
                            ## about colorbar
                            colorkey=list(
                              space='bottom',                   
                              labels= list(at= floor(as.numeric( seq(low_IQR, high_IQR, length.out=7))),
                                           font=3),
                              axis.line=list(col='black'),
                              width=1.2
                              # title=expression(paste("            mass") )  
                              # title=expression(paste("           ",PM[10], " (µg/",m^3, ")"))
                            ),   
                            ## about the axis
                            par.settings=list(
                              strip.border=list(col='transparent'),
                              strip.background=list(col='transparent'),
                              axis.line=list(col='black')
                            ),
                            scales=list(draw=T, alternating= F),            
                            #col.regions = colorRampPalette(c("blue", "white","red"))(1e3),
                            col.regions = cols,
                            at=unique(c(seq(low_IQR, high_IQR, length.out=200))),
                            names.attr=rep(names(MASS_images))) +
    latticeExtra::layer(sp.polygons(shp_ME))
  h
  
  png(paste0(output_folder ,str_sub(name_time, start = 1, end = -10), "_",
             str_sub(name_time, start = 12, end = -7), "_",
             str_sub(name_time, start = 15, end = -4),
             ".png"), width = 900, height = 900,
      units = "px", pointsize = 50,
      bg = "white", res = 200)
  print(h)
  dev.off()
  
}


##################################################################     
##### PM2.5  ######################################################
##################################################################

# load raster stack ---------------------------------

WRF_STACK_image <- stack("D:/Op_WRF_Chem/2017092800/AQ_4km_WRFChem_2017092800_PM25.tif")
output_folder <- "D:/Op_WRF_Chem/2017092800/images_png/4km_PM25/"

####### color pallet

vec_all <- as.vector(WRF_STACK_image)

min_val<- (min(vec_all,  na.rm = T))
# min_val <- 0
max_val<- (max(vec_all, na.rm = T))
# max_val <- 30



stat_dat <- summary(as.vector(WRF_STACK_image))
IQR <- (as.numeric((stat_dat[5]-stat_dat[2])* 2))# n is the space after IQR

low_IQR<- if(floor(min_val) > floor(as.numeric((stat_dat[2]- IQR)))) floor(min_val) else floor(as.numeric((stat_dat[2]- IQR)))
high_IQR <-if ( max_val > (as.numeric((stat_dat[5]+IQR)))) max_val else (as.numeric((stat_dat[5]+IQR)))

# cool = rainbow(25, start=rgb2hsv(col2rgb('cyan'))[1], end=rgb2hsv(col2rgb('blue'))[1])
cool = rainbow(50, start=rgb2hsv(col2rgb('green'))[1], end=rgb2hsv(col2rgb('royalblue2'))[1])
cool_2 = rainbow(25, start=rgb2hsv(col2rgb('yellow'))[1], end=rgb2hsv(col2rgb('green'))[1])
warm = rainbow(125, start=rgb2hsv(col2rgb('red'))[1], end=rgb2hsv(col2rgb('yellow'))[1])
cols = c(rev(cool), rev(cool_2), rev(warm))

# i <- 3


########################
### plots of maps ######
########################

MASS_images <- stack("D:/Op_WRF_Chem/2017092800/AQ_4km_WRFChem_2017092800_PM25.tif")

for (i in 1:length(MASS_images@layers)) {
  TITLE <- paste(TS[i], " (UTC)")
  name_time <- TS[i]
  MASS_images <- raster("D:/Op_WRF_Chem/2017092800/AQ_4km_WRFChem_2017092800_PM25.tif", band = i)
  # plot(MASS_images)
  
  h <- rasterVis::levelplot(MASS_images, 
                            margin=FALSE, main= as.character(TITLE),
                            xlab = "",
                            ylab = "",
                            ## about colorbar
                            colorkey=list(
                              space='bottom',                   
                              labels= list(at= floor(as.numeric( seq(low_IQR, high_IQR, length.out=7))),
                                           font=3),
                              axis.line=list(col='black'),
                              width=1.2
                              # title=expression(paste("            mass") )  
                              # title=expression(paste("           ",PM[10], " (µg/",m^3, ")"))
                            ),   
                            ## about the axis
                            par.settings=list(
                              strip.border=list(col='transparent'),
                              strip.background=list(col='transparent'),
                              axis.line=list(col='black')
                            ),
                            scales=list(draw=T, alternating= F),            
                            #col.regions = colorRampPalette(c("blue", "white","red"))(1e3),
                            col.regions = cols,
                            at=unique(c(seq(low_IQR, high_IQR, length.out=200))),
                            names.attr=rep(names(MASS_images))) +
    latticeExtra::layer(sp.polygons(shp_ME))
  h
  
  png(paste0(output_folder ,str_sub(name_time, start = 1, end = -10), "_",
             str_sub(name_time, start = 12, end = -7), "_",
             str_sub(name_time, start = 15, end = -4),
             ".png"), width = 900, height = 900,
      units = "px", pointsize = 50,
      bg = "white", res = 200)
  print(h)
  dev.off()
  
}


##################################################################     
##### CO  ########################################################
##################################################################

# load raster stack ---------------------------------

WRF_STACK_image <- stack("D:/Op_WRF_Chem/2017092800/AQ_4km_WRFChem_2017092800_CO.tif")
output_folder <- "D:/Op_WRF_Chem/2017092800/images_png/4km_CO/"

####### color pallet

vec_all <- as.vector(WRF_STACK_image)

min_val<- (min(vec_all,  na.rm = T))
# min_val <- 0
max_val<- (max(vec_all, na.rm = T))
# max_val <- 30



stat_dat <- summary(as.vector(WRF_STACK_image))
IQR <- (as.numeric((stat_dat[5]-stat_dat[2]))) # n is the space after IQR

low_IQR<- if(floor(min_val) > floor(as.numeric((stat_dat[2]- IQR)))) floor(min_val) else floor(as.numeric((stat_dat[2]- IQR)))
high_IQR <-if ( max_val > (as.numeric((stat_dat[5]+IQR)))) max_val else (as.numeric((stat_dat[5]+IQR)))

# cool = rainbow(25, start=rgb2hsv(col2rgb('cyan'))[1], end=rgb2hsv(col2rgb('blue'))[1])
cool = rainbow(50, start=rgb2hsv(col2rgb('green'))[1], end=rgb2hsv(col2rgb('royalblue2'))[1])
cool_2 = rainbow(25, start=rgb2hsv(col2rgb('yellow'))[1], end=rgb2hsv(col2rgb('green'))[1])
warm = rainbow(125, start=rgb2hsv(col2rgb('red'))[1], end=rgb2hsv(col2rgb('yellow'))[1])
cols = c(rev(cool), rev(cool_2), rev(warm))

# i <- 3


########################
### plots of maps ######
########################

MASS_images <- stack("D:/Op_WRF_Chem/2017092800/AQ_4km_WRFChem_2017092800_CO.tif")

for (i in 1:length(MASS_images@layers)) {
  TITLE <- paste(TS[i], " (UTC)")
  name_time <- TS[i]
  MASS_images <- raster("D:/Op_WRF_Chem/2017092800/AQ_4km_WRFChem_2017092800_CO.tif", band = i)
  # plot(MASS_images)
  
  h <- rasterVis::levelplot(MASS_images, 
                            margin=FALSE, main= as.character(TITLE),
                            xlab = "",
                            ylab = "",
                            ## about colorbar
                            colorkey=list(
                              space='bottom',                   
                              labels= list(at= floor(as.numeric( seq(low_IQR, high_IQR, length.out=7))),
                                           font=3),
                              axis.line=list(col='black'),
                              width=1.2
                              # title=expression(paste("            mass") )  
                              # title=expression(paste("           ",PM[10], " (µg/",m^3, ")"))
                            ),   
                            ## about the axis
                            par.settings=list(
                              strip.border=list(col='transparent'),
                              strip.background=list(col='transparent'),
                              axis.line=list(col='black')
                            ),
                            scales=list(draw=T, alternating= F),            
                            #col.regions = colorRampPalette(c("blue", "white","red"))(1e3),
                            col.regions = cols,
                            at=unique(c(seq(low_IQR, high_IQR, length.out=200))),
                            names.attr=rep(names(MASS_images))) +
    latticeExtra::layer(sp.polygons(shp_ME))
  h
  
  png(paste0(output_folder ,str_sub(name_time, start = 1, end = -10), "_",
             str_sub(name_time, start = 12, end = -7), "_",
             str_sub(name_time, start = 15, end = -4),
             ".png"), width = 900, height = 900,
      units = "px", pointsize = 50,
      bg = "white", res = 200)
  print(h)
  dev.off()
  
}


##################################################################     
##### NO2 ########################################################
##################################################################

# load raster stack ---------------------------------

WRF_STACK_image <- stack("D:/Op_WRF_Chem/2017092800/AQ_4km_WRFChem_2017092800_NO2.tif")
output_folder <- "D:/Op_WRF_Chem/2017092800/images_png/4km_NO2/"

####### color pallet

vec_all <- as.vector(WRF_STACK_image)

min_val<- (min(vec_all,  na.rm = T))
# min_val <- 0
max_val<- (max(vec_all, na.rm = T))
# max_val <- 30


stat_dat <- summary(as.vector(WRF_STACK_image))
IQR <- (as.numeric((stat_dat[5]-stat_dat[2]))) # n is the space after IQR

low_IQR<- if(floor(min_val) > floor(as.numeric((stat_dat[2]- IQR)))) floor(min_val) else floor(as.numeric((stat_dat[2]- IQR)))
high_IQR <-if ( max_val > (as.numeric((stat_dat[5]+IQR)))) max_val else (as.numeric((stat_dat[5]+IQR)))

# cool = rainbow(25, start=rgb2hsv(col2rgb('cyan'))[1], end=rgb2hsv(col2rgb('blue'))[1])
cool = rainbow(50, start=rgb2hsv(col2rgb('green'))[1], end=rgb2hsv(col2rgb('royalblue2'))[1])
cool_2 = rainbow(25, start=rgb2hsv(col2rgb('yellow'))[1], end=rgb2hsv(col2rgb('green'))[1])
warm = rainbow(125, start=rgb2hsv(col2rgb('red'))[1], end=rgb2hsv(col2rgb('yellow'))[1])
cols = c(rev(cool), rev(cool_2), rev(warm))

# i <- 3


########################
### plots of maps ######
########################

MASS_images <- stack("D:/Op_WRF_Chem/2017092800/AQ_4km_WRFChem_2017092800_NO2.tif")

for (i in 1:length(MASS_images@layers)) {
  TITLE <- paste(TS[i], " (UTC)")
  name_time <- TS[i]
  MASS_images <- raster("D:/Op_WRF_Chem/2017092800/AQ_4km_WRFChem_2017092800_NO2.tif", band = i)
  # plot(MASS_images)
  
  h <- rasterVis::levelplot(MASS_images, 
                            margin=FALSE, main= as.character(TITLE),
                            xlab = "",
                            ylab = "",
                            ## about colorbar
                            colorkey=list(
                              space='bottom',                   
                              labels= list(at= floor(as.numeric( seq(low_IQR, high_IQR, length.out=7))),
                                           font=3),
                              axis.line=list(col='black'),
                              width=1.2
                              # title=expression(paste("            mass") )  
                              # title=expression(paste("           ",PM[10], " (µg/",m^3, ")"))
                            ),   
                            ## about the axis
                            par.settings=list(
                              strip.border=list(col='transparent'),
                              strip.background=list(col='transparent'),
                              axis.line=list(col='black')
                            ),
                            scales=list(draw=T, alternating= F),            
                            #col.regions = colorRampPalette(c("blue", "white","red"))(1e3),
                            col.regions = cols,
                            at=unique(c(seq(low_IQR, high_IQR, length.out=200))),
                            names.attr=rep(names(MASS_images))) +
    latticeExtra::layer(sp.polygons(shp_ME))
  h
  
  png(paste0(output_folder ,str_sub(name_time, start = 1, end = -10), "_",
             str_sub(name_time, start = 12, end = -7), "_",
             str_sub(name_time, start = 15, end = -4),
             ".png"), width = 900, height = 900,
      units = "px", pointsize = 50,
      bg = "white", res = 200)
  print(h)
  dev.off()
  
}


##################################################################     
##### SO2 ########################################################
##################################################################

# load raster stack ---------------------------------

WRF_STACK_image <- stack("D:/Op_WRF_Chem/2017092800/AQ_4km_WRFChem_2017092800_SO2.tif")
output_folder <- "D:/Op_WRF_Chem/2017092800/images_png/4km_SO2/"

####### color pallet

vec_all <- as.vector(WRF_STACK_image)

min_val<- (min(vec_all,  na.rm = T))
# min_val <- 0
max_val<- (max(vec_all, na.rm = T))
# max_val <- 30


stat_dat <- summary(as.vector(WRF_STACK_image))
IQR <- (as.numeric((stat_dat[5]-stat_dat[2]))) # n is the space after IQR

low_IQR<- if(floor(min_val) > floor(as.numeric((stat_dat[2]- IQR)))) floor(min_val) else floor(as.numeric((stat_dat[2]- IQR)))
high_IQR <-if ( max_val > (as.numeric((stat_dat[5]+IQR)))) max_val else (as.numeric((stat_dat[5]+IQR)))

# cool = rainbow(25, start=rgb2hsv(col2rgb('cyan'))[1], end=rgb2hsv(col2rgb('blue'))[1])
cool = rainbow(50, start=rgb2hsv(col2rgb('green'))[1], end=rgb2hsv(col2rgb('royalblue2'))[1])
cool_2 = rainbow(25, start=rgb2hsv(col2rgb('yellow'))[1], end=rgb2hsv(col2rgb('green'))[1])
warm = rainbow(125, start=rgb2hsv(col2rgb('red'))[1], end=rgb2hsv(col2rgb('yellow'))[1])
cols = c(rev(cool), rev(cool_2), rev(warm))

# i <- 3


########################
### plots of maps ######
########################

MASS_images <- stack("D:/Op_WRF_Chem/2017092800/AQ_4km_WRFChem_2017092800_SO2.tif")

for (i in 1:length(MASS_images@layers)) {
  TITLE <- paste(TS[i], " (UTC)")
  name_time <- TS[i]
  MASS_images <- raster("D:/Op_WRF_Chem/2017092800/AQ_4km_WRFChem_2017092800_SO2.tif", band = i)
  # plot(MASS_images)
  
  h <- rasterVis::levelplot(MASS_images, 
                            margin=FALSE, main= as.character(TITLE),
                            xlab = "",
                            ylab = "",
                            ## about colorbar
                            colorkey=list(
                              space='bottom',                   
                              labels= list(at= floor(as.numeric( seq(low_IQR, high_IQR, length.out=7))),
                                           font=3),
                              axis.line=list(col='black'),
                              width=1.2
                              # title=expression(paste("            mass") )  
                              # title=expression(paste("           ",PM[10], " (µg/",m^3, ")"))
                            ),   
                            ## about the axis
                            par.settings=list(
                              strip.border=list(col='transparent'),
                              strip.background=list(col='transparent'),
                              axis.line=list(col='black')
                            ),
                            scales=list(draw=T, alternating= F),            
                            #col.regions = colorRampPalette(c("blue", "white","red"))(1e3),
                            col.regions = cols,
                            at=unique(c(seq(low_IQR, high_IQR, length.out=200))),
                            names.attr=rep(names(MASS_images))) +
    latticeExtra::layer(sp.polygons(shp_ME))
  h
  
  png(paste0(output_folder ,str_sub(name_time, start = 1, end = -10), "_",
             str_sub(name_time, start = 12, end = -7), "_",
             str_sub(name_time, start = 15, end = -4),
             ".png"), width = 900, height = 900,
      units = "px", pointsize = 50,
      bg = "white", res = 200)
  print(h)
  dev.off()
  
}



##################################################################     
##### O3 ########################################################
##################################################################

# load raster stack ---------------------------------

WRF_STACK_image <- stack("D:/Op_WRF_Chem/2017092800/AQ_4km_WRFChem_2017092800_O3.tif")
output_folder <- "D:/Op_WRF_Chem/2017092800/images_png/4km_O3/"

####### color pallet

vec_all <- as.vector(WRF_STACK_image)

min_val<- (min(vec_all,  na.rm = T))
# min_val <- 0
max_val<- (max(vec_all, na.rm = T))
# max_val <- 30


stat_dat <- summary(as.vector(WRF_STACK_image))
IQR <- (as.numeric((stat_dat[5]-stat_dat[2]))) # n is the space after IQR

low_IQR<- if(floor(min_val) > floor(as.numeric((stat_dat[2]- IQR)))) floor(min_val) else floor(as.numeric((stat_dat[2]- IQR)))
high_IQR <-if ( max_val > (as.numeric((stat_dat[5]+IQR)))) max_val else (as.numeric((stat_dat[5]+IQR)))

# cool = rainbow(25, start=rgb2hsv(col2rgb('cyan'))[1], end=rgb2hsv(col2rgb('blue'))[1])
cool = rainbow(50, start=rgb2hsv(col2rgb('green'))[1], end=rgb2hsv(col2rgb('royalblue2'))[1])
cool_2 = rainbow(25, start=rgb2hsv(col2rgb('yellow'))[1], end=rgb2hsv(col2rgb('green'))[1])
warm = rainbow(125, start=rgb2hsv(col2rgb('red'))[1], end=rgb2hsv(col2rgb('yellow'))[1])
cols = c(rev(cool), rev(cool_2), rev(warm))

# i <- 3


########################
### plots of maps ######
########################

MASS_images <- stack("D:/Op_WRF_Chem/2017092800/AQ_4km_WRFChem_2017092800_O3.tif")

for (i in 1:length(MASS_images@layers)) {
  TITLE <- paste(TS[i], " (UTC)")
  name_time <- TS[i]
  MASS_images <- raster("D:/Op_WRF_Chem/2017092800/AQ_4km_WRFChem_2017092800_O3.tif", band = i)
  # plot(MASS_images)
  
  h <- rasterVis::levelplot(MASS_images, 
                            margin=FALSE, main= as.character(TITLE),
                            xlab = "",
                            ylab = "",
                            ## about colorbar
                            colorkey=list(
                              space='bottom',                   
                              labels= list(at= floor(as.numeric( seq(low_IQR, high_IQR, length.out=7))),
                                           font=3),
                              axis.line=list(col='black'),
                              width=1.2
                              # title=expression(paste("            mass") )  
                              # title=expression(paste("           ",PM[10], " (µg/",m^3, ")"))
                            ),   
                            ## about the axis
                            par.settings=list(
                              strip.border=list(col='transparent'),
                              strip.background=list(col='transparent'),
                              axis.line=list(col='black')
                            ),
                            scales=list(draw=T, alternating= F),            
                            #col.regions = colorRampPalette(c("blue", "white","red"))(1e3),
                            col.regions = cols,
                            at=unique(c(seq(low_IQR, high_IQR, length.out=200))),
                            names.attr=rep(names(MASS_images))) +
    latticeExtra::layer(sp.polygons(shp_ME))
  h
  
  png(paste0(output_folder ,str_sub(name_time, start = 1, end = -10), "_",
             str_sub(name_time, start = 12, end = -7), "_",
             str_sub(name_time, start = 15, end = -4),
             ".png"), width = 900, height = 900,
      units = "px", pointsize = 50,
      bg = "white", res = 200)
  print(h)
  dev.off()
  
}


# to make a movie.......
# to use with ImageMagik using the commnad line cmd in windows
# cd into the directory where there are the png files
# magick -delay 50 -loop 0 *.png WRF_Chem_DUST_event_02_April_2015.gif



