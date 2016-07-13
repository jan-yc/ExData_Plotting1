library(lubridate); library(tidyr)

# for detailed comments on reading the data, please see plot1.R
firstrow <- readLines("household_power_consumption.txt", n=1)
powernames <- unlist(strsplit(firstrow, ";")); rm(firstrow)
power <- read.table("household_power_consumption.txt", sep=";", stringsAsFactors = FALSE, 
                    col.names = powernames, skip = 66637, nrows = 2880, na.strings = "?")

# use tidyr to join the date and time columns
power1 <- unite(power, Date_time, Date, Time, sep = " ")
# use lubridate to convert the joined column to POSIXct format
power1$Date_time <- dmy_hms(power1$Date_time)

# plot 2: line plot of Global_active_power(y) vs Date_time(x)
png("plot2.png")
with(power1, plot(Date_time, Global_active_power, type="l", xlab="", 
                  ylab="Global Active Power (kilowatts)"))
dev.off()