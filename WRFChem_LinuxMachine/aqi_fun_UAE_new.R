
## O3 ########


aqi_O3_fun <- function(dawit){
  # converted into ppb
  
  # for the first break point I have used the value from UAE (units == ppb)
  
  if (!is.na(dawit) & dawit < 61.22 & dawit > 0)
    AQI_O3 = ((50-0)/(61.22-0)) * (dawit - 0) + 0
  

  if (!is.na(dawit) & dawit < 70 & dawit> 61.5)
    AQI_O3 = ((100-51)/(70-61.5)) * (dawit - 61.5) + 51
  
  if (!is.na(dawit) & dawit < 85 & dawit > 71)
    AQI_O3 = ((150-101)/(85-71)) * (dawit - 71) + 101


  if (!is.na(dawit) & dawit < 105 & dawit > 86)
    AQI_O3 = ((200-151)/(105-86)) * (dawit - 86) + 151


  if (!is.na(dawit) & dawit < 200 & dawit > 106)
    AQI_O3 = ((300-201)/(200-106)) * (dawit - 106) + 201
  
  
  if(is.na(dawit))
    AQI_O3 = NA
  if(exists("AQI_O3")){
  
}else {
  AQI_O3=NA
}
return(AQI_O3)
  
}
  

### CO #####
# converted into ppb

aqi_CO_fun <- function(dawit){
  
  # GOOD
  if (!is.na(dawit) & dawit < 8.69 & dawit > 0)
     AQI_CO = ((50-0)/(8.69-0)) * (dawit - 0) + 0
  
  if (!is.na(dawit) & dawit < 9.4 & dawit > 8.71)
    AQI_CO = ((100-51)/(9.4-8.71)) * (dawit - 8.71) + 51
  
  if (!is.na(dawit) & dawit < 12.4 & dawit > 9.5)
    AQI_CO = ((150-101)/(12.4-9.5)) * (dawit - 9.5) + 101
  
  if (!is.na(dawit) & dawit < 15.4 & dawit > 12.5)
    AQI_CO = ((200-151)/(15.4-12.5)) * (dawit - 12.5) + 151
  
  if (!is.na(dawit) & dawit < 30.4 & dawit > 15.5)
    AQI_CO = ((300-201)/(30.4-15.5)) * (dawit - 15.5) + 201
  
  if (!is.na(dawit) & dawit < 40.4 & dawit > 30.5)
    AQI_CO = ((400-301)/(40.4-30.5)) * (dawit - 30.5) + 301
  
  if (!is.na(dawit) & dawit < 50.4 & dawit > 40.4)
    AQI_CO = ((500-401)/(50.4-40.4)) * (dawit - 40.4) + 401
  
  if(is.na(dawit))
    AQI_CO = NA
  

  if(is.na(dawit))
    AQI_CO = NA
  if(exists("AQI_CO")){
    
  }else {
    AQI_CO=NA
  }
  return(AQI_CO)
  
}
 
### PM2.5 ######


aqi_PM25_fun <- function(dawit){
  
  # GOOD  
  
  if (!is.na(dawit) & dawit < 12 & dawit > 0)
    AQI_PM25 = ((50-0)/(12-0)) * (dawit - 0) + 0


  # if (!is.na(dawit) & dawit < 60 & dawit > 0)
  #   AQI_PM25 = ((50-0)/(60-0)) * (dawit - 0) + 0
 
   # MODERATE 
  
  if (!is.na(dawit) & dawit < 35.4 & dawit > 12.1)
    AQI_PM25 = ((100-51)/(35.4-12.1)) * (dawit - 12.1) + 51
  
  
   # UNHEALTHY for SENSITIVE GROUPS

  if (!is.na(dawit) & dawit < 55.4 & dawit > 35.5)
    AQI_PM25 = ((150-101)/(55.4-35.5)) * (dawit - 35.5) + 101
   
   # UNHEALTHY
  
  if (!is.na(dawit) & dawit < 150.4 & dawit > 55.5)
    AQI_PM25 = ((200-151)/(150.4-55.5)) * (dawit - 55.5) + 151
   
   # VERY UNHEALTHY
  
  if (!is.na(dawit) & dawit < 250.4 & dawit > 150.5)
    AQI_PM25 = ((300-201)/(250.4-150.5)) * (dawit - 150.5) + 201
  
  
# Hazardous 


  if (!is.na(dawit) & dawit < 350.4 & dawit > 250.5)
    AQI_PM25 = ((400-301)/(350.4-250.5)) * (dawit - 250.5) + 301

  if (!is.na(dawit) & dawit < 500.4 & dawit > 350.5)
    AQI_PM25 = ((500-401)/(500.4-350.5)) * (dawit - 350.5) + 401

  
  if(is.na(dawit))
    AQI_PM25 = NA
  if(exists("AQI_PM25")){
    
  }else {
    AQI_PM25=NA
  }
  return(AQI_PM25)
  
}


### PM10 #####


aqi_PM10_fun <- function(dawit){
  
  if (!is.na(dawit) & dawit  < 150 & dawit  > 0)
    AQI_PM10 = ((50-0)/(150-0)) * (dawit  - 0) + 0
  
  if (!is.na(dawit) & dawit < 154 & dawit > 151)
    AQI_PM10 = ((100-51)/(154-151)) * (dawit - 151) + 51
  
  if (!is.na(dawit) & dawit < 254 & dawit > 155)
    AQI_PM10 = ((150-101)/(254-155)) * (dawit - 155) + 101
  
  if (!is.na(dawit) & dawit < 354 & dawit > 255)
    AQI_PM10 = ((200-151)/(354-255)) * (dawit - 255) + 151
  
  if (!is.na(dawit) & dawit < 424 & dawit > 355)
    AQI_PM10 = ((300-201)/(424-355)) * (dawit - 355) + 201
  
  if (!is.na(dawit) & dawit < 504 & dawit > 425)
    AQI_PM10 = ((400-301)/(504-425)) * (dawit - 425) + 301
  
  if (!is.na(dawit) & dawit < 604 & dawit > 505)
    AQI_PM10 = ((500-401)/(604-505)) * (dawit - 505) + 401
  

  if(is.na(dawit))
    AQI_PM10 = NA
  if(exists("AQI_PM10")){
    
  }else {
    AQI_PM10=NA
  }
  return(AQI_PM10)
  
}



#### SO2 ######

aqi_SO2_fun <- function(dawit){

if (!is.na(dawit) & dawit < 57.2 & dawit > 0)
  AQI_SO2 = ((50-0)/(57.2-0)) * (dawit - 0) + 0

if (!is.na(dawit) & dawit < 75 & dawit > 57.3)
  AQI_SO2 = ((100-51)/(75-57.3)) * (dawit - 57.3) + 51

if (!is.na(dawit) & dawit < 185 & dawit > 76)
  AQI_SO2 = ((150-101)/(185-76)) * (dawit - 76) + 101

if (!is.na(dawit) & dawit < 304 & dawit > 186)
  AQI_SO2 = ((200-151)/(304-186)) * (dawit - 186) + 151

if (!is.na(dawit) & dawit < 604 & dawit > 305)
  AQI_SO2 = ((300-201)/(604-305)) * (dawit - 305) + 201

if (!is.na(dawit) & dawit < 804 & dawit > 605)
  AQI_SO2 = ((400-301)/(804-605)) * (dawit - 605) + 301

if (!is.na(dawit) & dawit < 1004 & dawit > 805)
  AQI_SO2 = ((500-401)/(1004-805)) * (dawit - 805) + 401


if(is.na(dawit))
  AQI_SO2 = NA
if(exists("AQI_SO2")){
  
}else {
  AQI_SO2=NA
}
return(AQI_SO2)

}


### NO2 ####


aqi_NO2_fun <- function(dawit){

if (!is.na(dawit) & dawit < 79.78 & dawit > 0)
  AQI_NO2 = ((50-0)/(79.78-0)) * (dawit - 0) + 0

if (!is.na(dawit) & dawit < 100 & dawit > 80)
  AQI_NO2 = ((100-51)/(100-80)) * (dawit - 80) + 51

if (!is.na(dawit) & dawit < 360 & dawit > 101)
  AQI_NO2 = ((150-101)/(360-101)) * (dawit - 101) + 101

if (!is.na(dawit) & dawit < 649 & dawit > 361)
  AQI_NO2 = ((200-151)/(649-361)) * (dawit - 361) + 151

if (!is.na(dawit) & dawit < 1249 & dawit > 650)
  AQI_NO2 = ((300-201)/(1249-650)) * (dawit - 650) + 201

if (!is.na(dawit) & dawit < 1649 & dawit > 1250)
  AQI_NO2 = ((400-301)/(1649-1250)) * (dawit - 1250) + 301

if (!is.na(dawit) & dawit < 2049 & dawit > 1650)
  AQI_NO2 = ((500-401)/(2049-1650)) * (dawit - 1650) + 401

if(is.na(dawit))
  AQI_NO2 = NA
if(exists("AQI_NO2")){
  
}else {
  AQI_NO2=NA
}
return(AQI_NO2)

}

