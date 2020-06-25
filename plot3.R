library(dplyr)
library(lubridate)
###Data download
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile = "exdata_data_household_power_consumption.zip", method="curl")
##unzip and save files in the "final" folder
if(!file.exists("week1")) {
  unzip("exdata_data_household_power_consumption.zip", exdir="./week1")
}

####convert txt files into dataframes and select the right time frame
household_power <- read.table("week1/household_power_consumption.txt", header = TRUE, sep=";",stringsAsFactors=FALSE,na.strings="?")
household_power$DateTime <- with(household_power, strptime(paste(Date, Time), "%d/%m/%Y%H:%M:%S"))
household_power<-subset(household_power, DateTime>=as.Date("2007-02-01 00:00:00", format="%Y-%m-%d%H:%M:%S"))
household_power<-subset(household_power, DateTime<as.Date("2007-02-03 00:00:00", format="%Y-%m-%d%H:%M:%S"))

str(household_power)
##########make a histogram 
png("plot3.png", height = 480, width = 480) 

with(household_power, plot(DateTime,Sub_metering_1, type="l",ylab = "Energy sub metering",xlab=""))
with(household_power, points(DateTime,Sub_metering_2, col="red",type="l",ylab = "Global Active Power(kilowatts)", xaxt = "n",xlab="", xlim=limit))
with(household_power, points(DateTime,Sub_metering_3, col="blue",type="l",ylab = "Global Active Power(kilowatts)", xaxt = "n",xlab="", xlim=limit))
legend("topright",legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), col=c("black", "red", "blue"))
dev.off()

