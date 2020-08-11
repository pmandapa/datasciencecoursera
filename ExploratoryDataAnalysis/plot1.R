## Program to reproduce Plot 1 of the project

## Reading full dataset of household power consumption
data <- read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                      nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')

## Changing date column to date type
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

## Sub-setting the data used for this plot  
data_sub <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")

## Remove the larger full data array
rm(data)

## Constructing histogram (Plot 1)
hist(data_sub$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

## Saving to a PNG file with a width of 480 pixels and a height of 480 pixels
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
