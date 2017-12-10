##
## Build the "plot1.png"(480x480 pixels) graphic.
##

plotFile <- "plot1.png"
dataFrameName <- 'result'
##
## Check if the data is already loaded(the 'result' data frame does exist).
## Generate the 'result' data frame if it's necessary.
##
if (!(exists(dataFrameName) && is.data.frame(get(dataFrameName)))) {
    # We have to generate the 'result' data frame!
    source(file = "run_me_first.R")
    # Recheck if the 'result' data frame does exist.
    if (!(exists(dataFrameName) && is.data.frame(get(dataFrameName)))) {
        # Upps, we've a problem trying to generate the 'result' data frame!
        stop("The script 'run_me_first.R' is not able to generate the 'result' data frame.")
    }
}

##
## Initialize(open) the graphics device.
##
png(filename = plotFile,
    width = 480, height = 480, units = "px",
    pointsize = 12, bg = "white", res = NA)
##
## Generate the plot.
##
hist(get(dataFrameName)$global_active_power,
     main = "Global Active Power",
     xlab = "Global Active Power(kilowats)",
     col = "red")
##
## Close the graphics device.
##
dev.off()
