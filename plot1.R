### this script generates the first plot fot the ExData Course Project #1
library(dplyr)
library(lubridate)


### check if the data file is available, if not, get it and unzip
if (file.exists("household_power_consumption.txt") == FALSE ) {
     if (file.exists("exdata-data-household_power_consumption.zip") == FALSE) {
          url <- c("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip")
          download.file(url,"exdata-data-household_power_consumption.zip")
     } 
     unzip("exdata-data-household_power_consumption.zip")
}

data <- read.table("household_power_consumption.txt",header=TRUE,
                   sep = ";",na.strings = "?",
                   colClasses = c("character","character",rep("numeric",7)))
data$Date <- dmy(data$Date)        ### uses lubridate package to convert from character to POSXct object
#data$Time <- strptime(data$Time,"%H:%M:%S")    ### converts Time from chacter to a POSXct object

data2 <- tbl_df(data)              ### convert to data_table using dplyr package
sdata <- filter(data2,Date == dmy("01/02/2007") | 
                     Date == dmy("02/02/2007") )  ### subset the data for days of interest

png(file = "plot1.png",width = 480, height = 480)    ### open png file
hist(sdata$Global_active_power,col="red",xlab = "Global Active Power (kilowatts)",
     main="Global Active Power")  ### create plot
dev.off()    ### close png file

