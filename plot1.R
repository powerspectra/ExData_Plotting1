getdata = function()
{
   if (!file.exists("household_power_consumption.txt")) {
      # download the data
      fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
      download.file(fileURL, "boogie.zip")
      unzip("boogie.zip")
   }
}

plot1 = function()
{
   getdata()
   fileHandler <- file("household_power_consumption.txt")
   # Grabbed the colunn names from the data description
   data <- read.table(text = grep("^[1,2]/2/2007", readLines(fileHandler), value = TRUE), 
       col.names = c("Date", "Time", "Global_active_power",  "Global_reactive_power", 
       "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       sep = ";", header = TRUE)
   hist(data$Global_active_power, col = "red", main = paste("Global Active Power"), 
       xlab = "Global Active Power (kilowatts)")
   dev.copy(png, file = "plot1.png", width = 480, height = 480)
   dev.off()
}