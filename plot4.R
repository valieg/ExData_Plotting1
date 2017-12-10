##
## Build the "plot1.png"(480x480 pixels) graphic.
##

plotFile <- "plot4.png"
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

par(mfcol = c(2,2))

## This is basically plot2.R
plot(get(dataFrameName)$datetime_stamp, get(dataFrameName)$global_active_power,
     type = "l",
     col = "black",
     lwd = 1,
     main = "",
     xlab = "",
     ylab = "Global Active Power(kilowats)")

## This is basically plot3.R
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

## Here are the new plots(new for this script)

plot(get(dataFrameName)$datetime_stamp, get(dataFrameName)$voltage,
     type = "l",
     col = "black",
     lwd = 1,
     main = "",
     xlab = "datetime",
     ylab = "Voltage")

plot(get(dataFrameName)$datetime_stamp, get(dataFrameName)$global_reactive_power,
     type = "l",
     col = "black",
     lwd = 1,
     main = "",
     xlab = "datetime",
     ylab = "Global Reactive Power")

##
## Close the graphics device.
##
dev.off()
