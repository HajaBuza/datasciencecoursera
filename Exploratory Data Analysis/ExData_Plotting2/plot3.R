"First load library and check the file is exist in current direcotry  if no donwload it and uznip
then check is file with data exist and have identical dimension 
at the end make a basic plot and save it as PNG file"
library(ggplot2)
library(grid)
library(gridExtra)

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
#plot
makeplot3 <- function() {
     #subset every kind of types
     types <- unique(NEI$type)
     points <- subset(NEI, type == types[1])
     nopoints <- subset(NEI, type == types[2])
     onroad <- subset(NEI, type == types[3])
     nonroad <- subset(NEI, type == types[4])
     # make plots 
     years <- unique(NEI$year)
     p1 <- qplot(years, tapply(points$Emissions, points$year, sum), 
                 geom = "line", 
                 xlab = "Year of Emisions recorded",
                 ylab = "Ammount of PM2.5 emitted from POINTS")
     p2 <- qplot(years, tapply(nopoints$Emissions, nopoints$year, sum), 
                 geom = "line", 
                 xlab = "Year of Emisions recorded",
                 ylab = "Ammount of PM2.5 emitted from NON-POINT")
     p3 <- qplot(years, tapply(onroad$Emissions, onroad$year, sum), 
                 geom = "line", 
                 xlab = "Year of Emisions recorded",
                 ylab = "Ammount of PM2.5 emitted from ON-ROAD")
     p4 <- qplot(years, tapply(nonroad$Emissions, nonroad$year, sum), 
                 geom = "line", 
                 xlab = "Year of Emisions recorded",
                 ylab = "Ammount of PM2.5 emitted from NON-ROAD")
#print and save plot
     png("plot3.R")
     grid.arrange(p1, p2, p3, p4, ncol = 2, nrow = 2)
     plot3 <- arrangeGrob(p1, p2, p3, p4, ncol = 2, nrow = 2)
     ggsave(plot3, filename = "plot3.png")
     dev.off()
     

#call function 
     makeplot3()     
}