setwd("/Users/ape_ro/Documents/exdata-data-NEI_data")

NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")


## get Baltimore data
Baltimore <- subset(NEI, NEI$fips == "24510")
Q2_data <- aggregate(Baltimore$Emissions ~ Baltimore$year, FUN = sum)

names(Q2_data)[1:2] <- c("Year", "Emissions")

png(filename = "Expl_plot2.png", width = 480, height = 480, units = "px", bg = "white")

barplot(Q2_data$Emissions, main=expression('Total PM' [2.5] * ' Emissions Per Year in Baltimore'), names.arg=c("1999", "2002", "2005", "2008"), xlab = "Year", ylab = expression('Total PM' [2.5] * ' Emissions'))

dev.off()
