url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile="household_power_consumption.zip"); dldate <- Sys.Date()
save(url, dldate, file = "download.RData")

unzip("household_power_consumption.zip")

# 1 txt file named "power_consumption.txt", 126.8 MB, 2075259 rows, 9 columns
# Data from 16/12/2006 1724hrs to 26/11/2010 2102hrs, one row per minute
# We will only be using data from the dates 01/02/2007 and 02/02/2007
# 2 days = 48 hours = 2880 minutes
# 
# From 16/12/2006 1724hrs to 01/02/2007 0000hrs -> 46 days 6 hours 36 minutes 
# (46*24 + 6) * 60 + 36 = 66636 minutes + 1 header row to skip

# First read the header and store it as a character vector
#     firstrow <- readLines("household_power_consumption.txt", n=1)
#     powernames <- unlist(strsplit(firstrow, ";")); rm(firstrow)
# 
# Read the desired using the following code
#      power <- read.table("household_power_consumption.txt", sep=";", stringsAsFactors = FALSE, 
#                    col.names = powernames, skip = 66637, nrows = 2880, na.strings = "?")
#                     
# Use sum(!complete.cases(power)) to see if NA values are present
# Use head(power) to confirm the data starts at 2007-02-01 0000hrs
# Use tail(power) to confirm the data ends at 2007-02-02 2359hrs