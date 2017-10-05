######  print a dot every n items of a function #####

# This function is not mine, I took it from Hadley's Advanced R long time ago


dot_every <- function(n, f) {
  i <- 1
  function(...) {
    if (i %% n == 0) cat(".")
    i <<- i + 1
    f(...)
  }
}
