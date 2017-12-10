##
## This is the main file of the project. It is intended to manage the following tasks:
##
## 1. Download the rough data into the dedicated directory(roughDataDirectory).
## 2. Unpack the rough data into the same directory.
## 3. Make the rough data tidy.
## 4. Save the tidy data into the dedicated directory(newDataSetDirectory).
## 5. Filter out the necessary rows(dates between 2007-02-01 and 2007-02-02) and
##    save the data into the same directory.
##
roughDataUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
roughDataDirectory <- "tmpRoughData"
newDataSetDirectory <- "data"

source(file = "helpers.R")
source(file = "getRoughDataClass.R")
##
## Load external libraries
##
weNeed <- c("tools", "dplyr", "data.table")

tmpLoadResult <- loadLibraries(weNeed)

if(TRUE == tmpLoadResult){
    # It's okay! Do nothing here!
    rm(tmpLoadResult)
} else {
    # Upps, we've a problem loading the necessary external libraries!
    stop(paste("The", tmpLoadResult, "library cannot be loaded.", sep = " "))
}

##
## Make the temporary rough data set directory.
if(TRUE == file.exists(roughDataDirectory)){
    # Do nothing.
} else {
    dir.create(roughDataDirectory)
}

## Create the rough data object
oRoughData <- GetRoughData$new(fileUrl = roughDataUrl)

## Set the rough data file name
oRoughData$roughFileName()

## Set the rough data file path
oRoughData$roughFilePath(roughDataDirectory, "")

## Check if the file does exist in the working directory.
oRoughData$roughFileDoesExist(oRoughData$fileName)
if(TRUE == oRoughData$fileDoesExist) {
    # The file does exist. Do nothing here!
} else {
    # We have to download the rough data file!
    oRoughData$roughFileDownload(roughDataUrl)
    # Recheck if the file does exist in the working directory.
    oRoughData$roughFileDoesExist(oRoughData$fileName)
    if(FALSE == oRoughData$fileDoesExist) {
        # Something went wrong downloading the rough data file!
        stop("Something went wrong trying to download the rough data from ", roughDataUrl)
    }
}
##
## Unpack the rough data file.
oRoughData$roughFileUnPack(oRoughData$fileName)
##
## Check for the "txt" file.
fileLst <- list.files(path = oRoughData$filePath, pattern = "*.txt", full.names = TRUE)
##
if(1 != length(fileLst) || nchar(fileLst) < 1){
    stop("There are to many rough files!")
}

##
## Load the rough data file into a table.

result <- read.table(file = fileLst, header = TRUE, stringsAsFactors = FALSE, sep = ";",
                     na.strings=c("?", ""), # get "the classic R" NA
                     colClasses = c(rep(c("character"), times = 2), rep(c("numeric"), times = 7)),
                     blank.lines.skip = TRUE)

##
## Make the data tidy.

result <- result %>% rename_at(names(result), funs(tolower)) %>%
                     mutate(date = as.POSIXct(paste(as.Date(date, format="%d/%m/%Y"), time),
                                              format="%Y-%m-%d %H:%M:%S")) %>%
                     select(-time) %>% # the time is already included into date
                     rename(datetime_stamp = date)

##
## Make the new data set directory.
if(TRUE == file.exists(newDataSetDirectory)){
    # Do nothing.
} else {
    dir.create(newDataSetDirectory)
}

##
##===============================================================================
## Save the "tidy data" into: "data/oRoughData$fileName.csv" file.
##
write.table(format(result, nsmall = 3), file = file.path(newDataSetDirectory,
                                                         paste0(file_path_sans_ext(oRoughData$fileName), ".csv"),
                                                         fsep = .Platform$file.sep),
            append = FALSE, sep = ",", dec = ".", row.names = FALSE, col.names = TRUE, quote = FALSE)
##
##===============================================================================
## Filter out the necessary rows(dates between 2007-02-01 and 2007-02-02).
##
result <- filter(result, "2007-02-01 00:00:00" <= datetime_stamp & datetime_stamp < "2007-02-03 00:00:00")

##
##===============================================================================
## Save the "short tidy data" into: "data/oRoughData$fileName_short.csv" file(just in case).
##
write.table(format(result, nsmall = 3), file = file.path(newDataSetDirectory,
                                                         paste0(file_path_sans_ext(oRoughData$fileName),
                                                                "_short", ".csv"),
                                                         fsep = .Platform$file.sep),
            append = FALSE, sep = ",", dec = ".", row.names = FALSE, col.names = TRUE, quote = FALSE)

##
## Now we have the tidy data for the graphics.
##

#stop('okay')
