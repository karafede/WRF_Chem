

max_pollu <- function(fed){
  if(all(is.na(fed))){
    daw<- NA
    o3 = 0
    co = 0
    pm25 = 0
    pm10 = 0
    so2 = 0
    no2 = 0
    count_line<- c(daw,o3,co,pm25,pm10,so2,no2)
  }else{
    chk_1<- max(fed, na.rm = TRUE)
    federico<-fed==chk_1
    o3 = 0
    co = 0
    pm25 = 0
    pm10 = 0
    so2 = 0
    no2 = 0
    indi_max<-which(federico)
    if(indi_max==1){
      daw<-"O3"
      o3<-1
    }
    if(indi_max==2){
      daw<-"CO"
      co<-1
    }
    if(indi_max==3){
      daw<-"PM25"
      pm25<-1
    }
    if(indi_max==4){
      daw<-"PM10"
      pm10<-1
    }
    if(indi_max==5){
      daw<-"SO2"
      so2<-1
    }
    if(indi_max==6){
      daw<-"NO2"
      no2<-1
    }
  }
  count_line<- (c(daw,o3,co,pm25,pm10,so2,no2))
  
  return(count_line)
}