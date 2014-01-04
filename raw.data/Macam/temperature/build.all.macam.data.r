library(photobiology)
library(reshape2)
library(plyr)

qp.t.wide.data <- read.csv("~/Rpackages/photobiologyLamps/raw.data/Macam/temperature/qpanel.uvb313.t.csv")
qp.t.melted.data <- melt(qp.t.wide.data, id="w.length", value.name="s.e.irrad", variable.name="temp.code")

temp.vec <- c(-5,-5,0,0,5,10,10,20,20,30,30,35,35)
replicate.vec <- 1:length(temp.vec)
names(temp.vec) <- names(qp.t.wide.data[-1])
names(replicate.vec) <- names(qp.t.wide.data[-1])

qp.t.melted.data$temperature <- with(qp.t.melted.data, temp.vec[temp.code])
qp.t.melted.data$replicate <- with(qp.t.melted.data, replicate.vec[temp.code])

qpanel.uvb313.temperature.data <- ddply(qp.t.melted.data, .(temperature, w.length), summarise, s.e.irrad=mean(s.e.irrad))
qpanel.uvb313.temperature.data$s.q.irrad <- with(qpanel.uvb313.temperature.data, as_quantum_mol(w.length, s.e.irrad))

qp.t.split <- split(qpanel.uvb313.temperature.data, as.factor(qpanel.uvb313.temperature.data$temperature))
qpanel.uvb313.minus5C.data <- as.data.frame(qp.t.split$"-5")[-1]
qpanel.uvb313.00C.data <- as.data.frame(qp.t.split$"0")[-1]
qpanel.uvb313.05C.data <- as.data.frame(qp.t.split$"5")[-1]
qpanel.uvb313.10C.data <- as.data.frame(qp.t.split$"10")[-1]
qpanel.uvb313.20C.data <- as.data.frame(qp.t.split$"20")[-1]
qpanel.uvb313.30C.data <- as.data.frame(qp.t.split$"30")[-1]
qpanel.uvb313.35C.data <- as.data.frame(qp.t.split$"35")[-1]


save(qpanel.uvb313.temperature.data, file="~/Rpackages/photobiologyLamps/data/qpanel.uvb313.temperature.data.rda")

