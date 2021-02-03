library(tidyverse)
library(lubridate)
# check if file exists; if not, download the file
filename <- "exdata-data-household_power_consumption.zip"
if (!file.exists (filename)) {
    fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileurl, destfile =filename, method ='curl')
}
# read downloaded file and subset the dates (01/02/2007-02/02/2007), and convert the "Date" and "Time" columns to datetime
df_sub <- read_delim(filename, delim =';', na ='?', col_types =c('ccddddddd')) %>% filter(Date %in% c('1/2/2007','2/2/2007')) %>% mutate(datetime = dmy_hms(paste(Date, Time)))
#plot the 2nd png and save it as plot2.png
png(filename ='plot2.png', width = 480, height = 480)
plot(df_sub$datetime, df_sub$Global_active_power, type = "l", ylab ='Global Active Power (kilowatts)', xlab = '', xlim = c(ymd_hms("2007-02-01 00:00:00"), ymd_hms("2007-02-03 00:00:01")))
dev.off()