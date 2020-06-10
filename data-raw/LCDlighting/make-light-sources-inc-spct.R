library(magrittr)
library(photobiology)
LCDlighting.UVA.BL <- read.csv2("data-raw/LCDlighting/LightSources-UVA-BL-350nm.csv",
                      skip = 1, header = FALSE, col.names = c("w.length", "s.q.irrad"))
LCDlighting.UVA.BL.spct <- as.source_spct(LCDlighting.UVA.BL) %>% clean()

LCDlighting.UVA.BL.spct <- 
  interpolate_wl(LCDlighting.UVA.BL.spct, w.length.out = 250:800, fill = 0) %>%
  normalise()
range(LCDlighting.UVA.BL.spct)
setWhatMeasured(LCDlighting.UVA.BL.spct, 
                "Blacklight UVA BL fluorescent tube spectrum, LightSources Inc, USA/Hungary.")
setHowMeasured(LCDlighting.UVA.BL.spct, 
               "Digitized from figure in manufacturer's image in web site.")

LCDlighting.mspct <- source_mspct(list(LCDlighting.UVA.BL = LCDlighting.UVA.BL.spct))

save(LCDlighting.mspct, file = "data-raw/LCDlighting-mspct.rda")

library(ggspectra)
print(autoplot(LCDlighting.UVA.BL.spct))
