library(photobiology)
library(ggspectra)
library(lubridate)

# clear workspace
rm(list = ls(pattern = "*"))

files <- list.files(path = "data-raw/Maya-incandescent-lamps",
                    pattern = ".spct.[Rr]da",
                    full.names = TRUE)

for (f in files) {
  load(f)
}

rm(list = ls(pattern = "*raw.mspct"))

spectra <- ls(pattern = "\\.spct")

lamp.desc <- c("Osram classic incandescent light bulb 20W E27",
               "Philips Twist Alu halogen spot lamp 40 degrees 50W GU10")
                    
names(lamp.desc) <- spectra

new.names <- c("Osram.Inc.20W",
               "Philips.Inc.50W.spot.halogen")
  
names(new.names) <- spectra

how.measured <- "Array spectrometer, Ocean Optics Maya 2000 Pro; Bentham cosine diffuser D7H; distance unknown."

comment.text <- "Tungsten incandescent lamps, quartz halogen or traditional, intended for household illumination have become rare."

maya_incandescent_lamps.mspct <- source_mspct()
for (s in spectra) {
  what.measured <- gsub("\\.", " ", gsub("Inc\\.", "", new.names[s]))
  what.measured <- paste("Incandescent lamp:", what.measured)
  temp.spct <- get(s)
  temp.spct <- normalize(temp.spct)
  temp.spct <- trim_wl(temp.spct, range = c(315, 800))
  temp.spct <- thin_wl(temp.spct)
  setHowMeasured(temp.spct, how.measured)
  setWhatMeasured(temp.spct, what.measured)
  temp.spct <- clean(temp.spct)
  comment(temp.spct) <- paste(lamp.desc, comment.text, sep = "\n")
  trimInstrDesc(temp.spct)
  trimInstrSettings(temp.spct)
  print(str(get_attributes(temp.spct)))
  print(autoplot(temp.spct, span = 25,
                 annotations = c("+", "title:what:when:comment")))
  maya_incandescent_lamps.mspct[[new.names[s]]] <- temp.spct
  readline("next:")
}

length(maya_incandescent_lamps.mspct)

save(maya_incandescent_lamps.mspct, file = "data-raw/rda/maya-incandescent-lamps.mspct.rda")
