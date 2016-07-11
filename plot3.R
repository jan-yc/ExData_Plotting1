library(lubridate); library(tidyr)

firstrow <- readLines("household_power_consumption.txt", n=1)
powernames <- unlist(strsplit(firstrow, ";")); rm(firstrow)
power <- read.table("household_power_consumption.txt", sep=";", stringsAsFactors = FALSE, 
                    col.names = powernames, skip = 66637, nrows = 2880, na.strings = "?")

power1 <- unite(power, Date_time, Date, Time, sep = " ")
power1$Date_time <- dmy_hms(power1$Date_time)

# plot 3: three line plots - Sub_metering_(1,2,3) against Date_time
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