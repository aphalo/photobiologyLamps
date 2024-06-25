# Spectrometer unknown
#
# Lamps type
# Osram T8 L 36 W/865 Lumilux (from Luis)
# Osram T8 L 58 W/865 Lumilux (from Fang)

library(photobiology)
library(photobiologyWavebands)
library(photobiologyInOut)
library(ggspectra)
library(gginnards)
library(dplyr)

photon_as_default()

if (!file.exists("growth-room-fluorescent.rda")) {
  spectra <- rbind(r1left, r2left, r3left, r4left)
  save(spectra, )
  names(spectra)[2] <- "s.e.irrad"
  spectra$room <- factor(spectra$room)
  spectra$side <- factor(spectra$side)
  spectra$room.side <- factor(paste(spectra$room, spectra$side, sep = "."))
  
  spectra |>
    group_by(wavelength) |>
    summarise(s.e.irrad = median(s.e.irrad) * 1e4) -> md.spectra
  
  spectra.spct <- as.source_spct(md.spectra)
  save(spectra, spectra.spct, file = "growth-room-fluorescent.rda")
} else {
  load("growth-room-fluorescent.rda")
}

spct_CCT(spectra.spct)

(autoplot(fscale(spectra.spct, range = PAR(), f = q_irrad, target = 220e-6), 
         w.band = Plant_bands("CIE"), range = c(280, 800), span = 51) + 
  theme_classic()) |>
  append_layers(geom_hline(yintercept = 0, colour = "grey50", linetype = "dotted"),
                "bottom"
) -> p1a

p1a
