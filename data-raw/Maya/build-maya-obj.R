library(photobiology)

load("./data-raw/Maya/germicidal.spct.rda")

oo_maya.mspct <- normalize(source_mspct(list(germicidal = germicidal.spct)))

save(oo_maya.mspct, file="./data/oo-maya-mspct.rda")