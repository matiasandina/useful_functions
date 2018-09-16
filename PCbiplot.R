###### PC BIPLOT #########

# This function performs a Biplot from a prcomp object
# adapted from here
#https://stackoverflow.com/questions/6578355/plotting-pca-biplot-with-ggplot2

# Update 2018-08-17
# Matias Andina
# now this function partially supports tidy evaluation

PCbiplot <- function(data_to_pca, 
                     columns,
                     id.columns,
                     col.column1,
                     x=PC1,
                     y=PC2,
                     verbose=TRUE) {
  
  
  x <- enquo(x)
  y <- enquo(y)
  col.column1 <- enquo(col.column1)
  
  
  # data_to_pca is original dataframe
  # columns is the numeric vector of desired columns
  # id.columns are those columns that serve as id
  
  # perform PC analysis
  PC <- prcomp(data_to_pca[columns])
  
  # Prepare data to plot
  data_to_plot <- data.frame(cbind(data_to_pca[, id.columns],
                           PC$x))

  ## Provide some feedback about the PCA #####
  
  var_explained <- PC$sdev/sum(PC$sdev)
  
  # percent and round 
  
  var_percent <- data.frame(components = colnames(PC$x),
                            var_exp = round(var_explained*100 ,2))
  
  var_plot <- ggplot(var_percent, aes(components, var_exp))+
    geom_col() +
    geom_line(aes(group=1), color="white", lwd=2)+
    geom_point(color="white", size=5)
  
  # var for axis
  var_x <- filter(var_percent, components == quo_name(x)) %>% pull(var_exp)
  var_y <- filter(var_percent, components == quo_name(y)) %>% pull(var_exp)
    
  
  # variable-PC correlation ####
  
 var_pc_corr <- reshape2::melt(mypca$rotation) %>%
                rename(variable=Var1,
                       components=Var2) %>% 
    ggplot(aes(components, value, fill=variable, alpha=abs(value)))+
    geom_col(position="dodge")+
    ylim(c(-1, 1))
  
  
 # some verbsoe
  if(verbose){
    
    message("PCA dataframe contains these variables:  ")
    print(names(data_to_plot))
    
    message(glue::glue("Coloring variable is ", quo_name(col.column1)))
    
    # Add verbose about variance explained
    # add verbose about correlation with selected PCs 
  }

## First basic plot ####
  
  myplot <- ggplot(data_to_plot, aes(x=!!x,
                                     y=!!y,
                                     color=!!col.column1)) +
    geom_point(size=3, alpha=0.5)+
#   geom_text(alpha=.4, size=3)+
    ggthemes::theme_base()+
    geom_hline(yintercept = 0, size=.2,lty=2) +
    geom_vline(xintercept = 0, size=.2,lty=2)+
    theme(plot.background = element_rect(colour = NA))+
    xlab(glue::glue(quo_name(x), " (", var_x, "%)"))+
    ylab(glue::glue(quo_name(y), " (", var_y, "%)"))
  
  
  # obtain the rotation values ####  
   data_rotations <- data.frame(varnames=rownames(PC$rotation),
                        PC$rotation)
   
 
  # x values
  
  max_x <- max(data_to_plot %>% pull(!!x)) 
  min_x <- min(data_to_plot %>% pull(!!x))  
  
  max_x_rot <- max(data_rotations %>% pull(!!x))
  min_x_rot <- min(data_rotations %>% pull(!!x))
  
  # y values
  max_y <- max(data_to_plot %>% pull(!!y)) 
  min_y <- min(data_to_plot %>% pull(!!y))  
  
  max_y_rot <- max(data_rotations %>% pull(!!y))
  min_y_rot <- min(data_rotations %>% pull(!!y))
  
  mult <- min(
    (max_y - min_y)/(max(max_y_rot - min_y_rot)),
    (max_x - min_x)/(max(max_x_rot - min_x_rot))
  )
  
  
# These lines were replaced with tidyevaluation above
#   mult <- min(
#     (max(data[,y]) - min(data[,y])/(max(datapc[,y])-min(datapc[,y]))),
#     (max(data[,x]) - min(data[,x])/(max(datapc[,x])-min(datapc[,x])))
#   )
     
  # make values for the vectors with the rot  
   data_rotations <- data_rotations %>%
                     mutate(v1 = .7 * mult * !!x,
                            v2 = .7 * mult * !!y)
  
   
   # rotation plot ######
   
   rot_plot <- ggplot(data_to_plot, aes(x=!!x,
                                        y=!!y))+
     ggthemes::theme_base()+
     geom_hline(yintercept = 0, size=.2,lty=2) +
     geom_vline(xintercept = 0, size=.2,lty=2)+
     theme(plot.background = element_rect(colour = NA))+
     coord_equal() +
     geom_text(data=data_rotations,
               aes(x=v1, y=v2, label=varnames),
               size = 4, vjust=1, color="red")+
     geom_segment(data=data_rotations,
                  aes(x=0, y=0, xend=v1, yend=v2),
                  arrow=arrow(length=unit(0.4,"cm")),
                  alpha=0.75, color="red", lwd=1)
     
   
  # biplot #####
    biplot <- myplot + coord_equal() +
     geom_text(data=data_rotations,
               aes(x=v1, y=v2, label=varnames),
               size = 3, vjust=1, color="red")+
     geom_segment(data=data_rotations,
                 aes(x=0, y=0, xend=v1, yend=v2),
                arrow=arrow(length=unit(0.4,"cm")),
               alpha=0.75, color="red", lwd=1)
    
    
    
all_plots <- cowplot::plot_grid(var_plot, var_pc_corr,
                                myplot,
                                rot_plot, biplot) 
                                


print(all_plots)

  return(list(PC=PC, data_to_plot=data_to_plot,
              var_plot=var_plot,
              var_pc_corr=var_pc_corr,
              myplot=myplot,
              rot_plot=rot_plot,
              biplot=biplot))
}
