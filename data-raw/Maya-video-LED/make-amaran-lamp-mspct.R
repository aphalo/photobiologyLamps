library(photobiology)
library(ggspectra)
library(lubridate)

# clear workspace
rm(list = ls(pattern = "*"))

file <- list.files(path = "data-raw/Maya-video-LED/LEDs-2022-09-10",
                   pattern = "^collection\\.amaran.*\\.[Rr]da$",
                   full.names = TRUE)

load(file)

rm(list = ls(pattern = "*raw.lst"))

spectrum<- ls(pattern = "\\.mspct")[1]

new.names <- "amaran_m9.mspct"
lamp.info <- gsub("\\.mspct$", "", new.names)
lamp.info <- gsub("\\.|_", " ", lamp.info)

names(lamp.info) <- spectrum

lamp.type <- "LED cool-white video"
names(lamp.type) <- spectrum

names(new.names) <- spectrum

how.measured <- "Array spectrometer, Ocean Optics Maya 2000 Pro; Bentham cosine diffuser D7H; distance unknown."

temp.mspct <- get(spectrum)[1:6]
names(temp.mspct)

summary(temp.mspct)

comment.text <- lamp.info
for (i in names(temp.mspct)) {
  temp.spct <- temp.mspct[[i]]
  what.measured <- paste(lamp.type, "lamp:", gsub("power", "dimmed", what_measured(temp.spct)))
  what.measured <- gsub("max ", "", what.measured)
  if (grepl("\\.1\\.spct", i)) {
    what.measured <- gsub("3/9", "1/9", what.measured)
  }
  # temp.spct <- normalize(temp.spct)
  temp.spct <- smooth_spct(temp.spct, method = "supsmu")
  temp.spct <- thin_wl(temp.spct, max.slope.delta = 0.001)
  temp.spct <- trim_wl(temp.spct, c(390, NA), fill = 0)
  setHowMeasured(temp.spct, how.measured)
  setWhatMeasured(temp.spct, what.measured)
  comment(temp.spct) <- NULL
  temp.spct <- trimInstrDesc(temp.spct)
  temp.spct <- trimInstrSettings(temp.spct)
  print(str(get_attributes(temp.spct)))
  print(autoplot(temp.spct, annotations = c("+", "title:what:when:comment")))
  temp.mspct[[i]] <- temp.spct
}
assign(new.names, temp.mspct)

names(amaran_m9.mspct) <- 
  paste("dimmed at ", c(9, 7, 5, 3, 1, 0), "/9", sep = "")

save(amaran_m9.mspct, file = "data/amaran-m9.mspct.rda")
