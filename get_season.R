# This function comes from
# https://stackoverflow.com/questions/36502140/determine-season-from-date-using-lubridate-in-r
# But also see season definitions here
# https://stackoverflow.com/questions/9500114/find-which-season-a-particular-date-belongs-to
# Finally, there's an issue on lubridate trying to fix this
# https://github.com/tidyverse/lubridate/issues/611

library(lubridate)
get_season <- function(input_date){
  # TODO: add checks for input_date
  numeric_date <- 100*month(input_date)+day(input_date)
  ## input Seasons upper limits in the form MMDD in the "break =" option:
  ## TODO: fix season breaks using different conditions
  cuts <- base::cut(numeric_date,
                    breaks = c(0,319,0620,0921,1220,1231)) 
  
  # TODO: add hemisphere option
  # rename the resulting groups (could've been done within cut(...levels=) if "Winter" wasn't double
  levels(cuts) <- c("Winter","Spring","Summer","Fall","Winter")
  return(cuts)
}

df <- data.frame(day = as.POSIXct("2016-01-01 12:00:00")+(0:365)*(60*60*24),
season = get_season(as.POSIXct("2016-01-01 12:00:00")+(0:365)*(60*60*24))
)