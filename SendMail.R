## Sending emails from R using Outlook
# Maybe useful for loging ? 

library('RDCOMClient')


SendMail <- function(from, to, MailSubject, MailBody, attach=FALSE, ...){

  params <- list(...)
  
  ## init com api
  OutApp <- COMCreate("Outlook.Application")
  ## create an email 
  outMail = OutApp$CreateItem(0)
  ## configure  email parameter 
  ## Multiple emails need paste(..., sep=';')
  ## Multiple people is not working...stick with only one alberto
  #outMail[["To"]] = "@gmail.com;@gmail.com"
  outMail[["To"]] = to
  outMail[["Cc"]] = from
  outMail[["subject"]] = MailSubject
  outMail[["body"]] = MailBody
  
  
  ## attach
  if(attach){
    
    
    my_file <- params$file
    
    print(paste("Looking for file", my_file))
    
    my_name <- list.files(pattern = my_file)
    
    if(length(my_name)<1) stop("File not found. Check Working Directory and define argument as file=...") 
    
    # get path to file from wd
    path_email <- file.path(getwd(),my_name)
    
    # Add attachments
    outMail[["Attachments"]]$Add(path_email)  
  }
  
  
  
  ## send it                     
  outMail$Send()  

  
    
}

