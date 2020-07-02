library(dplyr)
library(ggplot)
library(lubridate)

# Get Data

data <- read.table("data/household_power_consumption.txt", sep = ";", header = TRUE, quote="\"", comment.char="")

# Filter the data

d <- data %>%
        filter(Date == "1/2/2007" | Date == "2/2/2007")

# Set Column Types

d$date_time <- paste(d$Date, d$Time)
d <- d[,-c(1:2)]
d$date_time <- strptime(d$date_time, "%e/%m/%Y %X")

d$Global_active_power <- as.numeric(as.character(d$Global_active_power))
d$Global_reactive_power <- as.numeric(as.character(d$Global_reactive_power))
d$Voltage <- as.numeric(as.character(d$Voltage))
d$Global_intensity <- as.numeric(as.character(d$Global_intensity))
d$Sub_metering_1 <- as.numeric(as.character(d$Sub_metering_1))
d$Sub_metering_2 <- as.numeric(as.character(d$Sub_metering_2))

d$Sub_metering_3 <- as.numeric(d$Sub_metering_3)



# Open jpeg file
png("Plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))

##PLOT#1

with(d, plot(date_time, Global_active_power, type = "S", ylab = "Global Active Power", xlab = ""))

##PLOT#2

with(d, plot(date_time, Voltage, type = "S", ylab = "Voltage", xlab = "datetime"))

##PLOT#3

with(d, plot(date_time, Sub_metering_1, type = "S", ylab = "Energey sub metering", xlab = ""))

with(d, lines(date_time, Sub_metering_2, col = "red"))
with(d, lines(date_time, Sub_metering_3, col = "blue"))

legend("topright", pch = NA, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, bty = "n")

##PLOT#4

with(d, plot(date_time, Global_reactive_power, type = "S", ylab = "Global_reactive_power", xlab = "datetime"))


# Close the file
dev.off()
par(mfrow=c(1,1))
