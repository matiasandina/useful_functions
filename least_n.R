####### Find the least n values #######

# This is an adaptation from dplyr's top_n function
# The idea would be to get the least_n instead
# intended to be used in pipeline (%>%)

# library("dplyr")
least_n <- function (x, n, wt) ### mostly coming from top_n
{
  if (missing(wt)) {
    vars <- tbl_vars(x)
    message("Selecting by ", vars[length(vars)])
    wt <- as.name(vars[length(vars)])
  }
  call <- substitute(filter(x, min_rank((wt)) <= n), list(n = n, 
                                                          wt = substitute(wt)))
  eval(call)
}