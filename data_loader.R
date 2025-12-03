load_power_data <- function() {
  if (!file.exists("household_power_consumption.txt")) {
    stop("Data file 'household_power_consumption.txt' not found in current directory")
  }
  
  cat("Reading data...\n")
  
  # Read the data using base R
  power_data <- read.table(
    "household_power_consumption.txt",
    header = TRUE,
    sep = ";",
    na.strings = "?",
    stringsAsFactors = FALSE,
    colClasses = c(rep("character", 2), rep("numeric", 7))
  )
  
  cat("Filtering dates...\n")
  
  # Convert Date column
  power_data$Date <- as.Date(power_data$Date, "%d/%m/%Y")
  
  # Filter for Feb 1-2, 2007
  filtered_data <- subset(power_data, 
                          Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))
  
  cat("Creating DateTime column...\n")
  
  datetime_string <- paste(as.character(filtered_data$Date), filtered_data$Time)
  filtered_data$DateTime <- as.POSIXct(datetime_string)
  
  
  cat("Data preparation complete. Found", nrow(filtered_data), "rows.\n")
  
  return(filtered_data)
}

