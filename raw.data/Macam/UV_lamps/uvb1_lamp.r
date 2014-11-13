library(photobiology)
oldwd <- setwd("./raw.data/Macam/UV_lamps")

qpanel.uvb313.data <- read.csv(file="Q-Panel_UVB-313.csv", skip=2, header=FALSE, col.names=c("w.length", "s.e.irrad"), nrows=561)
qpanel.uvb313.spct <- e2q(setSourceSpct(qpanel.uvb313.data))
save(qpanel.uvb313.spct, file="./data/qpanel.uvb313.spct.rda")

qpanel.uva340.data <- read.csv(file="Q-Panel_UVA-340.csv", skip=2, header=FALSE, col.names=c("w.length", "s.e.irrad"), nrows=561)
qpanel.uva340.spct <- e2q(setSourceSpct(qpanel.uva340.data))
save(qpanel.uva340.spct, file="../../../data/qpanel.uva340.spct.rda")

philips.tl12.data <- read.csv(file="Philips_TL12.csv", skip=2, header=FALSE, col.names=c("w.length", "s.e.irrad"), nrows=561)
philips.tl12.spct <- e2q(setSourceSpct(philips.tl12.data))
save(philips.tl12.spct, file="../../../data/philips.tl12.spct.rda")

setwd(oldwd)
