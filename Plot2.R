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



# 1. Open jpeg file
png("Plot2.png", width = 480, height = 480)

# 2. Create the plot

with(d, plot(date_time, Global_active_power, type = "S", ylab = "Global Active Power (kilowatts)", xlab = ""))


# 3. Close the file
dev.off()
