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
hpc_fsort[,3]=as.character(hpc_fsort[,3])
hpc_fsort[,3]=as.double(hpc_fsort[,3])
hist(hpc_fsort$Global_active_power, col="red", main = "Global Active Power", xlab = "Global Active Power (killowatts)")
dev.cur()
png(file="plot1.png", bg="white", width = 480, height = 480)
hist(hpc_fsort$Global_active_power, col="red", main = "Global Active Power", xlab = "Global Active Power (killowatts)")
dev.off()





