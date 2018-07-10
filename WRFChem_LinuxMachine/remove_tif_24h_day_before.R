

library(raster)
library(dplyr)
library(rgdal)
library(stringr)
library(lubridate)
library(RNetCDF)
library(ncdf4)
library(gstat)


date <- commandArgs(trailingOnly = TRUE)
date
# date <- "2018051000"

today_folder_O3 <- paste0("/research/cesam/WRFChem_outputs/", date, "/O3")
today_folder_CO <- paste0("/research/cesam/WRFChem_outputs/", date, "/CO")
today_folder_SO2 <- paste0("/research/cesam/WRFChem_outputs/", date, "/SO2")
today_folder_NO2 <- paste0("/research/cesam/WRFChem_outputs/", date, "/NO2")
today_folder_PM25 <- paste0("/research/cesam/WRFChem_outputs/", date, "/PM25")
today_folder_PM10 <- paste0("/research/cesam/WRFChem_outputs/", date, "/PM10")

files_O3 <- list.files(today_folder_O3, ".tif$")
files_O3_24h <- paste0(today_folder_O3, "/",files_O3[1:24])
if (file.exists(files_O3_24h)) file.remove(files_O3_24h) 

files_CO <- list.files(today_folder_CO, ".tif$")
files_CO_24h <- paste0(today_folder_CO, "/",files_CO[1:24])
if (file.exists(files_CO_24h)) file.remove(files_CO_24h) 

files_SO2 <- list.files(today_folder_SO2, ".tif$")
files_SO2_24h <- paste0(today_folder_SO2, "/",files_SO2[1:24])
if (file.exists(files_SO2_24h)) file.remove(files_SO2_24h) 

files_NO2 <- list.files(today_folder_NO2, ".tif$")
files_NO2_24h <- paste0(today_folder_NO2, "/",files_NO2[1:24])
if (file.exists(files_NO2_24h)) file.remove(files_NO2_24h) 

files_PM25 <- list.files(today_folder_PM25, ".tif$")
files_PM25_24h <- paste0(today_folder_PM25, "/",files_PM25[1:24])
if (file.exists(files_PM25_24h)) file.remove(files_PM25_24h) 

files_PM10 <- list.files(today_folder_PM10, ".tif$")
files_PM25_24h <- paste0(today_folder_PM10, "/",files_PM10[1:24])
if (file.exists(files_PM25_24h)) file.remove(files_PM25_24h) 


