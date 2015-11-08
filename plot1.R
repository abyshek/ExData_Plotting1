# check if the data file exists in the working directory, if the file does not exist,
#download the zip file and extract the txt file from it

if(!file.exists("exdata_data_household_power_consumption.zip"))
{
  url1<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(url1,destfile="exdata_data_household_power_consumption.zip")
  unzip("exdata_data_household_power_consumption.zip")
}


#check if the package "sqldf" is installed, if not, then install it
if (!require("sqldf")) {
  install.packages("sqldf")}

#load the sqldf package into R
library(sqldf)

# read the given data file by using SQL query
mydata1<-read.csv.sql("household_power_consumption.txt", "select * from file where Date=='1/2/2007' OR Date == '2/2/2007'", sep=";", eol="\n")

#creating a new column with "Date" and "Time" columns concatenated
mydata1$date_time<-paste(mydata1$Date,mydata1$Time)

# Use strptime to convert the data in date_time column to a desired date format
mydata1$date_time<-strptime(mydata1$date_time,"%d/%m/%Y %H:%M:%S")

# create a Histogram as required in plot1

hist(mydata1$Global_active_power,main="Global Active Power", xlab = "Global Active Power (kilowatts)",col= "red")

#copy the plot generated to a png file with required dimensions
dev.copy(png,file="plot1.png", width =480, height=480, units="px")
dev.off

