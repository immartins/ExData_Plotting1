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

png(filename = "plot2.png", width = 480, height = 480, units = "px", bg = "white")
par(mar = c(6, 6, 5, 4))
plot(data_range$DateTime, data_range$Global_active_power, xaxt=NULL, xlab = "", ylab = "Global Active Power (kilowatts)", type="n")
lines(data_range$DateTime, data_range$Global_active_power, type="S")
dev.off()
