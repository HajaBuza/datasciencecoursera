"First check the file is exist in current direcotry if no donwload it and uznip
then check is file with data exist and have identical dimension 
at the end make a basic plot and save it as PNG file"

if(!file.exists("Source_Classification_Code.rds") & !file.exists("summarySCC_PM25.rds")) {
     print("Download Air polution database... (29Mb)")
     fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
     download.file(fileUrl, "./exdata%2Fdata%2FNEI_data.zip")
     print(paste("Unzip file in : ", getwd()))
     unzip("exdata%2Fdata%2FNEI_data.zip")
     }  
#read data file 
if (!exists("NEI")|| !identical(dim(NEI), as.integer(c(6497651, 6)))) {
     print("Please wait while summary pm25 data is being loaded")
     NEI <- readRDS("summarySCC_PM25.rds")
}
if (!exists("SCC")|| !identical(dim(SCC), as.integer(c(11717, 15)))) {
     print("Please wait while source class data is being loaded")
     SCC <- readRDS("summarySCC_PM25.rds")
}
makeplot5 <- function() {
     #make data
     BLD <- subset(NEI, fips == "24510")
     SCC <- data.frame(SCC = SCC$SCC, Level3 = SCC$SCC.Level.Three, Level4 = SCC$SCC.Level.Four)
     # merge data and select only usful values
     DF <- merge(BLD, SCC, by = "SCC")
     DF <- DF[grep("^Motor", x = DF$Level3),]
     # plot data and save as png, MBE = motor Baltimore emissions
     MBE <- tapply(DF$Emissions, DF$year, sum)
     years <- unique(BLD$year)
     plot(years, MBE, type = "l", lwd = 3,
          xlab = "Year of Emisions recorded",
          ylab = "Ammount of PM2.5 emitted",
          main = "Emissinons PM2.5 by Motor in Baltimore City from 1999 to 2008")
     # make PNG file
     dev.copy(png, file = "plot5.png")
     dev.off()
     
}
#call plot function
makeplot5()
