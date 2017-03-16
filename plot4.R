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

#Make plots
png(file="plot4.png")
par(mar=c(4,4,2,2))
par(mfrow=c(2,2))

#Top Left
with(data=AllData, plot(Global_active_power~DateTime, 
                        type="l", xlab="", 
                        ylab="Global Active Power"))

#Top Right
with(data=AllData, plot(Voltage~DateTime, 
                        type="l", xlab="datetime", 
                        ylab="Voltage"))

#Bottom Left

with(data=AllData, plot(Sub_metering_1~DateTime,type="l",
                        col="black", xlab="", ylab="Energy sub metering"))
with(data=AllData, lines(Sub_metering_2~DateTime, col="red"))
with(data=AllData, lines(Sub_metering_3~DateTime, col="blue"))
legend("topright", bty="n",col = c("black", "red", "blue"), 
       lty=1,legend =names(AllData)[7:9])
with(data=AllData, lines(Sub_metering_3~DateTime, col="blue"))


#Bottom Right
with(data=AllData, plot(Global_reactive_power~DateTime, 
                        type="l", xlab="datetime"))
dev.off()





