

max_AQI_fun <- function(fed){
  if(all(is.na(fed))){
    daw <- NA
  }else{
    daw<- max(fed, na.rm = TRUE)
  }
  return(daw)
}