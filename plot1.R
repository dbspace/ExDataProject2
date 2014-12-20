# Assume the files are in the current working directory
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

totalPM25ByYear <- aggregate(NEI$Emissions, list(NEI$year), FUN = "sum")

png("plot1.png")
plot(totalPM25ByYear, type = "l", xlab = "Year", 
     main = expression('Total US PM'[2.5]* " Emissions from 1999 to 2008"), 
     ylab = expression('Total PM'[2.5]*" Emissions"))
dev.off()