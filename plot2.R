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



plot2 = function()
{
   subData <- getFormatData()
   
   #plot data
   plot(subData$Global_active_power ~ subData$Datetime, type = "l",
        ylab = "Global Active Power (kilowatts)", xlab = "")
   
   #save off as png file
   dev.copy(png, file = "plot2.png", width = 480, height = 480)
   dev.off()  
}
