# Load the data
data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", 
                   na.strings="?", stringsAsFactors=FALSE)

# Convert Date to Date format and filter for the dates 2007-02-01 to 2007-02-02
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
subset_data <- subset(data, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

# Plot
png("plot1.png", width=480, height=480)
hist(subset_data$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()



# Combine Date and Time into a single datetime column for plotting
subset_data$DateTime <- as.POSIXct(paste(subset_data$Date, subset_data$Time), format="%Y-%m-%d %H:%M:%S")

# Plot
png("plot2.png", width=480, height=480)
plot(subset_data$DateTime, subset_data$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()

# Plot
png("plot3.png", width=480, height=480)
plot(subset_data$DateTime, subset_data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", col="black")
lines(subset_data$DateTime, subset_data$Sub_metering_2, col="red")
lines(subset_data$DateTime, subset_data$Sub_metering_3, col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"))
dev.off()

# Plot
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))

# Sub-plot 1: Global Active Power
plot(subset_data$DateTime, subset_data$Global_active_power, type="l", xlab="", ylab="Global Active Power")

# Sub-plot 2: Voltage
plot(subset_data$DateTime, subset_data$Voltage, type="l", xlab="datetime", ylab="Voltage")

# Sub-plot 3: Energy Sub-metering
plot(subset_data$DateTime, subset_data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(subset_data$DateTime, subset_data$Sub_metering_2, col="red")
lines(subset_data$DateTime, subset_data$Sub_metering_3, col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"))

# Sub-plot 4: Global Reactive Power
plot(subset_data$DateTime, subset_data$Global_reactive_power, type="l", xlab="datetime", ylab="Global Reactive Power")

dev.off()
