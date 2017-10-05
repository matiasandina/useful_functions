## This function Substitutes decimal comas for decimal periods
## This comes handy if dealing with data that is not in english


decimal_sub <- function(x) {
  
  y <- as.numeric(sub(",",".",x))
  
  return(y)
}

# Vectorized, compatible with apply over rows and columns
# For example, 

# data_sub <- (apply(data, 2, decimal_sub))
