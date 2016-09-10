library(photobiology)

load("./data-raw/Bentham/Bentham.raw.data.Rda")
philips.tl12.bentham.data <- philips.tl01.bentham.data <- Bentham.raw.data
philips.tl01.bentham.data$TL12 <- NULL
philips.tl12.bentham.data$TL01 <- NULL
philips.tl01.bentham.data$s.e.irrad <- 
  with(philips.tl01.bentham.data, ifelse(TL01 < 0, 0, TL01 * 1e-3))
philips.tl01.bentham.data$TL01 <- NULL
philips.tl12.bentham.data$s.e.irrad <- 
  with(philips.tl12.bentham.data, ifelse(TL12 < 0, 0, TL12 * 1e-3))
philips.tl12.bentham.data$TL12 <- NULL

philips.tl01 <- as.source_spct(philips.tl01.bentham.data)
philips.tl12 <- as.source_spct(philips.tl12.bentham.data)
bentham.mspct <- normalize(source_mspct(list(philips.tl01 = philips.tl01,
                                             philips.tl12 = philips.tl12)))

save(bentham.mspct, file="./data/bentham-mspct.rda")
