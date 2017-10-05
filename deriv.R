# This function creates the derivate of a position vs time dataframe
# If time column provided in dataframe (dataframe$mytime);
# the dataframe argument has to be subseted dataframe[,2:length(dataframe)]
# names have to be fixed after calling the function

abs_deriv<- function(mytime, dataframe, add.origin=TRUE){
  matriz <- as.matrix(dataframe)
  matriz_dif <- diff(matriz) # derivate
  
  if(add.origin==FALSE){
    matriz_dif1 <- matriz_dif
  } else {
    # add a line of zeros as origin to keep dim (by default we lose 1 row with diff)
    matriz_dif1 <- rbind(c(rep(0,dim(matriz_dif)[2])), matriz_dif) 
    
  }
  
  return(data.frame(cbind(mytime, matriz_dif1)))
}