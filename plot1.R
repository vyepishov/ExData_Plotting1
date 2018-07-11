#!/usr/bin/Rscript

# Data preparation.
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
hpc <- read.table(unz(temp, "household_power_consumption.txt"), header = TRUE, sep = ";", na.strings = "?", as.is = TRUE)
unlink(temp)
hpc <- na.omit(subset(hpc, Date == "1/2/2007" | Date == "2/2/2007"))

# Picture drawing.
with(hpc, hist(Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", ylab = "Frequency",
               main = "Global Active Power"))

# FInalization.
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()
