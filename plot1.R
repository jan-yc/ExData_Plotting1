# checks if the power consumption data is in the working directory
# if not, downloads the zip file and extracts it
if(!file.exists("household_power_consumption.txt")){
      url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
      download.file(url, destfile="household_power_consumption.zip")
      dldate <- Sys.Date()
      save(url, dldate, file = "download.RData")
      unzip("household_power_consumption.zip")
}

# Read the first/header row of the file as a character object
firstrow <- readLines("household_power_consumption.txt", n=1)

# Split this object into a list and then flatten the list into a 
# character vector of variable names.
powernames <- unlist(strsplit(firstrow, ";")); rm(firstrow)

# The data is from 16/12/2006 1724hrs to 26/11/2010 2102hrs, one row per minute
# We will only be using data from the dates 01/02/2007 and 02/02/2007
# 2 days = 48 hours = 2880 minutes, therefore we read 2880 rows.
# 
# From 16/12/2006 1724hrs to 01/02/2007 0000hrs -> 46 days 6 hours 36 minutes 
# (46*24 + 6) * 60 + 36 = 66636 minutes
# So we skip 66636 + 1 (header row) = 66637 rows.

power <- read.table("household_power_consumption.txt", sep=";", stringsAsFactors = FALSE, 
                    col.names = powernames, skip = 66637, nrows = 2880, na.strings = "?")

# This table starts at 01/02/2007 0000hrs and ends at 02/02/2007 2359hrs
# Use head(power) and tail(power) to confirm the range of data is correct
# Use sum(!complete.cases(power)) to check the number of rows with missing values

# plot1: histogram of global active power, red in color
png("plot1.png") # default values for width and height in png are 480px
hist(power$Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")
dev.off()
