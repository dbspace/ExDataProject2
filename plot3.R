# load the require library
library(plyr)
library(ggplot2)

# Assume the files are in the current working directory
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

BaltimorePM25 <- subset(NEI, fips == "24510")

BaltimorePM25TypeByYear <- ddply(BaltimorePM25, .(year, type), 
                                 function(x) sum(x$Emissions))

colnames(BaltimorePM25TypeByYear)[3] <- "Emissions"

png("plot3.png")
qplot(year, Emissions, data=BaltimorePM25TypeByYear, color=type, geom="line") +
        ggtitle(expression('Baltimore City PM'[2.5]* " Emissions by Source Type and Year")) +
        xlab("Year") + ylab(expression('Total PM'[2.5]* " Emissions"))
dev.off()