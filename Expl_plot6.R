library(reshape2)
library(ggplot2)

setwd("/Users/ape_ro/Documents/exdata-data-NEI_data")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

Baltimore <- subset(NEI, NEI$fips == "24510")
LA <- subset(NEI, NEI$fips == "06037")


Subset_MV <- SCC[grep("Locomotives|Vehicles", SCC$EI.Sector), ]
SCC_MV <- Subset_MV[, 1]


SCC_MV <- as.vector(SCC_MV)

Baltimore_MV <- Baltimore[Baltimore$SCC %in% SCC_MV, ]
LA_MV <- LA[LA$SCC %in% SCC_MV, ]

Q5_df <- aggregate(Baltimore_MV$Emissions ~ Baltimore_MV$year, FUN = sum)
Q6_df <- aggregate(LA_MV$Emissions ~ LA_MV$year, FUN = sum)

## Convert names
names(Q5_df)[1:2] <- c("Year","Emissions")
names(Q6_df)[1:2] <- c("Year", "Emissions")


Q5_df$Location <- "Baltimore"
Q6_df$Location <- "Los Angeles"


Q6_df <- rbind(Q6_df, Q5_df)


png(filename = "Expl_plot6.png", width = 480, height = 480, units = "px", bg = "white")

g <- ggplot(Q6_df, aes(x = Year, y = Emissions, color = Location))
g + geom_line() + labs(title = expression('Total PM' [2.5] * ' Emissions from Motor Vehicles Per Year by Location'))

dev.off()