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

png(filename = "plot3.png", width = 480, height = 480)
# create plot
plot(my_data$dt, my_data$Sub_metering_1, xaxt = 'n',
     xlab = "", ylab = "Energy sub metering", type = "l", lty = 1) 
lines(my_data$dt,my_data$Sub_metering_2, col='red')
lines(my_data$dt,my_data$Sub_metering_3, col='blue')
legend("topright", lty = 1, col = c("black","blue", "red"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
axis.POSIXct(side=1, at = seq(r[1], r[2], by = 'days'), format = '%a')

dev.off()

