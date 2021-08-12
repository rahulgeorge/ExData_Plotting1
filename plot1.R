#Downloading and Managing the data for processing
if(!file.exists("./workingData")) {
        dir.create("./workingData") #Creating a folder to work in
}

if(!file.exists("./workingData/household_power_consumption.txt")) { #Checking if the dataset has already been downloaded and extracted
        fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileURL, destfile = "./workingData/dataset.zip") #Downloading Data
        unzip(zipfile = "./workingData/dataset.zip", exdir = "./workingData") #Extracting Data
}

#Loading the necessary libraries
library(lubridate) #To work with dates

data <- read.table("./workingData/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = c("?"), colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric","numeric","numeric"))
data$Date <- dmy(data$Date) #Converting to date format
filteredData <- subset(data, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02")) #Filtering out data for specified dates

#Plot 1 Construction
par(mfrow = c(1,1)) #Initialing the frame
hist(filteredData$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power") #Creating the histogram
dev.copy(png, file = "./plot1.png") #Copying out to create PNG file
dev.off() #Closing connection to device
