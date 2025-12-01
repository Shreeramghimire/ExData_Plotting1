load_power_data <- function() {
  if (!file.exists("household_power_consumption.txt")) {
    stop("Data file 'household_power_consumption.txt' not found in current directory")
  }
  
  if (!require(data.table)) {
    install.packages("data.table")
    library(data.table)
  }
  
  cat("Reading data... This may take a moment.\n")
  
  power_data <- fread(
    "household_power_consumption.txt",
    na.strings = "?",
    sep = ";",
    header = TRUE
  )
  
  cat("Data loaded. Filtering dates...\n")
  power_data$Date <- as.Date(power_data$Date, "%d/%m/%Y")
  
  filtered_data <- power_data[Date %in% as.Date(c("2007-02-01", "2007-02-02"))]
  
  filtered_data$DateTime <- as.POSIXct(
    paste(filtered_data$Date, filtered_data$Time), 
    format = "%Y-%m-%d %H:%M:%S"
  )
  
  numeric_columns <- c("Global_active_power", "Global_reactive_power", "Voltage", 
                       "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
  
  for (col in numeric_columns) {
    filtered_data[[col]] <- as.numeric(filtered_data[[col]])
  }
  
  cat("Data preparation complete. Found", nrow(filtered_data), "rows of data.\n")
  
  return(filtered_data)
}

