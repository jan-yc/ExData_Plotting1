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

# plot 3: three line plots - Sub_metering_1 (y, black); Sub_metering_2 (y, red);
# Sub_metering_3 (y, blue) against Date_time (x)
png("plot3.png")
with(power1, {
      plot(Date_time, Sub_metering_1, type="l", xlab="", 
                  ylab="Energy sub metering")
      lines(Date_time, Sub_metering_2, col = "red")
      lines(Date_time, Sub_metering_3, col = "blue")
      })
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()