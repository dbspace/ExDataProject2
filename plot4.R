# load the require library
library(plyr)
library(ggplot2)

# Assume the files are in the current working directory
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#There is mutliple ways to look at the SCC for coal combustion-related sources
#For example SCC.Level.One and SCC.Level.Three, EI.Sector, Short.Name
#After Looking at the data, I decide to use EI.Sector and Short.Name
coal1Set <- grep("Comb.*Coal", SCC$Short.Name)
coal2Set <- grep("coal", SCC$EI.Sector, ignore.case = T)
coalSet <- union(coal1Set, coal2Set)

coalSCC <- SCC[coalSet,]

coalCombustion <- subset(NEI, SCC %in% coalSCC$SCC)

coalEmissionsByYear <- aggregate(coalCombustion$Emissions, 
                                 list(coalCombustion$year), FUN = "sum")

png("plot4.png")
plot(coalEmissionsByYear, type = "l", xlab = "Year", 
     main = expression('Coal Combustion-related PM'[2.5]* " Emissions from 1999 to 2008"), 
     ylab = expression('Total PM'[2.5]*" Emission"))
dev.off()