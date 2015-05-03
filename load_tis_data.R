#load_tis_data.R

datafiles <- list.files(path = 'data', pattern = 'min.csv')
filenames <- paste(substr(datafiles, 6, 13), substr(datafiles, 32, 39), sep = '')
