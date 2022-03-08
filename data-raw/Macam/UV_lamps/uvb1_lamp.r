library(photobiology)
library(ggspectra)
library(lubridate)

rm(list = ls(pattern = "*"))

oldwd <- setwd("./data-raw/Macam/UV_lamps")

how.measured <- "Measured with MACAM double monochromator scaning spectrometer PCxxx"
what.measured <- "Fluorescent tube: "
when.measured <- ymd("1997-05-19")

qpanel.uvb313.data <- read.csv(file="Q-Panel_UVB-313.csv", skip=2, header=FALSE, col.names=c("w.length", "s.e.irrad"), nrows=561)
qpanel.uvb313.spct <- setSourceSpct(qpanel.uvb313.data)
what_measured(qpanel.uvb313.spct) <- "Fluorescent tube: QPanel UVB-313 40W"
when_measured(qpanel.uvb313.spct) <- when.measured
how_measured(qpanel.uvb313.spct) <- how.measured

qpanel.uva340.data <- read.csv(file="Q-Panel_UVA-340.csv", skip=2, header=FALSE, col.names=c("w.length", "s.e.irrad"), nrows=561)
qpanel.uva340.spct <- setSourceSpct(qpanel.uva340.data)
what_measured(qpanel.uva340.data) <- "Fluorescent tube: QPanel UVB-340 40W"
when_measured(qpanel.uva340.data) <- when.measured
how_measured(qpanel.uva340.data) <- how.measured

philips.tl12.data <- read.csv(file="Philips_TL12.csv", skip=2, header=FALSE, col.names=c("w.length", "s.e.irrad"), nrows=561)
philips.tl12.spct <- setSourceSpct(philips.tl12.data)
what_measured(philips.tl12.data) <- "Fluorescent tube: Philips TL12 40W"
when_measured(philips.tl12.data) <- when.measured
how_measured(philips.tl12.data) <- how.measured

macam.mspct <- normalize(source_mspct(list(QPanel.FT.UVB313.40W = qpanel.uvb313.spct,
                                           QPanel.FT.UVB340.40W = qpanel.uva340.spct,
                                           Philips.FT.TL.40W.12 = philips.tl12.spct)))

save(macam.mspct, file="../../macam-mspct.rda")

setwd(oldwd)
