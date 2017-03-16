# load data and read
library(data.table)
library(lubridate)
URL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata
%2Fhousehold_power_consumption.zip"
download.file(URL, destfile="Electric.zip")
unzip("Electric.zip", exdir="./Electric")
setwd("./Electric")
AllData<-fread("household_power_consumption.txt", sep=";", header=TRUE)
setwd("..")

#add date-time column

AllData$DateTime<-dmy_hms(paste(AllData$Date, AllData$Time))
AllData$Date<-dmy(AllData$Date)

#filter

AllData<-subset(AllData, Date>=as.Date("2007-02-01") 
    & Date<=as.Date("2007-02-02"))

#change classes to numeric
AllData$Global_active_power<-as.numeric(AllData$Global_active_power)
AllData$Global_reactive_power<-as.numeric(AllData$Global_reactive_power)
AllData$Voltage<-as.numeric(AllData$Voltage)
AllData$Global_intensity<-as.numeric(AllData$Global_intensity)
AllData$Sub_metering_1<-as.numeric(AllData$Sub_metering_1)
AllData$Sub_metering_2<-as.numeric(AllData$Sub_metering_2)
AllData$Sub_metering_3<-as.numeric(AllData$Sub_metering_3)

#Make plot

png(file="plot1.png")
with(data=AllData, hist(Global_active_power, col="red", 
    xlab="Global Active Power (kilowatts)", 
    main="Global Active Power"))
dev.off()

