# Use console to change the working directory to the project files
# Redacted code for privacy concerns

## Create directory
if(!dir.exists("data")) {
    dir.create("data")
}

# Downlaod data
file.url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
file.path <- "data/household_power_consumption.zip"
download.file(fileurl, file.path)

## unzip
unzip(file.path, exdir = "data")

## Load data

data <- read.table("data/household_power_consumption.txt",
                   sep = ";",
                   header = TRUE,
                   colClasses = c("character","character","double","double","double","double","double","double","numeric"),
                   na.strings="?")

## Join Date and Time to create a Timestamp
data$DT <- paste(data$Date, data$Time)
## Format Timestamp
data$DT <- strptime(data$DT, format="%d/%m/%Y %H:%M:%S")
data$Date <- strptime(data$Date, format="%d/%m/%Y")
## Subset Data only for 2007-02-01 and 2007-02-02
dat <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")


# Create Plot 3
png("plot3.png",  width = 480, height = 480, units = "px")
plot(dat$DT, dat$Sub_metering_1, type="n", ylim=c(0,40),ylab="Energy sub metering", xlab="")

## Add lines
lines(dat$DT, dat$Sub_metering_1, type="l")
lines(dat$DT, dat$Sub_metering_2, type="l", col="red")
lines(dat$DT, dat$Sub_metering_3, type="l", col="blue")

# Create Legend
legend("topright", 
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       col=c("black","red","blue"),
       lty = 1)


dev.off()