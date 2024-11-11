library(photobiology)
library(ggspectra)
library(lubridate)

# clear workspace
rm(list = ls(pattern = "*"))

file <- list.files(path = "data-raw/Maya-video-LED/Andoer-IR-49",
                   pattern = "^collection.*\\.[Rr]da$",
                   full.names = TRUE)

load(file)

rm(list = ls(pattern = "*raw.lst"))

spectrum<- ls(pattern = "\\.mspct")[1]

new.names <- "andoer_ir49.mspct"
lamp.info <- gsub("\\.irrad\\.mspct$|collection\\.", "", spectrum)
lamp.info <- gsub("\\.|_", " ", lamp.info)

names(lamp.info) <- spectrum

lamp.type <- "LED IR video"
names(lamp.type) <- spectrum

names(new.names) <- spectrum

how.measured <- "Array spectrometer, Ocean Optics Maya 2000 Pro; Bentham cosine diffuser D7H; distance unknown."

temp.mspct <- get(spectrum)[1:2]
names(temp.mspct)

summary(temp.mspct)

comment.text <- lamp.info
for (i in names(temp.mspct)) {
  temp.spct <- temp.mspct[[i]]
  what.measured <- paste(lamp.type, "lamp:", gsub("power", "dimmed", 
                                                  gsub("\\.", " ", what_measured(temp.spct))))
  what.measured <- gsub("IR 49", "IR49S", what.measured)
  what.measured <- gsub("100", "at max ", what.measured)
  what.measured <- gsub("min", "at min", what.measured)
  what.measured <- gsub("pc", "power", what.measured)
  if (grepl("\\.1\\.spct", i)) {
    what.measured <- gsub("3/9", "1/9", what.measured)
  }
  # temp.spct <- normalize(temp.spct)
  temp.spct <- smooth_spct(temp.spct, method = "supsmu")
  temp.spct <- thin_wl(temp.spct, max.slope.delta = 0.001, max.wl.step = 10)
  temp.spct <- trim_wl(temp.spct, c(700, NA), fill = 0)
  setHowMeasured(temp.spct, how.measured)
  setWhatMeasured(temp.spct, what.measured)
  comment(temp.spct) <- NULL
  temp.spct <- trimInstrDesc(temp.spct)
  temp.spct <- trimInstrSettings(temp.spct)
  print(str(get_attributes(temp.spct)))
  print(autoplot(temp.spct, annotations = c("+", "title:what:when:comment")) + geom_point())
  temp.mspct[[i]] <- temp.spct
}
assign(new.names, temp.mspct)

names(andoer_ir49.mspct) <- 
  paste("dimmed.", gsub("Andoer\\.IR\\.49\\.|\\.spct", "", names(andoer_ir49.mspct)), sep = "") |>
  gsub("min\\.pc", "10pc", x = _)

summary(andoer_ir49.mspct)

what_measured(andoer_ir49.mspct)

save(andoer_ir49.mspct, file = "data/andoer-ir49-mspct.rda")
