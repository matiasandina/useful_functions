######## Create a circle #######

# This function is not mine, I took it from stackoverflow long time ago
# It creates a circle with the particular parameters


circle <- function(center = c(0, 0), npoints = 100, r = 1) {
  tt = seq(0, 2 * pi, length = npoints)
  xx = center[1] + r * cos(tt)
  yy = center[2] + r * sin(tt)
  return(data.frame(x = xx, y = yy))
}

# Usage
# corcir <- circle(c(0, 0), npoints = 100,r=1)