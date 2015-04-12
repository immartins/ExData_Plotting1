setwd("C:/Iolanda/Study/datascience")
library(data.table)

# make data available 
url <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
file <- "household_power_consumption"
download.file(url, file)
dir.create("./data")
unzip(file, exdir = "./data")
data <- fread("household_power_consumption.txt")

# clean data
class(data$Date)
class(data$Time)
# handle Date variable format
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
class(data$Date)
# use data between given time range
data_range <- data[data$Date=="2007-02-01" | data$Date=="2007-02-02"]
# convert subset to data frame
class(data_range)
data_range <- data.frame(data_range)
# convert columns to numeric
for(i in c(3:9)) {data_range[,i] <- as.numeric(as.character(data_range[,i]))}
# create DateTime variable
data_range$DateTime <- paste(data_range$Date, data_range$Time)
# convert DateTime variable 
data_range$DateTime <- strptime(data_range$DateTime, format="%Y-%m-%d %H:%M:%S")
class(data_range$DateTime)

# create plot

png(filename = "plot4.png", width = 480, height = 480, units = "px", bg = "white")
par(mfrow = c(2, 2), mar = c(14, 6, 2, 2), cex=.5)
# top-left
plot(data_range$DateTime, data_range$Global_active_power, xaxt=NULL, xlab = "", ylab = "Global Active Power", type="n")
lines(data_range$DateTime, data_range$Global_active_power, type="S")
# top-right
plot(data_range$DateTime, data_range$Voltage, xaxt=NULL, xlab = "datetime", ylab = "Voltage", type="n")
lines(data_range$DateTime, data_range$Voltage, type="S")
# bottom-left
plot(data_range$DateTime, data_range$Sub_metering_1, xaxt=NULL, xlab = "", ylab = "Energy sub metering", type="n")
lines(data_range$DateTime, data_range$Sub_metering_1, col = "black", type = "S")
lines(data_range$DateTime, data_range$Sub_metering_2, col = "red", type = "S")
lines(data_range$DateTime, data_range$Sub_metering_3, col = "blue", type = "S")
legend("topright", bty = "n", lty = c(1, 1), lwd = c(1, 1, 1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
# bottom-right
plot(data_range$DateTime, data_range$Global_reactive_power, xaxt=NULL, xlab = "datetime", ylab = "Global_reactive_power", type="n")
lines(data_range$DateTime, data_range$Global_reactive_power, type="S")
dev.off()
