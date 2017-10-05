# This function gets slope and adj_R from lm
# This might not be usfeul as of 2017-10-05

lm_slope_adj_R <- function(formula){ 
  regresion <- lm( formula )
  ss <- summary(regresion)
  return(c( coef(regresion)[2] , ss$adj.r.squared))
}