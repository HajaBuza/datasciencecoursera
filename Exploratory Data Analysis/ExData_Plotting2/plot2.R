"First check the file is exist in current direcotry if no donwload it and uznip
then check is file with data exist and have identical dimension 
at the end make a basic plot and save it as PNG file"

if(!file.exists("Source_Classification_Code.rds")) {
     print("Download Air polution database... (29Mb)")
     fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
     download.file(fileUrl, "./exdata%2Fdata%2FNEI_data.zip")
     print(paste("Unzip file in : ", getwd()))
     unzip("exdata%2Fdata%2FNEI_data.zip")
}
#read data file
if (!exists("NEI")|| !identical(dim(NEI), as.integer(c(6497651, 6)))) {
     print("Please wait while data is being loaded...")
     NEI <- readRDS("summarySCC_PM25.rds")
     
}
# make useful data and plot it
makeplot2 <- function() {
     # make data BLD == Baltiomre City Data
     BLD <- subset(NEI, fips == "24510")
     totalBaltimoreEmission <- tapply(BLD$Emissions, BLD$year, sum)
     years <- unique(BLD$year)
     plot(years, totalBaltimoreEmission, type = "l", lwd = 3,
          xlab = "Year of Emisions recorded",
          ylab = "Ammount of PM2.5 emitted",
          main = "Emissinons PM2.5 in Baltimore City from 1999 to 2008")
     # make PNG file
     dev.copy(png, file = "plot2.png")
     dev.off()
}
#call plot function
makeplot2()