getData <- function(file_loc = "data/household_power_consumption.txt") {
    ## Wrapper for reading data from `file_loc'
    df <- read.csv(file_loc,
                   sep = ';',
                   na.strings = "?",
                   as.is = T,
                   colClasses = c("character", "character", rep("numeric", 7)),
                   nrows = 2075259)
    datetime <- paste(df$Date, df$Time)
    df$Datetime <- strptime(datetime, "%d/%m/%Y %H:%M:%S")
    df$Date <- as.Date(df$Date, '%d/%m/%Y')
    
    subset(df, as.Date(Date) >= '2007-02-01' & as.Date(Date) <= '2007-02-02')
}

df <- getData()

png("plot1.png")
with(df, hist(x=Global_active_power,
              col = "red",
              main = "Global Active Power",
              xlab = "Global Active Power (kilowatts)"))
dev.off()