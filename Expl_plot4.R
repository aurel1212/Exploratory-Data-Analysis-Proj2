library(reshape2)
library(ggplot2)

setwd("/Users/ape_ro/Documents/exdata-data-NEI_data")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

Coal_Set <- SCC[grep("Coal", SCC$EI.Sector),]
Coal_SCCs <- Coal_Set[, 1]

Coal_SCCs <- as.vector(Coal_SCCs)

Coal_NEI <- NEI[NEI$SCC %in% Coal_SCCs, ]

Q4_data <- aggregate(Coal_NEI$Emissions ~ Coal_NEI$year, FUN = sum)

names(Q4_data)[1:2] <- c("Year", "Emissions")

png(filename = "Expl_plot4.png", width = 480, height = 480, units = "px", bg = "white")

barplot(Q4_data$Emissions, main= expression('Total PM' [2.5] * ' Emissions Per Year from Coal'), names.arg=c("1999", "2002", "2005", "2008"), xlab = "Year", ylab = expression('Total PM' [2.5] * ' Emissions'))

dev.off()