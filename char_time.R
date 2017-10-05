###### Generate character vector with hours:minutes [hh:mm]  #####

# This function accepts whatever intervals,
# meaning you can mess things up (not constrained by real time values)

char_time<-function(from_hour, to_hour, from_min, to_min, by){
  m<-outer(seq(from_hour, to_hour,1), 
           seq(from_min, to_min, by), 
           function(x, y) 
             paste0(
               sprintf("%02.f", x) ,
               ":", 
               sprintf("%02.f", y)))
  return(as.vector(t(m)))
}

# Usage
# char_time(1,2,0,55,5)

## 2017-10-05 this function is deprecated, use lubridate package or other available options
# from https://stackoverflow.com/questions/8924133/seq-for-posixct

# start <- now()
# seq(start, start + days(3), by = "15 min")
