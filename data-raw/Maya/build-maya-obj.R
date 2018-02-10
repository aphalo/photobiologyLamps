rm(list = ls(pattern = "*"))

library(photobiology)

load("./data-raw/Maya/germicidal.spct.rda")
load("./data-raw/Maya/test_led_desk01.spct.Rda")

trimInstrDesc(test_led_desk01.spct)
setWhatMeasured(test_led_desk01.spct, "Warm white LED bulb, x W, 230 V, E-27")

oo_maya.mspct <- normalize(source_mspct(list(germicidal = germicidal.spct,
                                             ww_led_bulb = test_led_desk01.spct)))

save(oo_maya.mspct, file="./data-raw/oo-maya-mspct.rda")

tools::resaveRdaFiles("data", compress="auto")
print(tools::checkRdaFiles("data"))
