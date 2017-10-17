# This function is rowMeans but with na.rm=TRUE by default so we can use it with missing values
# Comes useful with other functions (example, byapply.R)

# alternatively use function(t) rowMeans(t, na.rm=T)???

myMEANS <- function (x, na.rm = TRUE, dims = 1L) {
  if (is.data.frame(x)) 
    x <- as.matrix(x)
  if (!is.array(x) || length(dn <- dim(x)) < 2L) 
    stop("'x' must be an array of at least two dimensions")
  if (dims < 1L || dims > length(dn) - 1L) 
    stop("invalid 'dims'")
  p <- prod(dn[-(id <- seq_len(dims))])
  dn <- dn[id]
  z <- if (is.complex(x)) 
    .Internal(rowMeans(Re(x), prod(dn), p, na.rm)) + (0+1i) * 
    .Internal(rowMeans(Im(x), prod(dn), p, na.rm))
  else .Internal(rowMeans(x, prod(dn), p, na.rm))
  if (length(dn) > 1L) {
    dim(z) <- dn
    dimnames(z) <- dimnames(x)[id]
  }
  else names(z) <- dimnames(x)[[1L]]
  z
}
