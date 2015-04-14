library(photobiology)
library(reshape2)
library(plyr)

qp.t.wide.data <- read.csv("./raw.data/Macam/temperature/qpanel.uvb313.t.csv")
qp.t.melted.data <- melt(qp.t.wide.data, id="w.length", value.name="s.e.irrad", variable.name="temp.code")

temp.vec <- c(-5,-5,0,0,5,10,10,20,20,30,30,35,35)
replicate.vec <- 1:length(temp.vec)
names(temp.vec) <- names(qp.t.wide.data[-1])
names(replicate.vec) <- names(qp.t.wide.data[-1])

qp.t.melted.data$temperature <- with(qp.t.melted.data, temp.vec[temp.code])
qp.t.melted.data$replicate <- with(qp.t.melted.data, replicate.vec[temp.code])

spct.names <- ls(pattern="C.spct")
qpanel.uvb313.temp.spct <- ddply(qp.t.melted.data, .(temperature, w.length), summarise, s.e.irrad=mean(s.e.irrad))

setSourceSpct(qpanel.uvb313.temp.spct)
e2q(qpanel.uvb313.temp.spct, action = "add", byref = TRUE)
setkey(qpanel.uvb313.temp.spct, temperature, w.length)
qpanel.uvb313.minus5C.spct <- subset(qpanel.uvb313.temp.spct, temperature == -5)
qpanel.uvb313.00C.spct <- subset(qpanel.uvb313.temp.spct, temperature == 0)
qpanel.uvb313.05C.spct <- subset(qpanel.uvb313.temp.spct, temperature == 5)
qpanel.uvb313.10C.spct <- subset(qpanel.uvb313.temp.spct, temperature == 10)
qpanel.uvb313.20C.spct <- subset(qpanel.uvb313.temp.spct, temperature == 20)
qpanel.uvb313.30C.spct <- subset(qpanel.uvb313.temp.spct, temperature == 30)
qpanel.uvb313.35C.spct <- subset(qpanel.uvb313.temp.spct, temperature == 35)

spct.names <- ls(pattern = "C.spct")

save(list = spct.names, file="./data/qpanel.uvb313.temperature.spct.rda")

save(qpanel.uvb313.temp.spct, file="./data/qpanel.uvb313.temp.spct.rda")

