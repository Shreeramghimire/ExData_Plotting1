source("data_loader.R")
data <- load_power_data()


png("plot2.png", width = 480, height = 480)


plot(data$DateTime, 
     data$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")


dev.off()

cat("Plot 2 saved as plot2.png\n")

