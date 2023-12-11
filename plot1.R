library(dplyr)

# import data
mypath <- getwd()
fname <- "household_power_consumption.txt"
my_data <- read.table(file.path(mypath, fname), header =TRUE, sep= ";", na.strings = "?")

# convert date to correct format and apply filter
my_data$Date <- as.Date(my_data$Date, "%d/%m/%Y")
my_data <- filter(my_data, (Date == "2007-02-01") | (Date == "2007-02-02")) 

png(filename = "plot1.png", width = 480, height = 480)
# create hist
hist(my_data$Global_active_power, col="red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")
dev.off()