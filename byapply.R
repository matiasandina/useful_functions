# This function comes handy to apply 'fun' to object 'x' over every 'by' columns
# Alternatively, 'by' may be a vector of groups
# This function is not my own, I got it from stackoverflow but did not copy the link

byapply <- function(x, by, fun, ...){
  # Create index list
  if (length(by) == 1){
    nc <- ncol(x)
    split.index <- rep(1:ceiling(nc / by), each = by, length.out = nc)
  } else # 'by' is a vector of groups
  {
    nc <- length(by)
    split.index <- by
  }
  index.list <- split(seq(from = 1, to = nc), split.index)
  
  # Pass index list to fun using sapply() and return object
  sapply(index.list, function(i)
  {
    do.call(fun, list(x[, i], ...))
  })
}
