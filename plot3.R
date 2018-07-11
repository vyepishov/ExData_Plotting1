#!/usr/bin/Rscript

# Data preparation.
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
hpc <- read.table(unz(temp, "household_power_consumption.txt"), header = TRUE, sep = ";", na.strings = "?", as.is = TRUE)
unlink(temp)
hpc <- na.omit(subset(hpc, Date == "1/2/2007" | Date == "2/2/2007"))
Sys.setlocale("LC_TIME", "en_US.UTF-8")
hpc$datetime <- as.POSIXlt(paste(hpc$Date, hpc$Time), format="%d/%m/%Y %H:%M:%S")
hpc$weekday <- c("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat")[hpc$datetime$wday + 1]

# Picture drawing.
par(mar = c(4, 4, 2, 1))
with(hpc, plot(datetime, Sub_metering_1, pch = ".", xlab = "", ylab = "Energy sub metering"))
with(hpc, lines(datetime, Sub_metering_1, col = "black"))
with(hpc, lines(datetime, Sub_metering_2, col = "red"))
with(hpc, lines(datetime, Sub_metering_3, col = "blue"))
spaces <- "           "
legend("topright", lwd = c(1, 1, 1), col = c("black", "red", "blue"), xpd = TRUE,
       legend = c(paste("Sub_metering_1", spaces), paste("Sub_metering_2", spaces), paste("Sub_metering_3", spaces)))

# FInalization.
dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()
