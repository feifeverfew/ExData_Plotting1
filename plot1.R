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
#plot a histogram file and save it as plot1.png
png(filename ='plot1.png', width = 480, height = 480)
hist(df_sub$Global_active_power, col = "red", main ="Global Active Power", ylab ="Frequency", xlab ="Global Active Power (kilowatts)")
dev.off()