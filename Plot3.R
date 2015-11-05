getwd()

maindir <- "C:\\Personal\\Coursera\\Data Science\\Exploratory Data Analysis"
subdir <- "Work"

if (file.exists("Work")) {
  setwd(file.path(maindir, subdir))
} else {
  dir.create(file.path(maindir, subdir))
  setwd(file.path(maindir, subdir))
}

filename <- "household_power_consumption.zip"

if (!file.exists("exdata-data-household_power_consumption.txt")) {
  unzip("exdata-data-household_power_consumption.zip")
}

hpc <- read.table(dataFile, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")

head(hpc)

hpc_feb <- subset(hpc, Date %in% c("1/2/2007", "2/2/2007"))
dt <- strptime(paste(hpc_feb$Date, hpc_feb$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
hpc_final <- cbind(hpc_feb,dt)
hpc_fsort <- hpc_final[order(dt),]
hpc_fsort[,7]=as.character(hpc_fsort[,7])
hpc_fsort[,7]=as.double(hpc_fsort[,7])
hpc_fsort[,8]=as.character(hpc_fsort[,8])
hpc_fsort[,8]=as.double(hpc_fsort[,8])
hpc_fsort[,9]=as.character(hpc_fsort[,9])
hpc_fsort[,9]=as.double(hpc_fsort[,9])

png("plot3.png", width=480, height=480)
plot(hpc_fsort$dt,hpc_fsort$Sub_metering_1, type="l", ylab="Energy Submetering", xlab="")
lines(hpc_fsort$dt,hpc_fsort$Sub_metering_2, type="l", col="red")
lines(hpc_fsort$dt,hpc_fsort$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
dev.off()
