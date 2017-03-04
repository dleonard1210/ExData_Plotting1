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

png(file="plot1.png",width = 480, height = 480)
hist(df$Global_active_power,col="red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()

