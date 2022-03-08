library(magrittr)
library(photobiology)
philips.BLB.tld108 <- read.csv2("data-raw/Philips/TLD-36W-BLB-108.csv",
                      skip = 1, header = FALSE, col.names = c("w.length", "s.q.irrad"))
philips.BLB.tld108.spct <- as.source_spct(philips.BLB.tld108) %>% clean() %>% normalize()

philips.BLB.tld108.spct <- 
  interpolate_wl(philips.BLB.tld108.spct, w.length.out = 250:800, fill = 0) %>%
  normalise()
range(philips.BLB.tld108.spct)
setWhatMeasured(philips.BLB.tld108.spct, 
                "Blacklight blue \"BLB\" 36W fluorescent tube spectrum, Philips, Finland")
setHowMeasured(philips.BLB.tld108.spct, 
               "Digitized from figure in manufacturer's brochure.")

philips.mspct <- source_mspct(list(Philips.FT.TLD.36W.BLB.108 = philips.BLB.tld108.spct))

save(philips.mspct, file = "data-raw/philips-mspct.rda")

library(ggspectra)
print(autoplot(philips.BLB.tld108.spct))
