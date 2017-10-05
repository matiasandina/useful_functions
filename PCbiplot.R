###### PC BIPLOT #########

# This function performs a Biplot from a prcomp object
# You have to provide "nombres" from original data for it to create labels
# It uses aes_string, which might be deprecated


PCbiplot <- function(PC, x="PC1", y="PC2", nombres) {
  
  
  # PC being a prcomp object
  data <- data.frame(nombres,PC$x)
  myplot <- ggplot(data, aes_string(x=x, y=y)) +
    geom_text(alpha=.4, size=3, aes(label=nombres))+
    theme_classic()
  myplot <- myplot +
    geom_hline(aes(0), size=.2,lty=2) +
    geom_vline(aes(0), size=.2,lty=2)
  
  datapc <- data.frame(varnames=rownames(PC$rotation), PC$rotation)
  mult <- min(
    (max(data[,y]) - min(data[,y])/(max(datapc[,y])-min(datapc[,y]))),
    (max(data[,x]) - min(data[,x])/(max(datapc[,x])-min(datapc[,x])))
  )
  datapc <- transform(datapc,
                      v1 = .7 * mult * (get(x)),
                      v2 = .7 * mult * (get(y))
  )
  myplot <- myplot + coord_equal() +
    geom_text(data=datapc, aes(x=v1, y=v2, label=varnames),
              size = 5, vjust=1, color="red")
  myplot <- plot +
    geom_segment(data=datapc, aes(x=0, y=0, xend=v1, yend=v2),
                 arrow=arrow(length=unit(0.2,"cm")),
                 alpha=0.75, color="red")
  myplot
}
