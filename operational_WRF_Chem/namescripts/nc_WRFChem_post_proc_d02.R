
library(RNetCDF)
library(rgdal)
library(ncdf4)
library(raster)
library(stringr)
library(gstat)


# list .nc files
# 4km
setwd("/research/cesam/AirQuality/WRF_outputs/")
dirs <- list.dirs()
# get the most recent directory
dirs <- sort(dirs, decreasing = T)

folder_day <- str_sub(dirs[1], start = 3, end = -1)

setwd(paste0("/research/cesam/AirQuality/WRF_outputs/", folder_day))

filenames <- list.files(pattern = c("d02", ".nc"))
filenames <- filenames
# filenames <- filenames[1:4]

#############################################
## function to import multiple .nc files ####
#############################################

# filenames <- filenames[1]


# gerate a time sequence for the WRF-Chem run at intervals of 1 hour (should be 145 images), 6 days
start <- as.POSIXct("2017-09-28 00:01")
interval <- 60 #minutes
end <- start + as.difftime(6, units="days")
TS <- seq(from=start, by=interval*60, to=end)
TS <- TS[1:5]


  ######
  #### looping the variables of the nc files

 # j = 1
qq <- 0

   for(j in 1:length(filenames)) {
     qq <- qq +1
     WRF_file <- open.nc(filenames[j])
     WRF_file <- read.nc(WRF_file)
     name_vari <- names(WRF_file)
     name <- str_sub(filenames[j], start = 1, end = -14)
     
     PM10 <- (WRF_file[32])    #  total PM10
     PM25 <- (WRF_file[33])    #  total PM2.5
     names(PM10)<- "xxyyzz"
     names(PM25)<- "xxyyzz"
     PM10 <- (PM10$xxyyzz)
     PM25 <- (PM25$xxyyzz)
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
     

#################     
##### PM10  #####
#################     
    
    MMM <-  t(PM10[ , ,1])   # map is upside down  (only consider surface level)
    MMM <- MMM[nrow(MMM):1, ]
    r <- raster(MMM, xmn, xmx, ymn,  ymx, crs="+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")
   # plot(r)
    writeRaster(r, paste0(DateTime,".tif") , options= "INTERLEAVE=BAND", overwrite=T)
   }
  

res(r)

# to make a movie.......
# to use with ImageMagik using the commnad line cmd in windows
# cd into the directory where there are the png files
# magick -delay 50 -loop 0 *.png WRF_Chem_DUST_event_02_April_2015.gif



