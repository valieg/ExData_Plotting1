##
## Build the "plot1.png"(480x480 pixels) graphic.
##

plotFile <- "plot3.png"
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
## Get max(ylim)!!!

ylimMax <- max(max(result$sub_metering_1),
               max(result$sub_metering_2),
               max(result$sub_metering_3))

with(get(dataFrameName), plot(get(dataFrameName)$datetime_stamp,
                              get(dataFrameName)$sub_metering_1,
                              type = "l",
                              col = "black",
                              lwd = 1,
                              ylim = c(0, ylimMax),
                              main = "",
                              xlab = "",
                              ylab = "Energy sub metering"))

with(get(dataFrameName), lines(get(dataFrameName)$datetime_stamp,
                              get(dataFrameName)$sub_metering_2,
                              type = "l",
                              col = "red",
                              lwd = 1,
                              ylim = c(0, ylimMax),
                              main = "",
                              xlab = "",
                              ylab = ""))

with(get(dataFrameName), lines(get(dataFrameName)$datetime_stamp,
                              get(dataFrameName)$sub_metering_3,
                              type = "l",
                              col = "blue",
                              lwd = 1,
                              ylim = c(0, ylimMax),
                              main = "",
                              xlab = "",
                              ylab = ""))

legend("topright", lty = 1, col = c("black", "red", "blue"),
       legend = c("sub_metering_1", "sub_metering_2", "sub_metering_3"))
##
## Close the graphics device.
##
dev.off()
