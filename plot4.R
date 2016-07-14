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

# plot 4: 2x2 array of plots
png("plot4.png") # default values for width and height in png are 480px
par(mfrow = c(2,2))

# topleft plot: line plot of Global_active_power (y) against Date_time (x)
with(power1, plot(Date_time, Global_active_power, type="l", xlab="", 
                  ylab="Global Active Power"))

# topright plot: line plot of Voltage (y) against Date_time (x)
with(power1, plot(Date_time, Voltage, type="l", xlab="datetime", 
                  ylab="Voltage"))

# bottomleft plot: 3 line plots of sub_metering_1/2/3 (y) against Date_time (x)
with(power1, 
     {plot(Date_time, Sub_metering_1, type="l", xlab="", 
           ylab="Energy sub metering")
      lines(Date_time, Sub_metering_2, col = "red")
      lines(Date_time, Sub_metering_3, col = "blue")
      })
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       cex = 0.8, bty = "n")

# bottomright plot: line plot of Global_reactive_power (y) against Date_time (x)
with(power1, plot(Date_time, Global_reactive_power, type="l", xlab="datetime", 
                  ylab="Global_reactive_power"))
dev.off()