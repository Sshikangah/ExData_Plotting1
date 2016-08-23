
# downloading Electricity power consumption dataset into R
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unzip(temp, "household_power_consumption.txt"), header = TRUE, sep = ";", na.strings = "?" )
unlink(temp)

#check first six observations
head(data)

# to change date format and combine date and time

data$Date <- as.Date(data$Date, "%d/%m/%Y")
data$DateTime <- with(data, as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S"))

#subset dataset to 2007/02/01 and 2007/02/02
data2 <- data[ which(data$Date == "1/2/2007" | data$Date == "2/2/2007"), ]
#plot1.png
hist(data2$Global_active_power, main = "Global active power", col = "red", xlab = "Global active power(kilowatts)") # constructing plot1 on screen
dev.copy(png, file = "Plot1.png", width = 480, height = 480, units='px') #copy plot1 to file png
dev.off()#close the png device

#plot2.png
with(data2, plot(DateTime, Global_active_power, ylab = "Global active power(kilowatts)", type = "l")) #constructing plot2 on screen
dev.copy(png, file = "Plot2.png", width = 480, height = 480, units='px') #copy plot2 to file png
dev.off()#close the png device


#plot3.png
with(data2, plot(DateTime, Sub_metering_1, ylab = "Energy sub metering", type = "l")) #construct the first plot
lines(data2$DateTime, data2$Sub_metering_2, type ="l", col = "red") #add sub_metering_2 plot
lines(data2$DateTime, data2$Sub_metering_3, type = "l", col = "blue")# add sub_metering_3 plot
legend('topright', col = c('black', 'red', 'blue'), legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), lwd = 1)
dev.copy(png, file = "Plot3.png", width = 480, height = 480, units='px') #copy plot3 to file png
dev.off()#close the png device

#plot4.png
par(mfcol = c(2,2))
with(data2, {
        plot(DateTime, Global_active_power, ylab = "Global active power(kilowatts)", type = "l") #constructing first plot
        plot(DateTime, Sub_metering_1, ylab = "Energy sub metering", type = "l") #construct the second plot
        lines(data2$DateTime, data2$Sub_metering_2, type ="l", col = "red") 
        lines(data2$DateTime, data2$Sub_metering_3, type = "l", col = "blue")
        legend('topright', col = c('black', 'red', 'blue'), legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), lwd = 1)
        plot(DateTime, Voltage, ylab = "Voltage", type = "l") # constructing third plot
        plot(DateTime, Global_reactive_power, ylab = "Global reactive power", type = "l") #constructing fourth plot
})
dev.copy(png, file = "Plot4.png", width = 480, height = 480, units='px') #copy plot4 to file png
dev.off()#close the png device


