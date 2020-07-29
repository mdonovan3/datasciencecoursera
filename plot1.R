baseDir <- "/home/mdonovan/Classes/ExploratoryDataAnalysis/Project1/"
dataZipFile <- "household_power_consumption.zip"
dataFile <- "household_power_consumption.txt"
zipURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
filteredDataFile <- "filteredData.txt"

setwd(baseDir)

if(! file.exists(dataZipFile)){
  download.file(zipURL, dataZipFile ) 
  unzip( dataZipFile)
}

if(! file.exists(filteredDataFile)){
  con <- file(dataFile, open = 'r')
  rawData <- readLines(con)
  for(line in rawData){
    if(grepl("^[1,2]/2/2007", line)){
      #print(line)
      write(line, file = "filteredData.txt", append = TRUE)
    }
  }
  close(con)
}

PCData <- read.table(filteredDataFile, na.strings = c("?"), sep = ";")  
PCData$V2 <- strptime(paste(PCData$V1, PCData$V2, sep = " "), format = "%d/%m/%Y %H:%M:%S")
PCData$V1 <- as.Date(as.character(PCData$V1), format = "%d/%m/%Y")
names(PCData) <- c("Date", "Date_time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

png(filename = "plot1.png", width = 480, height = 480)
hist(as.numeric(as.character(PCData$Global_active_power)),col="red",main="Global Active Power",xlab="Global Active Power(kilowatts)")
title(main = "Global Active Power")
dev.off()
