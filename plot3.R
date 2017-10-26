plot3 <- function(){
  
  # Reading the data
  if (!file.exists("household_power_consumption.txt")) {
    
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "Dataset.zip")
    unzip("Dataset.zip")
  }
  consumption <- read.table("household_power_consumption.txt", sep = ";", header = T, na.strings = "?")
  
  # Cleaning the Data
  consumption <- na.omit(consumption)
  consumption$DayTime <- paste(consumption$Date, consumption$Time)
  consumption$DayTime <- strptime(consumption$DayTime, format = "%d/%m/%Y %H:%M:%S")
  consumption <- consumption[consumption$DayTime > as.Date("2007-02-01") & consumption$DayTime < as.Date("2007-02-03"),]
  
  # Generating graphic
  png("plot3.png", width = 480, height = 480)
  par(mfrow = c(1,1)) # Set the layout
  
  plot(consumption$DayTime, consumption$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
  lines(consumption$DayTime, consumption$Sub_metering_2, col = "red")
  lines(consumption$DayTime, consumption$Sub_metering_3, col = "blue")
  legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty=1, cex = 0.75)
  
  dev.off()
  
}