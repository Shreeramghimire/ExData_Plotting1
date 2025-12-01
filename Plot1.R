source("data_loader.R")
data <- load_power_data()

png("plot1.png", width = 480, height = 480)

hist(data$Global_active_power, 
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency")

dev.off()

cat("Plot 1 saved as plot1.png\n")

