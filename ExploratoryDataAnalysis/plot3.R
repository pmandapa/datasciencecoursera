## Program to reproduce Plot 2 of the project

## Reading full dataset of household power consumption
data <- read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                 nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')

## Changing date column to date type
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

## Sub-setting the data used for this plot  
data_sub <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")

## Remove the larger full data array
rm(data)

## Combining date and time columns
datetime <- paste(as.Date(data_sub$Date), data_sub$Time)

# Making a POSIXct datetime column
data_sub$Datetime <- as.POSIXct(datetime)

## Time series of energy sub_metering types and saving to a 480 x 480 PNG file
png("plot3.png", width=480, height=480)
with(data_sub, {
    plot(Sub_metering_1~Datetime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
    lines(Sub_metering_2~Datetime,col='Red')
    lines(Sub_metering_3~Datetime,col='Blue')}
    )
legend("topright", col=c("black", "red", "blue"), lty=c(1,1,1), lwd=c(2,2,2),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()

