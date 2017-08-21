"Function which first download air pollution data (if not exist)
then unzip and create two variable in global environment.
First create new dir in set directory so if you want to choose another
dir put it into directory argument"
makedata <- function(directory = getwd()) {
     setwd(directory)
     # make a directory 
     if (!("ExData_Plotting2" %in% list.files()) ) {
          dir.create("ExData_Plotting2")
     }
     setwd(paste(getwd(), "/ExData_Plotting2", sep = ""))
     #download file 
     if(!("exdata%2Fdata%2FNEI_data.zip" %in% list.files())) {
          print("Download Air polution database... (29Mb)")
          fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
          download.file(fileUrl, "./exdata%2Fdata%2FNEI_data.zip")
     }
     #unzip file 
     if (!file.exists("Source_Classification_Code.rds") & !file.exists("summarySCC_PM25.rds")) {
          print(paste("Unzip file in : ", getwd()))
          unzip("exdata%2Fdata%2FNEI_data.zip")
     }
     setwd(directory)
     
}