# This function takes a dataframe and a time column
# Time column can be part of data frame or not!
# examples
# timed_integral(dataframe$time, dataframe[,2:length(dataframe)]) or
# timed_integral(time, dataframe)
# The output is the cumulative of the absolute diference from point to point 
# if your input is relative position vs time, it will give you absolute movement vs time
# You have to fix the names after using it (left like this for flexibility?)

timed_integral <- function(mytime, dataframe){
 
  matriz <- as.matrix(dataframe)
  matriz_dif <- abs(diff(matriz)) # Take derivative
  matriz_dif_inv <- diffinv(matriz_dif) # integrate
  
  return(data.frame(cbind(mytime, matriz_dif_inv )))
}