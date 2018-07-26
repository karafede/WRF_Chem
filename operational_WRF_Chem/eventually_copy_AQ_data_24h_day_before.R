

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
date # date today
date_yesterday <- data[2]
date_yesterday  # date yesterday

# date_yesterday <- commandArgs(trailingOnly = TRUE)
# date_yesterday

# date_yesterday <- "2018071500"
# date <- "2018071600"

today_folder_O3 <- paste0("/research/cesam/WRFChem_outputs/", date, "/O3")
today_folder_CO <- paste0("/research/cesam/WRFChem_outputs/", date, "/CO")
today_folder_SO2 <- paste0("/research/cesam/WRFChem_outputs/", date, "/SO2")
today_folder_NO2 <- paste0("/research/cesam/WRFChem_outputs/", date, "/NO2")
today_folder_PM25 <- paste0("/research/cesam/WRFChem_outputs/", date, "/PM25")
today_folder_PM10 <- paste0("/research/cesam/WRFChem_outputs/", date, "/PM10")

yesterday_folder_O3 <- paste0("/research/cesam/WRFChem_outputs/", date_yesterday,"/O3")
yesterday_folder_CO <- paste0("/research/cesam/WRFChem_outputs/", date_yesterday,"/CO")
yesterday_folder_SO2 <- paste0("/research/cesam/WRFChem_outputs/", date_yesterday,"/SO2")
yesterday_folder_NO2 <- paste0("/research/cesam/WRFChem_outputs/", date_yesterday,"/NO2")
yesterday_folder_PM10 <- paste0("/research/cesam/WRFChem_outputs/", date_yesterday,"/PM10")
yesterday_folder_PM25 <- paste0("/research/cesam/WRFChem_outputs/", date_yesterday,"/PM25")


files_O3_yesterday <- list.files(yesterday_folder_O3, ".tif$")
files_O3_today <- list.files(today_folder_O3, ".tif$")
if (length(files_O3_today) < 24){
files_O3_24h <- paste0(yesterday_folder_O3, "/",files_O3_yesterday[1:24])
file.copy(files_O3_24h, today_folder_O3)
}else{}


files_CO_yesterday <- list.files(yesterday_folder_CO, ".tif$")
files_CO_today <- list.files(today_folder_CO, ".tif$")
if (length(files_CO_today) < 24){
  files_CO_24h <- paste0(yesterday_folder_CO, "/",files_CO_yesterday[1:24])
  file.copy(files_CO_24h, today_folder_CO)
}else{}


files_SO2_yesterday <- list.files(yesterday_folder_SO2, ".tif$")
files_SO2_today <- list.files(today_folder_SO2, ".tif$")
if (length(files_SO2_today) < 24){
  files_SO2_24h <- paste0(yesterday_folder_SO2, "/",files_SO2_yesterday[1:24])
  file.copy(files_SO2_24h, today_folder_SO2)
}else{}


files_NO2_yesterday <- list.files(yesterday_folder_NO2, ".tif$")
files_NO2_today <- list.files(today_folder_NO2, ".tif$")
if (length(files_NO2_today) < 24){
  files_NO2_24h <- paste0(yesterday_folder_NO2, "/",files_NO2_yesterday[1:24])
  file.copy(files_NO2_24h, today_folder_NO2)
}else{}


files_PM25_yesterday <- list.files(yesterday_folder_PM25, ".tif$")
files_PM25_today <- list.files(today_folder_PM25, ".tif$")
if (length(files_PM25_today) < 24){
  files_PM25_24h <- paste0(yesterday_folder_PM25, "/",files_PM25_yesterday[1:24])
  file.copy(files_PM25_24h, today_folder_PM25)
}else{}



files_PM10_yesterday <- list.files(yesterday_folder_PM10, ".tif$")
files_PM10_today <- list.files(today_folder_PM10, ".tif$")
if (length(files_PM10_today) < 24){
  files_PM10_24h <- paste0(yesterday_folder_PM10, "/",files_PM10_yesterday[1:24])
  file.copy(files_PM10_24h, today_folder_PM10)
}else{}





