library(dplyr)

#Connection to zip file
con <- unz('exdata-data-household_power_consumption.zip', 'household_power_consumption.txt')
data <- read.table(con, header = T, sep = ';', colClasses=c('character', 'character', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric'), na.strings = '?')

#join add date to time column
data <- mutate(data, Time = paste(Time, Date, sep=' '))

#date column as date obj
data$Date <- as.Date(data$Date , '%d/%m/%Y')

#subset by dates between 2007-02-01 and 2007-02-02 
data <- filter(data, Date >= '2007-02-01' & Date <= '2007-02-02')

#Time column as time obj
data$Time <- strptime(data$Time, '%H:%M:%S %d/%m/%Y')

#Create plot Global Active Power vs Time
png('plot3.png')
plot(data$Time, data$Sub_metering_1, type='l', col='black', ylab= 'Energy sub metering', xlab='')
lines(data$Time, data$Sub_metering_2, type='l', col='red')
lines(data$Time, data$Sub_metering_3, type='l', col='blue')
legend("topright", lwd=2, col = c('black', 'blue', 'red'), legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))
dev.off()