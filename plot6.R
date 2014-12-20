# load the require library
library(ggplot2)

# Assume the files are in the current working directory
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#using airport code BWI(Baltimore) and LAX(Losangeles) to shortern the names
#Assume Motor Vehicles means "ON-ROAD"
BWI_LAX_PM25 <- subset(NEI, fips == "24510" | fips == "06037")
BWI_LAX_PM25Motor <- subset(BWI_LAX_PM25, type == "ON-ROAD")

totalBWI_LAX_PM25MotorByYear <- aggregate(BWI_LAX_PM25Motor$Emissions, 
                list(BWI_LAX_PM25Motor$year, BWI_LAX_PM25Motor$fips), FUN = "sum")

totalBWI_LAX_PM25MotorByYear$Group.2 <- factor(totalBWI_LAX_PM25MotorByYear$Group.2, 
                                               labels = c("Los Angeles", "Baltimore"))

# we can plot the graph now 
#ggplot(totalBWI_LAX_PM25MotorByYear, aes(Group.1, x, colour = Group.2)) +
#        geom_line() +
#        labs(title = expression('Baltimore Motor Vechile PM'[2.5]* " Emissions from 1999 to 2008"), 
#             x = "Year", y = expression('Total PM'[2.5]*" Emission")) +
#        theme(legend.title = element_blank())
#but this graph is difficult to see the changes

#We want to normalize it to 1999
colnames(totalBWI_LAX_PM25MotorByYear) <- c("year", "city", "Emissions")
BWI1999PM25 <- subset(totalBWI_LAX_PM25MotorByYear,
                            year == 1999 & city == "Baltimore")$Emissions
LAX1999PM25 <- subset(totalBWI_LAX_PM25MotorByYear,
                      year == 1999 & city == "Los Angeles")$Emissions

BWI_LAX_PM25MotorNorm <- transform(totalBWI_LAX_PM25MotorByYear,
                        EmissionsNorm = ifelse(city == "Baltimore",
                                                Emissions / BWI1999PM25,
                                                Emissions / LAX1999PM25))
png("plot6.png")
ggplot(BWI_LAX_PM25MotorNorm, aes(year, EmissionsNorm, colour = city)) +
        geom_line() +
        labs(title = "Baltimore vs Los Angeles Motor Vechile Change \n Emissions from 1999 to 2008", 
             x = "Year", y = expression('Normalized PM'[2.5]*" Emission")) +
        theme(legend.title = element_blank())
dev.off()