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
library(dplyr) #To work with datasets

data <- read.table("./workingData/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = c("?"), colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric","numeric","numeric"))
data$Date <- dmy(data$Date) #Converting to date format
filteredData <- subset(data, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02")) #Filtering out data for specified dates
filteredData <- mutate(filteredData, DateTime = ymd_hms(paste(filteredData$Date,filteredData$Time))) #Creating a new column with Date and Time combined

#Plot 3 construction
par(mfrow = c(1,1), mar = c(4,4,0.5,0.5)) #Initialising the frame
plot(filteredData$DateTime,filteredData$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "") #Creating the base plot
lines(filteredData$DateTime, filteredData$Sub_metering_2, col =  "red") #Adding second line
lines(filteredData$DateTime, filteredData$Sub_metering_3, col =  "blue") #Adding third line
legend("topright",lty = 1, legend = c("sub_Metering_1","sub_Metering_2","sub_Metering_3"), col = c("black","red","blue")) #Creating the legend
dev.copy(png, file = "./plot3.png") #Copying out to create PNG file
dev.off()
