## 
## Set the working directory in Windows: copy pathname to clipboard before starting
##
##path <- gsub ("\\","/",readClipboard(), fixed = TRUE)
##setwd(path)

library(dplyr)

## Use the sqldf package to filter rows of the file while reading it in
#install.packages("sqldf")
library(sqldf)

df <- tbl_df(read.csv.sql("household_power_consumption.txt", 
                          sep = ";", 
                          stringsAsFactors = FALSE,
                          sql = "select * from file where Date in ('1/2/2007','2/2/2007')"))

df<- mutate(df,DateTime = paste(Date,Time))

df$DateTime <- strptime(df$DateTime, format = "%d/%m/%Y %H:%M:%S")

## Let the plotting begin
##

png(file="plot4.png",width = 480, height = 480)
par(mfrow = c(2,2))
plot(df$DateTime, df$Global_active_power, type = "l", ylab = "Global Active Power", xlab = "")

plot(df$DateTime, df$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")

plot(df$DateTime, df$Sub_metering_1, type = "l", ylab = "Energy sub-metering", xlab = "")
lines(df$DateTime, df$Sub_metering_2, col = "red")
lines(df$DateTime, df$Sub_metering_3, col = "blue")
legend(x="topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       lty = c(1,1,1), col=c("black","red","blue"), bty = "n")

plot(df$DateTime, df$Global_reactive_power, type = "l", ylab = "Global Reactive Power", xlab = "datetime")
dev.off()

