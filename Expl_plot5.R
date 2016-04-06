library(reshape2)
library(ggplot2)


setwd("/Users/ape_ro/Documents/exdata-data-NEI_data")


NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


Baltimore <- subset(NEI, NEI$fips == "24510")

Subset_MV <- SCC[grep("Locomotives|Vehicles", SCC$EI.Sector), ]
SCC_MV <- Subset_MV[, 1]


SCC_MV <- as.vector(SCC_MV)

Baltimore_MV <- Baltimore[Baltimore$SCC %in% SCC_MV, ]

Q5_df <- aggregate(Baltimore_MV$Emissions ~ Baltimore_MV$year, FUN = sum)

names(Q5_df)[1:2] <- c("Year" ,"Emissions")

png(filename = "Expl_plot5.png", width = 480, height = 480, units = "px", bg = "white")

barplot(Q5_df$Emissions, main= expression('Total PM' [2.5] * ' Emissions from Motor Vehicles in Baltimore Per Year'), names.arg=c("1999", "2002", "2005", "2008"), xlab = "Year", ylab = expression('Total PM' [2.5] * ' Emissions from Motor Vehicles in Baltimore'))

dev.off()