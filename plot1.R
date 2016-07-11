firstrow <- readLines("household_power_consumption.txt", n=1)
powernames <- unlist(strsplit(firstrow, ";")); rm(firstrow)
power <- read.table("household_power_consumption.txt", sep=";", stringsAsFactors = FALSE, 
                    col.names = powernames, skip = 66637, nrows = 2880, na.strings = "?")

# plot 1: histogram of global active power
png("plot1.png")
hist(power$Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")
dev.off()
