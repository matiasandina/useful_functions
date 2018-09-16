MEDPC_TO_R = function(){

  
######### This function is generally WRONG 
  ### Needs to be parametrized correctly 
  ### Most important parts are the reading process, ignore most of all stuff
  ### Best option could be to split the function into multiple modules
  ### In this way, every MEDPC would be custom depending on a specific PROTOCOL.R
  ### reading function should be similar (delimited files, ...)
  
x=1
  
# we need this out of the loop if we want batch mode to be on/off
# we could use an argument called 'batch=F' and work out from there  
# this chunk can be useful or not. Using the x=1 inside the for loop makes it manual everytime with no batch mode

#  if (batch==T){
#    x=20
#    question1=readline('Separate with comas all your variables :>')
#    myvars=toupper(unlist(strsplit(question1,split = ',')))
#    message('Are you sure you want those variables?')
#    print(myvars)
#    question2=readline()
#    if(tolower(question2)!='yes') stop('Please run whole function again')
#  }else{
#    x=1
#  } 


#### read.table call #####
 
  for (j in dir()){

  info=read.table(j,
                  sep="", ## separated by multiple spaces
                  skip = 2,nrows = 9, 
                  stringsAsFactors = F,
                  fill=T)
  
  
## Needs parameters via function for specific use  
  
  # Clean information
  # Should be put elsewhere
  
  #info$V1=gsub(':','',info$V1)
  start.day=info$V3[1]
  start.time=info$V3[7]
  Experiment=info$V2[4]
  RatID = info$V2[3]
  Box= info$V2[6]
  Code_name=info$V2[9]
  
  
  # Go for the data
  
  pru=read.table(j,
                 sep="", ## separated by multiple spaces
                 skip = 29, # we are not using the info in this part
                 stringsAsFactors = F,
                 fill=T) # So empty columns get NA vales instead of errors
  
  # Find where the letters are
  find_letters=grep('[A-Z]',pru[,1]) 
  # Make a vector of names eliminating the ':'
  future_names=gsub(pattern = ':',"",pru[find_letters,1])
  
  lista= list()
  
  for (i in 1:length(find_letters)) {
    from = find_letters[i] + 1 
    to = find_letters[i+1] - 1
    # last line doesn't have an index so becomes NA
    # we make that to be the last line of pru
    if (is.na(to)) to=dim(pru)[1] 
    print(paste('from',from))
    print(paste('to',to))
    # store vectors in list 
    lista[[i]] = as.vector(t(pru[from:to,2:6]))  
    # remove NA values added while reading
    lista[[i]] = lista[[i]][!is.na(lista[[i]])]
  }
  
  names(lista)=future_names
  
  # chose your variables mannually 
  
  while(x<2) {
    
    myvars=select.list(names(lista),multiple=TRUE,
                       title='Hold Ctrl and click to select variables',
                       graphics=TRUE)
    
    my_text_vars=paste0(myvars,'-',collapse = '')
    ask=readline(paste0('Are ',my_text_vars,' ALL your variables (Yes/No)? :>'))
    if(tolower(ask) == 'yes') { x=x+2 
    } else {
      print('Please select again.')
      x = x + 0.1
      if (x>1.5) stop('Please run whole function again')
      next()
    }
    }

  
  # subset the list with selected variables
  
  lista2=lista[names(lista)%in%myvars]
  
  
  # Make df with selected columns
  
  
  df=data.frame(do.call(cbind,lista2),row.names=NULL)
  
  
  
  df$start.day= start.day
  df$start.time= start.time
  df$Experiment= Experiment
  df$RatID = RatID  
  df$Box= Box
  df$Code_name= Code_name  
   
df_export_name = paste('table_', RatID,'.csv',sep="")
  
write.csv(df,df_export_name,row.names = F)

}

# make a complete table
li=list(); for (i in list.files(pattern = '.csv')){li[[i]]=read.csv(i)} ; 
datos=data.frame(do.call(rbind,li),row.names = NULL)
name_your_file=readline('Choose your file name :>')

name_your_file = paste0(name_your_file,'.csv')

write.csv(datos,name_your_file,row.names=F)    


}
