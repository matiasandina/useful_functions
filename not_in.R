
# This function is similar to the native `%in%` shortcut but opposite to it

# `%in%`
# function (x, table) 
#   match(x, table, nomatch = 0L) > 0L
# <bytecode: 0x000000000c9a8598>
#   <environment: namespace:base>


`%not in%` <- function (x, table) {
  is.na(match(x, table, nomatch=NA_integer_))
}


# Example: Getting virginca and versicolor or NOT setosa :) 

# A <- dplyr::filter(iris, Species %in% c("virginica", "versicolor"))
# B <- dplyr::filter(iris, Species %not in% c("setosa"))
# identical(A,B)
# [1] TRUE