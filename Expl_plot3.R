library(ggplot2)
library(reshape2)

setwd("/Users/ape_ro/Documents/exdata-data-NEI_data")

NEI <- readRDS("summarySCC_PM25.rds")
Baltimore <- subset(NEI, NEI$fips == "24510")

Q3_Melt <- melt(Baltimore, id=c("year", "type"), measure.vars=c("Emissions"))
Q3_cast <- dcast(Q3_Melt, year + type ~ variable, sum)

## convert type to factor
Q3_cast$type <- as.factor(Q3_cast$type)


png(filename = "Expl_plot3.png", width = 480, height = 480, units = "px", bg = "white")

g <- ggplot(Q3_cast, aes(x = year, y = Emissions, color = type))
g + geom_line() + labs(title = expression('Total PM' [2.5] * ' Emissions Per Year in Baltimore by Type of Emission'))

dev.off()