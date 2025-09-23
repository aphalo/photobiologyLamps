library(photobiology)
library(ggspectra)
library(lubridate)

# clear workspace
rm(list = ls(pattern = "*"))

files <- list.files(path = "data-raw/Maya-LED-lamps",
                    pattern = "\\.spct\\.[Rr]da$",
                    full.names = TRUE)

for (f in files) {
  load(f)
}

rm(list = ls(pattern = "*raw.mspct"))

spectra <- ls(pattern = "\\.spct")

lamp.info <- gsub("\\.spct$|\\.lfd|\\.at\\.1m004", "", spectra)
lamp.info <- gsub("\\.fi\\.", ".", lamp.info)
lamp.info <- gsub("\\.very\\.high", "", lamp.info)
lamp.info <- gsub("\\.|_", " ", lamp.info)
lamp.info <- gsub(" lm", "lm", lamp.info)
lamp.info <- gsub("6 3", "6.3", lamp.info)
lamp.info <- gsub("9 5", "9.5", lamp.info)
lamp.info <- gsub("mosquito", "Generic mosquito", lamp.info)
lamp.info <- gsub("V Light", "V-Light", lamp.info)
lamp.info <- gsub(" no filter| 100pc| 210mm", "", lamp.info)
lamp.info <- gsub("Valoya AP67", "Valoya B50 AP67", lamp.info)
lamp.info <- gsub("Solray385", "Valoya RX600HW Solray385", lamp.info)

names(lamp.info) <- spectra

lamp.type <- ifelse(grepl("halogen", spectra), 
                     "incandescent-halogen",
                     "LED")
names(lamp.type) <- spectra

new.names <- c("Airam.LED.14W.4000K",
               "Airam.LED.11W.4000K",
               "Airam.LED.9W.3000K",
               "Amaran.M9.LED.video.light.5500K",
               "Convoy.S2plus.LED.UVA.flashlight",
               "Convoy.S2plus.LED.blue.flashlight",
               "Generic.LED.UVA.flashlight",
               "Generic.LED.NIR.flashlight",
               "Ikea.LED.6.3W.2700K",
               "Jaxman.E2.LED.flashlight",
               "Jaxman.U1c.LED.UVA.flood.flashlight",
               "Ledenergie.LED.Nano.T8.9.5W.4000K",
               "Ledstore.LED.10W.4000K",
               "Generic.LED.9W.mosquito",
               "Osram.LED.10W.2700K",
#               "Philips.halogen.50W.spot",
               "Philips.LED.T8.10W.840",
               "Valoya.LED.RX600HW.Solray385.grow.lamp",
               "Sunwayfoto.LED.FL96.at.3000K",
               "Sunwayfoto.LED.FL96.at.4000K",
               "Sunwayfoto.LED.FL96.at.5500K",
               "Ledenergie.LED.Teho.T8.9W.4000K",
               "Osram.LED.8W.2700K",
               "Toshiba.LED.9.5W.2700K",
               "Toshiba.LED.12W.2700K",
               "V.light.LED.2W.6000K",
               "Valoya.LED.B50.AP67.grow.lamp")
  
names(new.names) <- spectra

how.measured <- "Array spectrometer, Ocean Optics Maya 2000 Pro; Bentham cosine diffuser D7H; distance unknown."

maya_LED_lamps.mspct <- source_mspct()
for (s in spectra) {
  comment.text <- lamp.info[s]
  what.measured <- gsub("\\.", " ", new.names[s])
  what.measured <- gsub("LED ", "", what.measured)
  what.measured <- gsub("V light", "V-light", what.measured)
  what.measured <- gsub("6 3W", "6.3W", what.measured)
  what.measured <- gsub("9 5W", "9.5W", what.measured)
  what.measured <- gsub("plus", "+", what.measured)
  what.measured <- paste(lamp.type[s], "lamp:", what.measured)
  temp.spct <- get(s)
  temp.spct <- normalize(temp.spct)
  temp.spct <- smooth_spct(temp.spct)
  temp.spct <- thin_wl(temp.spct)
  temp.spct <- trim_wl(temp.spct, c(330, NA), fill = 0)
  setHowMeasured(temp.spct, how.measured)
  setWhatMeasured(temp.spct, what.measured)
  comment(temp.spct) <- NULL
  trimInstrDesc(temp.spct)
  trimInstrSettings(temp.spct)
  print(str(get_attributes(temp.spct)))
  print(autoplot(temp.spct, annotations = c("+", "title:what:when:comment"),
                 span = 51))
  maya_LED_lamps.mspct[[new.names[s]]] <- temp.spct
  readline("next:")
}

# maya_LED_lamps.mspct <- maya_LED_lamps.mspct[order(names(maya_LED_lamps.mspct))]

length(maya_LED_lamps.mspct)

save(maya_LED_lamps.mspct, file = "data-raw/rda/maya-LED-lamps.mspct.rda")
