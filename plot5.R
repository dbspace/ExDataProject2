# load the require library
library(ggplot2)

# Assume the files are in the current working directory
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

BaltimorePM25 <- subset(NEI, fips == "24510")
BaltimorePM25Motor <- subset(BaltimorePM25, type == "ON-ROAD")

totalBaltimorePM25MotorByYear <- aggregate(BaltimorePM25Motor$Emissions, 
                                      list(BaltimorePM25Motor$year), FUN = "sum")
png("plot5.png")
ggplot(totalBaltimorePM25MotorByYear, aes(Group.1, x)) + geom_line() + 
        labs(title = expression('Baltimore Motor Vechile PM'[2.5]* " Emissions from 1999 to 2008"), 
             x = "Year", y = expression('Total PM'[2.5]*" Emission"))
dev.off()