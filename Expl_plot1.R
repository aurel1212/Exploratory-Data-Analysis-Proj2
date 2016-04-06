#library(reshape2)
#library(ggplot2)

setwd("/Users/ape_ro/Documents/exdata-data-NEI_data")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")

Q1_data <- aggregate(NEI$Emissions ~ NEI$year, FUN = sum)

names(Q1_data)[1:2] <- c("Year", "Emissions")

png(filename = "Expl_plot1.png", width = 480, height = 480, units = "px", bg = "white")

barplot(Q1_data$Emissions, main=expression('Total PM' [2.5] * ' Emissions Per Year'), names.arg=c("1999", "2002", "2005", "2008"), xlab = "Year", ylab = expression('Total PM' [2.5] * ' Emissions'))

dev.off()