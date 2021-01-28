# These functions expect inputs in the form of LETTERSNUMBERS
# At the moment, they will fail with other type of input
# The basic idea is that we can "do math"

# This function adds n to a string and pads it
# it returns a string as output
str_add_n_string <- function(string, n=1, width=3){
  purrr::map(string,
             function(element)
               data.frame(       
                 stringr::str_split_fixed(element,
                                          pattern = "(?<=[A-Za-z])(?=[0-9])",
                                          # split into two columns
                                          n = 2),
                 stringsAsFactors = F)
  ) -> li
  li <- lapply(li, setNames, nm = c("text", "num"))
  df <- dplyr::bind_rows(li)
  df <- dplyr::mutate(df,
                      num = stringr::str_pad(as.numeric(num) + n,
                                             width=width, pad=0))
  # once we have the math done, we can do the returning
  return(paste0(df$text, df$num))
}

# This function adds n to a string on a data.frame
# and returns a data.frame
# It is likely that users might actually want to use mutate and str_add_n_string() instead
# needs tidyverse to be loaded
str_add_n_df <- function(df, string, n, width=3){
  string <- enquo(string)
  ## split the string using pattern
  df <-  df %>%
    separate(!!string,
             into = c("text", "num"), 
             sep = "(?<=[A-Za-z])(?=[0-9])",
             remove=FALSE
    ) %>%
    # do math
    mutate(num = as.numeric(num),
           num = num + n,
           num = stringr::str_pad(as.character(num),
                                  width = width,
                                  side = "left",
                                  pad = 0 
           )
    ) %>%
    unite(next_string, text:num, sep = "")
  return(df)  
}
