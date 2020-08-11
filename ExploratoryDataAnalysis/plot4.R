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
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))
# (1,1)
plot(data_sub$Datetime, data_sub$Global_active_power, ylab="Global Active Power (kilowatts)",
     xlab="",type = "l")
# (1,2)
plot(data_sub$Datetime, data_sub$Voltage, ylab="Voltage", xlab="Datetime",type = "l")
# (2,1)
with(data_sub, {
    plot(Sub_metering_1~Datetime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
    lines(Sub_metering_2~Datetime,col='Red')
    lines(Sub_metering_3~Datetime,col='Blue')}
)
legend("topright", col=c("black", "red", "blue"), lty=c(1,1,1), lwd=c(2,2,2),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
# (2,2)
plot(data_sub$Datetime, data_sub$Global_reactive_power, ylab="Global_reactive_Power",
     xlab="Datetime",type = "l")
dev.off()