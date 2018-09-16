
# Function to plot a 2d Histogram/heatmap

plot_2dhist = function(df,poly,x.value){
  
  # x.value is asking for the symmetry axis to make left and right
  # Use values from left_cut and right_cut used for Analyze_cuts.R 
  # Alternatively, use something in between those values
  
  # make ventral be down
  df$y=abs(df$y-max(df$y))
  
  if (poly=='TRUE'){
    
    # prepare df for hull
    pru=df %>% mutate(zone=ifelse(x>x.value,'right','left')) %>%
      group_by(zone) %>%
      do(find_hull(.))
    
    h=ggplot(df,aes(x,y))+ theme_bw()+
      geom_polygon(data=pru,fill="black",alpha=.2)+
      stat_bin2d(bins = c(230,230))+ # 230 px ~ 0.1 mm
      ggtitle("Density plot 100um squares")+
      scale_fill_gradient(low="black",high = 'green')  
    print(h)
    out=ggplot_build(h)$data[[2]]
  } else {
    
    h=ggplot(df,aes(x,y))+ theme_bw()+
      stat_bin2d(bins = c(230,230))+ # 230 px ~ 0.1 mm
      ggtitle("Density plot 100um squares")+
      scale_fill_gradient(low="black",high = 'green')
    print(h)
    out=ggplot_build(h)$data[[2]]
    
  }
  return(out)    
}


# Helper function to show polygon
# if you want polygon to show up you will need this helper.
find_hull <- function(df) {
  ch=chull(df$x, df$y)
  coords=df[c(ch,ch[1]),] # for closed polygons
  return(coords)
}
