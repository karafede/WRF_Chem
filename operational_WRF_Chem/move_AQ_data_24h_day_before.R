

# move the first 24h data for PM10, PM2.5, CO, NO2, SO2 and NO2 from the previous day to the current day

library(raster)
library(dplyr)
library(rgdal)
library(stringr)
library(lubridate)
library(RNetCDF)
library(ncdf4)
library(gstat)


data <- commandArgs(trailingOnly = TRUE)

date <- data[1]
date_yesterday <- data[2]

# date_yesterday <- commandArgs(trailingOnly = TRUE)
# date_yesterday

# date_yesterday <- "2018051300"
# date <- "2018051400"

yesterday_folder_O3 <- paste0("/research/cesam/WRFChem_outputs/", date_yesterday,"/O3")
yesterday_folder_CO <- paste0("/research/cesam/WRFChem_outputs/", date_yesterday,"/CO")
yesterday_folder_SO2 <- paste0("/research/cesam/WRFChem_outputs/", date_yesterday,"/SO2")
yesterday_folder_NO2 <- paste0("/research/cesam/WRFChem_outputs/", date_yesterday,"/NO2")
yesterday_folder_PM10 <- paste0("/research/cesam/WRFChem_outputs/", date_yesterday,"/PM10")
yesterday_folder_PM25 <- paste0("/research/cesam/WRFChem_outputs/", date_yesterday,"/PM25")

today_folder_O3 <- paste0("/research/cesam/WRFChem_outputs/", date, "/O3")
today_folder_CO <- paste0("/research/cesam/WRFChem_outputs/", date, "/CO")
today_folder_SO2 <- paste0("/research/cesam/WRFChem_outputs/", date, "/SO2")
today_folder_NO2 <- paste0("/research/cesam/WRFChem_outputs/", date, "/NO2")
today_folder_PM25 <- paste0("/research/cesam/WRFChem_outputs/", date, "/PM25")
today_folder_PM10 <- paste0("/research/cesam/WRFChem_outputs/", date, "/PM10")


files_O3 <- list.files(yesterday_folder_O3, ".tif$")
files_O3_24h <- paste0(yesterday_folder_O3, "/",files_O3[1:24])

files_CO <- list.files(yesterday_folder_CO, ".tif$")
files_CO_24h <- paste0(yesterday_folder_CO, "/",files_CO[1:24])

files_SO2 <- list.files(yesterday_folder_SO2, ".tif$")
files_SO2_24h <- paste0(yesterday_folder_SO2, "/",files_SO2[1:24])

files_NO2 <- list.files(yesterday_folder_NO2, ".tif$")
files_NO2_24h <- paste0(yesterday_folder_NO2, "/",files_NO2[1:24])

files_PM25 <- list.files(yesterday_folder_PM25, ".tif$")
files_PM25_24h <- paste0(yesterday_folder_PM25, "/",files_PM25[1:24])

files_PM10 <- list.files(yesterday_folder_PM10, ".tif$")
files_PM10_24h <- paste0(yesterday_folder_PM10, "/",files_PM10[1:24])

# copy the files to the new folder
file.copy(files_O3_24h, today_folder_O3)
file.copy(files_CO_24h, today_folder_CO)
file.copy(files_SO2_24h, today_folder_SO2)
file.copy(files_NO2_24h, today_folder_NO2)
file.copy(files_PM25_24h, today_folder_PM25)
file.copy(files_PM10_24h, today_folder_PM10)




