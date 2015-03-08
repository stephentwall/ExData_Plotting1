# R script to read household power consumption data, subset a timeframe, create plot
# assumes the raw data file, household_power_consumption.txt is in users local directory where this script executes
# household_power_consumption.txt (~126 MB) is not included in this repo

#Exploratory data analysis, week1, courseproject1

#subset only data for Feb 1 & 2 2007
powerconsumption <- read.csv2("household_power_consumption.txt",dec = ".", na.strings="?", stringsAsFactors=FALSE)
powerFebruary <- powerconsumption[powerconsumption$Date == "1/2/2007"| powerconsumption$Date == "2/2/2007",]
#yields 2880 rows
powerFebruary$Date <- paste(powerFebruary$Date, powerFebruary$Time)
#convert Date column to PosixTime
powerFebruary$Date <- strptime(powerFebruary$Date, "%d/%m/%Y %H:%M:%S")

# Create plot file
#plot4
png(file = "plot4.png")
par(mfcol = c(2,2))
with(powerFebruary, {
    plot(powerFebruary$Date,powerFebruary$Global_active_power, type = "l", ylab = "Global Active Power", xlab = "" )
    
    plot(Date, Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering")
    lines(Date, Sub_metering_2, col = "red")
    lines(Date, Sub_metering_3, col = "blue")
    legend("topright", lty = 1, bty = "n", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    
    plot(powerFebruary$Date,powerFebruary$Voltage, type = "l", ylab = "Voltage", xlab = "datetime" )
    plot(powerFebruary$Date,powerFebruary$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime" )
    
})
dev.off()