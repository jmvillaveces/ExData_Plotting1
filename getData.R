library(dplyr)

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
