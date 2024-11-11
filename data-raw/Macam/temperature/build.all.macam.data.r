library(photobiology)
library(reshape2)
library(plyr)

# clean up
rm(list = ls(pattern = "*"))

qp.t.wide.data <- read.csv("./data-raw/Macam/temperature/qpanel.uvb313.t.csv")
qp.t.melted.data <- melt(qp.t.wide.data, id.vars="w.length", value.name="s.e.irrad", variable.name="temp.code")

temp.vec <- c(-5,-5,0,0,5,10,10,20,20,30,30,35,35)
replicate.vec <- 1:length(temp.vec)
names(temp.vec) <- names(qp.t.wide.data[-1])
names(replicate.vec) <- names(qp.t.wide.data[-1])

qp.t.melted.data$temperature <- with(qp.t.melted.data, temp.vec[temp.code])
qp.t.melted.data$replicate <- with(qp.t.melted.data, replicate.vec[temp.code])

qpanel.uvb313.temp.spct <- ddply(qp.t.melted.data, .(temperature, w.length), summarise, s.e.irrad=mean(s.e.irrad))

setSourceSpct(qpanel.uvb313.temp.spct, multiple.wl = 7)

lamp.info <- "Flourescent tube: Q-Panel UVB313 40W at"
qpanel.uvb313.minus5C.spct <- subset(qpanel.uvb313.temp.spct, temperature == -5)
what_measured(qpanel.uvb313.minus5C.spct) <- paste(lamp.info, "-5C")
qpanel.uvb313.00C.spct <- subset(qpanel.uvb313.temp.spct, temperature == 0)
what_measured(qpanel.uvb313.00C.spct) <- paste(lamp.info, "0C")
qpanel.uvb313.05C.spct <- subset(qpanel.uvb313.temp.spct, temperature == 5)
what_measured(qpanel.uvb313.05C.spct) <- paste(lamp.info, "5C")
qpanel.uvb313.10C.spct <- subset(qpanel.uvb313.temp.spct, temperature == 10)
what_measured(qpanel.uvb313.10C.spct) <- paste(lamp.info, "10C")
qpanel.uvb313.20C.spct <- subset(qpanel.uvb313.temp.spct, temperature == 20)
what_measured(qpanel.uvb313.20C.spct) <- paste(lamp.info, "20C")
qpanel.uvb313.30C.spct <- subset(qpanel.uvb313.temp.spct, temperature == 30)
what_measured(qpanel.uvb313.30C.spct) <- paste(lamp.info, "30C")
qpanel.uvb313.35C.spct <- subset(qpanel.uvb313.temp.spct, temperature == 35)
what_measured(qpanel.uvb313.35C.spct) <- paste(lamp.info, "35C")

qp_uvb313_temp.mspct <- source_mspct(list(minus05C = qpanel.uvb313.minus5C.spct,
                                          plus00C = qpanel.uvb313.00C.spct,
                                          plus05C = qpanel.uvb313.05C.spct,
                                          plus10C = qpanel.uvb313.10C.spct,
                                          plus20C = qpanel.uvb313.20C.spct,
                                          plus30C = qpanel.uvb313.30C.spct,
                                          plus35C = qpanel.uvb313.35C.spct))

when_measured(qp_uvb313_temp.mspct) <- as.POSIXct(ymd("1997-05-19"))
how_measured(qp_uvb313_temp.mspct) <- "Measured with MACAM double monochromator scaning spectrometer PCxxx"

what_measured(qp_uvb313_temp.mspct)
when_measured(qp_uvb313_temp.mspct)
how_measured(qp_uvb313_temp.mspct)

save(qp_uvb313_temp.mspct, file="./data/qp-uvb313-temp-mspct.rda")

qp_uvb313_temp.spct <- qpanel.uvb313.temp.spct
what_measured(qp_uvb313_temp.spct) <- paste(lamp.info, "-5C to 35C")
when_measured(qp_uvb313_temp.spct) <- ymd("1997-05-19")
how_measured(qp_uvb313_temp.spct) <- "Measured with MACAM double monochromator scaning spectrometer PCxxx"

save(qp_uvb313_temp.spct, file="./data/qp-uvb313-temp-spct.rda")

