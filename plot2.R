# Assume the files are in the current working directory
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

BaltimorePM25 <- subset(NEI, fips == "24510")

totalBaltimorePM25ByYear <- aggregate(BaltimorePM25$Emissions, 
                                      list(BaltimorePM25$year), FUN = "sum")

png("plot2.png")
plot(totalBaltimorePM25ByYear, type = "l", xlab = "Year", 
     main = expression('Total Baltimore City PM'[2.5]* " Emissions from 1999 to 2008"), 
     ylab = expression('Total PM'[2.5]*" Emissions"))
dev.off()