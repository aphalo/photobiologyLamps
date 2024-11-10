library(photobiology)
library(ggspectra)
library(lubridate)

# clear workspace
rm(list = ls(pattern = "*"))

files <- list.files(path = "data-raw/Maya-discharge-lamps",
                    pattern = ".spct.[Rr]da",
                    full.names = TRUE)

for (f in files) {
  load(f)
}

rm(list = ls(pattern = "*raw.mspct"))

spectra <- ls(pattern = "\\.spct")

lamp.info <- gsub("\\.spct", "", spectra)
lamp.info <- gsub("\\.|_", " ", lamp.info)
lamp.info <- gsub("airam", "Airam", lamp.info)
lamp.info <- gsub("cf", "compact fluorescent", lamp.info)
lamp.info <- gsub("L36W", "Osram L36W", lamp.info)
lamp.info <- gsub("TLD", "Philips TLD", lamp.info)
lamp.info <- gsub("BLB x2 at 94cm no filter", "Eiko F36T8 BLB 36W", lamp.info)

names(lamp.info) <- spectra

lamp.type <- ifelse(grepl("germicidal", spectra), 
                     "Low-pressure Hg tube:",
                    ifelse(grepl("TL|L36|F36T8", spectra),
                     "Fluorescent tube:",
                     "Compact fluorescent lamp:"))
                    
names(lamp.type) <- spectra

new.names <- c("Airam.CF.15W.2700K",
               "Airam.CF.Spiraali.14W.3000K",
               "Eiko.F36T8.BLB",
               "Generic.germicidal",
               "Osram.FT.L36W.840",
               "Philips.FT.TL5.35W.830.HE",
               "Philips.FT.TLD.36W.18")
  
names(new.names) <- spectra

how.measured <- "Array spectrometer, Ocean Optics Maya 2000 Pro; Bentham cosine diffuser D7H; distance unknown."

maya_discharge_lamps.mspct <- source_mspct()
for (s in spectra) {
  comment.text <- lamp.info[s]
  what.measured <- gsub("\\.", " ", new.names[s])
  what.measured <- gsub("plus", "+", what.measured)
  what.measured <- paste(lamp.type[s], what.measured)
  temp.spct <- get(s)
  temp.spct <- smooth_spct(temp.spct, wl.range = c(250, 312))
  temp.spct <- normalize(temp.spct)
  temp.spct <- thin_wl(temp.spct)
  setHowMeasured(temp.spct, how.measured)
  setWhatMeasured(temp.spct, what.measured)
  if (grepl("germicidal", s)) {
    when_measured(temp.spct) <- ymd_hms("2015-06-02 10:42:35")
  } else if (grepl("TL5", s)) {
    temp.spct <- clean(temp.spct)
  }
  comment(temp.spct) <- NULL
#  comment(temp.spct) <- comment.text
  trimInstrDesc(temp.spct)
  trimInstrSettings(temp.spct)
#  print(str(get_attributes(temp.spct)))
  print(autoplot(temp.spct, annotations = c("+", "title:what:when:comment")))
  maya_discharge_lamps.mspct[[new.names[s]]] <- temp.spct
  readline("next:")
}

length(maya_discharge_lamps.mspct)

save(maya_discharge_lamps.mspct, file = "data-raw/rda/maya-discharge-lamps.mspct.rda")
