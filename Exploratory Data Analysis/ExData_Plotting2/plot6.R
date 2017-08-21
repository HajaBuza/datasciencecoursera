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
makeplot6 <- function() {
     #make data
     BLD <- subset(NEI, fips == "24510")
     LA <- subset(NEI, fips == "06037")
     SCC <- data.frame(SCC = SCC$SCC, Level3 = SCC$SCC.Level.Three, Level4 = SCC$SCC.Level.Four)
     # merge data and select only usful values
     BL <- merge(BLD, SCC, by = "SCC")
     LA <- merge(LA, SCC, by = "SCC")
     # find data which usful
     BL <- BL[grep("^Motor", x = BL$Level3),]
     LA <- with(LA, LA[grepl('^Motor', Level3) | grepl('^Motor', Level4),])
     # plot data and save as png, MBE = motor Baltimore emissions MLA = Motor Los Angeles 
     MBE <- tapply(BL$Emissions, BL$year, sum)
     MLA <- tapply(LA$Emissions, LA$year, sum)
     years <- unique(BLD$year)
     par(mfrow = c(2,1))
     plot(years, MLA, type = "l", lwd = 3, col = "red",
          xlab = "Year of Emisions recorded",
          ylab = "Ammount of PM2.5 emitted",
          main = "Emissinons PM2.5 by Motor in Los Angeles from 1999 to 2008")
     
     plot(years, MBE, type = "l", lwd = 3, col = "green",
          xlab = "Year of Emisions recorded",
          ylab = "Ammount of PM2.5 emitted",
          main = "Emissinons PM2.5 by Motor in Baltimore City from 1999 to 2008")

     # make PNG file
     dev.copy(png, file = "plot6.png")
     dev.off()
     
}
#call plot function
makeplot6()
