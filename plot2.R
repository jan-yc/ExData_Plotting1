library(lubridate); library(tidyr)

firstrow <- readLines("household_power_consumption.txt", n=1)
powernames <- unlist(strsplit(firstrow, ";")); rm(firstrow)
power <- read.table("household_power_consumption.txt", sep=";", stringsAsFactors = FALSE, 
                    col.names = powernames, skip = 66637, nrows = 2880, na.strings = "?")

# joins the date and time columns and converts it to POSIXct
power1 <- unite(power, Date_time, Date, Time, sep = " ")
power1$Date_time <- dmy_hms(power1$Date_time)

# plot 2: line graph of global active power(y) vs date(x)
png("plot2.png")
with(power1, plot(Date_time, Global_active_power, type="l", xlab="", 
                  ylab="Global Active Power (kilowatts)"))
dev.off()