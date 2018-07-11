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
with(hpc, plot(datetime, Global_active_power, pch = ".", xlab = "", ylab = "Global Active Power (kilowatts)"))
with(hpc, lines(datetime, Global_active_power))

# FInalization.
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()
