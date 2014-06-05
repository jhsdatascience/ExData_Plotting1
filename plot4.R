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

png("plot4.png")
# Set up grid
par(mfrow = c(2,2))

# Top left
with(df, plot(Datetime, Global_active_power,
              type = "l",
              xlab = "",
              ylab = "Global Active Power"))

# Top right
with(df, plot(Datetime, Voltage,
              type = "l",
              xlab = "datetime"))

# Lower Left
with(df, plot(Datetime, Sub_metering_1,  type = "l",
              ylab = "Energy sub metering", xlab = ""))
with(df, lines(Datetime, Sub_metering_2,
               col = "red"))
with(df, lines(Datetime, Sub_metering_3,
               col = "blue"))
with(df, legend("topright",
                legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
                col = c("black", "red", "blue"),
                lty = c(1,1,1),
                bty = "n"))

# Lower right
with(df, plot(Datetime, Global_reactive_power,
              type = "l",
              xlab = "datetime"))
dev.off()
