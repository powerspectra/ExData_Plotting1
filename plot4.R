getdata = function()
{
   if (!file.exists("household_power_consumption.txt")) {
      # download the data
      fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
      download.file(fileURL, "boogie.zip")
      unzip("boogie.zip")
   }
}

getFormatData = function()
{
   #download data and unzip if needed
   getdata()
   # load data
   data <- read.csv("household_power_consumption.txt", header = T, sep = ';', 
                         na.strings = "?", check.names = F, stringsAsFactors = F, 
                         comment.char = "", quote = '\"')
   
   data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
   
   #convert dates
   subData <- subset(data, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))
   datetime <- paste(as.Date(subData$Date), subData$Time)
   subData$Datetime <- as.POSIXct(datetime)
   return(subData)
     
}


plot4 = function()
{
   #pull in formated data
   subData <- getFormatData()
   
   par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))

      #first plot: same as plot 2
      plot(subData$Global_active_power ~ subData$Datetime, type = "l",
           ylab = "Global Active Power", xlab = "")
      
      
      #second plot
      plot(subData$Voltage ~ subData$Datetime, type = "l", ylab = "Voltage", xlab = "datetime")
      
   
      #third plot: same as plot 3
      with(subData, {
         plot(Sub_metering_1 ~ Datetime, type = "l", 
              ylab = "Energy Sub metering", xlab = "")
         lines(Sub_metering_2 ~ Datetime, col = 'Red')
         lines(Sub_metering_3 ~ Datetime, col = 'Blue')
      })
      #creating legend
      legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, bty = "n",
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
   
   
      #forth plot
      plot(subData$Global_reactive_power ~ subData$Datetime, type = "l", 
           ylab = "Global_reactive_power", xlab = "datetime")
      
      #save off as png file
      dev.copy(png, file = "plot4.png", width = 480, height = 480)
      dev.off()
      
}