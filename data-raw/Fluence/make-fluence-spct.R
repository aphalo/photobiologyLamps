library(magrittr)
library(photobiology)
AnthoSpec <- read.csv("data-raw/Fluence/AnthoSpec-RAY.csv",
                      skip = 1, header = FALSE, col.names = c("w.length", "s.q.irrad"))
PhysioSpecGreenhouse <- read.csv("data-raw/Fluence/PhysioSpecGreenhouseRAY.csv",
                      skip = 1, header = FALSE, col.names = c("w.length", "s.q.irrad"))
AnthoSpec.spct <- as.source_spct(AnthoSpec) %>% clean() %>% normalize()
PhysioSpecGreenhouse.spct <- as.source_spct(PhysioSpecGreenhouse) %>% clean() %>% normalize()

AnthoSpec.spct <- interpolate_wl(AnthoSpec.spct, w.length.out = 360:830, fill = 0)
PhysioSpecGreenhouse.spct <- interpolate_wl(PhysioSpecGreenhouse.spct, w.length.out = 360:830, fill = 0)
nrow(AnthoSpec.spct)
range(AnthoSpec.spct)
setWhatMeasured(AnthoSpec.spct, "RAY LED grow light bar, AnthoSpec spectrum, Osram-Fluence, USA")
setWhatMeasured(PhysioSpecGreenhouse.spct, "RAY LED grow light bar, PhysioSpecGreenhouse spectrum, Osram-Fluence, USA")
setHowMeasured(AnthoSpec.spct, "Digitized from figure in manufacturer's brochure.")
setHowMeasured(PhysioSpecGreenhouse.spct, "Digitized from figure in manufacturer's brochure.")

fluence.mspct <- source_mspct(list(fluence.AnthoSpec = AnthoSpec.spct,
                                   fluence.PhysioSpecGreenhouse = PhysioSpecGreenhouse.spct))

save(fluence.mspct, file = "data-raw/fluence-mspct.rda")

