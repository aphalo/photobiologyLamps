library(photobiology)
library(ggspectra)
library(lubridate)

# clear workspace
rm(list = ls(pattern = "*"))

files <- list.files(path = "data-raw/Maya-flash",
                    pattern = ".spct.[Rr]da",
                    full.names = TRUE)

for (f in files) {
  load(f)
}

rm(list = ls(pattern = "*raw.mspct"))

spectra <- ls(pattern = "\\.spct")

lamp.type <- rep("Xenon flash:", 4L)
                    
names(lamp.type) <- spectra

new.names <- c("Godox.XeF.AD200.H200j.ADFT200.flash",
               "Godox.XeF.AD200.H200.flash",
               "Godox.XeF.AD200.H200R.flash",
               "Godox.XeF.AD200.H200j.FTSTS40w.flash")
  
names(new.names) <- spectra

how.measured <- "Array spectrometer, Ocean Optics Maya 2000 Pro; Bentham cosine diffuser D7H; Flash power setting: 1/128, distance unknown."

comment.text <- "The AD200 flash from Godox has interchangeable heads: speedlight = H200, round = H200R, bare lamp holder = H200j.\nThe bare lamp or flash tube ADFT200 is the default for H200j. The bare lamp FTSTS40w was supplied by Xenon Flash Tubes (Israel)."

maya_flash_lamps.mspct <- source_mspct()
for (s in spectra) {
  what.measured <- gsub("\\.", " ", gsub("XF\\.", "", new.names[s]))
  what.measured <- paste(lamp.type[s], what.measured)
  temp.spct <- get(s)
  temp.spct <- normalize(temp.spct)
  temp.spct <- trim_wl(temp.spct, range = c(315, 800))
  temp.spct <- thin_wl(temp.spct)
  setHowMeasured(temp.spct, how.measured)
  setWhatMeasured(temp.spct, what.measured)
  temp.spct <- clean(temp.spct)
  comment(temp.spct) <- comment.text
  trimInstrDesc(temp.spct)
  trimInstrSettings(temp.spct)
  print(str(get_attributes(temp.spct)))
  print(autoplot(temp.spct, span = 25,
                 annotations = c("+", "title:what:when:comment")))
  maya_flash_lamps.mspct[[new.names[s]]] <- temp.spct
  readline("next:")
}

length(maya_flash_lamps.mspct)
summary(maya_flash_lamps.mspct)
what_measured(maya_flash_lamps.mspct)
how_measured(maya_flash_lamps.mspct)
comment(maya_flash_lamps.mspct)

save(maya_flash_lamps.mspct, file = "data-raw/maya-flash-lamps.mspct.rda")
