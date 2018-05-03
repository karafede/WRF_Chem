

library(readr)
library(sp)
library(raster)
library(gstat)
library(rgdal)
library(RNetCDF)
library(ncdf4)
library(stringr)
library(rgeos)
library(leaflet)
library(htmlwidgets)
library(dplyr)
library(spatialEco)

# load function to calculte Air Quality Indexes
source("Z:/_SHARED_FOLDERS/Air Quality/Phase 2/AQ_TIDY_Data/Scripts/aqi_fun_UAE.R")


#########################
### shapefile UAE #######
#########################

dir <- "Z:/_SHARED_FOLDERS/Air Quality/Phase 2/HISTORICAL_dust/UAE_boundary"
### shapefile for UAE
shp_UAE <- readOGR(dsn = dir, layer = "uae_emirates")

# ----- Transform to EPSG 4326 - WGS84 (required)
shp_UAE <- spTransform(shp_UAE, CRS("+init=epsg:4326"))
# names(shp)

shp_UAE@data$name <- 1:nrow(shp_UAE)
# plot(shp_rect)
# plot(shp_UAE, add=TRUE, lwd=1)

###################################
## shapefile Arabian Peninsual ####
###################################

dir <- "Z:/_SHARED_FOLDERS/Air Quality/Phase 2/MODIS_AOD/WRFChem_domain"
shp_AP <- readOGR(dsn = dir, layer = "ADMIN_domain_d01_WRFChem")

# ----- Transform to EPSG 4326 - WGS84 (required)
shp_AP <- spTransform(shp_AP, CRS("+init=epsg:4326"))
# names(shp)

shp_AP@data$name <- 1:nrow(shp_AP)
plot(shp_UAE)
plot(shp_AP, add=TRUE, lwd=1)


##################################################
# make a point for a location in the UAE #########
##################################################

require(sf)

# load coordinates of all UAE Airports
# coordinates_UAE <- read.table(text="
#                               longitude    latitude ID
#                               54.65    24.433  AbuDhabi
#                               55.333   25.25  Dubai 
#                               55.609   24.262  AlAin
#                               55.517   25.329  Sharjah
#                               56.20   25.16  Fujairah
#                               53.633  23.633  MedinaZayed
#                               54.548  24.248  AlDhafra
#                               54.458  24.428  Bateen
#                               55.172  24.886  AlMaktoum
#                               55.939  25.613  Rak
#                               53.383  23.617 Buhasa
#                               53.65   23.0355 LiwaOasis
#                               55.71   25.52 UmmAlQuwain
#                               52.72   24.104 Ruwais",
#                               header=TRUE)


# load coordinates of all UAE Air Quality Monitoring Stations
coordinates_UAE <- read.table(text="
                              longitude latitude ID
                              55.31303  25.26761 Deira
                              55.30867  25.2432   Karama
                              55.29868  25.23641  Zabeel
                              55.24624  25.18832  Safa
                              55.11259  25.02944  JEBEL_ALI_VILLAGE
                              55.15958  25.07445  EMIRATES_HILLS
                              55.38628  25.24732  DUBAI_AIRPORT
                              55.45727  25.22006  MUSHRIF
                              56.13181  24.81787  Hatta
                              55.08423  25.0075   JEBEL_ALI_PORT
                              55.42918  25.15181  Warsan
                              55.28185  25.22005  SHK_ZAYED_ROAD
                              55.2716   25.05803  SHK_MOHD_BIN_ZAYED_ROAD
                              54.36372  24.48893  Hamdan_Street
                              54.36933  24.48156  Khadeja_Primary_School
                              54.40843  24.43009  Khalifa_High_School
                              54.50288  24.3472   Mussafah
                              54.63593  24.32134  Baniyas_School
                              55.73486  24.21906  Al_Ain_Islamic_Ins
                              55.76583  24.22586  Al_Ain_Street
                              53.70389  23.65226  Bida_Zayed
                              52.81033  23.83551  Gayathi_School
                              53.60641  23.09579  Liwa_Oasis
                              52.7548   24.09086  Al_Ruwais
                              53.74529  23.7504   Habshan
                              53.88531  24.03516  E11_Road
                              54.5161   24.40352  Bain_Aljesrain
                              54.5782   24.41992  Khalifa_City_A
                              54.58888  24.28628  Al_Mafraq
                              55.34288  24.46666  Sweihan
                              55.70487  24.25918  Al_Tawia
                              55.70211  24.16347  Zakher
                              55.48596  23.53115  Al_Quaa
                              56.00091  25.45524  Al_Hamriyah
                              56.32919  25.07049  Kalba
                              55.50785  25.39948  Rashidyah
                              55.4666   25.40044  Elderly_House
                              56.10978  26.03305  Al_Jeer
                              56.00352  25.78242  Burairat
                              55.94676  25.79208  Al_Qasimiyah
                              56.07875  25.99972  Ghalilah",
                              header=TRUE)
                              
                              

coordinates_UAE <- st_as_sf(x = coordinates_UAE, 
                            coords = c("longitude", "latitude"),
                            crs = "+proj=longlat +datum=WGS84")

# convert to sp object if needed
coordinates_UAE_point <- as(coordinates_UAE, "Spatial")
setwd("Z:/_SHARED_FOLDERS/Air Quality/Phase 2/AQI_WRFChem/shapes")
shapefile(coordinates_UAE_point, "points.shp", overwrite=TRUE)

dir <- "Z:/_SHARED_FOLDERS/Air Quality/Phase 2/AQI_WRFChem/shapes"
points <- readOGR(dsn = dir, layer = "points")
plot(points)
# add a buffer around each point
shp_buff <- gBuffer(points, width=0.075, byid=TRUE)
shp_buff <- spTransform(shp_buff, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))
plot(shp_buff)
plot(shp_UAE, add=TRUE, lwd=1)
plot(shp_AP, add=TRUE, lwd=1)

# save shp file for the circular buffer
setwd("Z:/_SHARED_FOLDERS/Air Quality/Phase 2/AQI_WRFChem/shapes")
shapefile(shp_buff, "circular_buffer.shp", overwrite=TRUE)
dir <- "Z:/_SHARED_FOLDERS/Air Quality/Phase 2/AQI_WRFChem/shapes"
# reload and plot domain
shp_buff <- readOGR(dsn = dir, layer = "circular_buffer")

