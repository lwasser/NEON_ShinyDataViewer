#load_tis_data.R

datafiles <- list.files(path = 'data', pattern = 'min.csv')
filenames <- paste(substr(datafiles, 6, 13), substr(datafiles, 32, 39), sep = '')
data <- read.csv("data/NEON.D10.CPER.DP1.00001.001.000.020.002.2DWSD_2min.csv", header = TRUE, stringsAsFactors = FALSE)
data[,1] <- as.POSIXct(substr(data[,1], 1, 19), format = "%Y-%m-%dT%H:%M:%S", tz = "GMT")
data[,2] <- as.POSIXct(substr(data[,2], 1, 19), format = "%Y-%m-%dT%H:%M:%S", tz = "GMT")

