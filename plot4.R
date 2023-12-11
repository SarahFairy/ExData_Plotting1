library(dplyr)

# import data
mypath <- getwd()
fname <- "household_power_consumption.txt"
my_data <- read.table(file.path(mypath, fname), header =TRUE, sep= ";", na.strings = "?")

# convert date to correct format and apply filter
my_data$Date <- as.Date(my_data$Date, "%d/%m/%Y")
my_data <- filter(my_data, (Date == "2007-02-01") | (Date == "2007-02-02"))

# add column with date and time and apply format
my_data <- mutate(my_data, dt = paste(Date, Time))
my_data$dt <- strptime(my_data$dt, "%Y-%m-%d %H:%M:%S")
r <- as.POSIXct(round(range(my_data$dt), "days"))

# create plots
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))

# top left 
plot(my_data$dt, my_data$Global_active_power, xaxt = 'n',
     xlab = "", ylab = "Global Active Power", type = "l", lty = 1) 
axis.POSIXct(side=1, at = seq(r[1], r[2], by = 'days'), format = '%a')

# top right
plot(my_data$dt, my_data$Voltage, xaxt = 'n', yaxt = 'n',
     xlab = "datetime", ylab = "Voltage", type = "l", lty = 1) 
axis.POSIXct(side=1, at = seq(r[1], r[2], by = 'days'), format = '%a')
axis(side=2, at = seq(234,246,2), label = c('234','','238','','242','','246'))

# bottom left
plot(my_data$dt, my_data$Sub_metering_1, xaxt = 'n', yaxt = 'n',
     xlab = "", ylab = "Energy sub metering", type = "l", lty = 1) 
lines(my_data$dt,my_data$Sub_metering_2, col='red')
lines(my_data$dt,my_data$Sub_metering_3, col='blue')
legend("topright", lty = 1, bty = "n", col = c("black","blue", "red"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
axis.POSIXct(side=1, at = seq(r[1], r[2], by = 'days'), format = '%a')
axis(side=2, at = seq(0,30,10))

# bottom right
plot(my_data$dt, my_data$Global_reactive_power, xaxt = 'n', yaxt = 'n',
     xlab = "datetime", ylab = "Global_reactive_power", type = "l", lty = 1) 
axis.POSIXct(side=1, at = seq(r[1], r[2], by = 'days'), format = '%a')
axis(side=2, at = seq(0, 0.5, 0.1))

dev.off()

