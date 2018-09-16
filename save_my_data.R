save_my_data <- function(dataset){
  
  # Get the name
  dataset_name <- deparse(substitute(dataset))
  env <- parent.frame()
  
  if(!exists(dataset_name, env)){
    stop("Dataset does not exist")
  } 
  
  
  message("---- Substantial computation has been made -----")
  
  stay_in_loop <- TRUE
  
  while(stay_in_loop){
    
    ans <- readline(prompt="Do you want to save dataset? [Yy/Nn]: ")
    
    if(tolower(ans) == "y"){
      # generate name
      output_name <- paste0(dataset_name, '.csv')
      # Save
      write.csv(dataset, file = output_name, row.names = FALSE)
      # print stuff
      message(sprintf("%s was saved to file.", output_name))
      
      # Get out
      stay_in_loop <- FALSE
    }
    else if(tolower(ans) == "n"){
      
      message("Dataset will not be saved to file. Exists in environment")
      
      # Get out
      stay_in_loop <- FALSE
    }
    else{
      
      message('Wrong input. Your options are [Yy/Nn]')
      # do nothing
      
    }
    
  }
  
}