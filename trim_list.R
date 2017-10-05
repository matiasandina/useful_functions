##### Subset length of list of data frames ######

# This function performs a subset of a list of dataframes from 1:selected_rows
# selected_rows must be numeric of length 1
# It is a basic wraper for lapply(list, "[", ...)
# It returns a list of n dataframes of the same length

trim_list <- function(mylist, selected_rows){
  
  if (!is.numeric(selected_rows)|length(selected_rows)>1){
    stop("Input selected_rows as a number of length 1")
    
  } else {
    
    # The comma after selected_rows is NOT extra!
    # Rstudio says argument missing but it works as intended
    # It probably has to do with the fact that I'm using "[" instead of formal subset function
    
    out <- lapply(mylist,"[",1:selected_rows,, drop=FALSE)
    
    return(out)
  }
}