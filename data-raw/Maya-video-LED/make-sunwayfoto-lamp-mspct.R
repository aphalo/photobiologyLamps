library(photobiology)
library(ggspectra)
library(lubridate)

# clear workspace
rm(list = ls(pattern = "*"))

file <- list.files(path = "data-raw/Maya-video-LED/LEDs-2022-09-10",
                   pattern = "^collection\\.sunwayfoto.*\\.[Rr]da$",
                   full.names = TRUE)

load(file)

rm(list = ls(pattern = "*raw.lst"))

spectrum<- ls(pattern = "\\.mspct")[1]

new.names <- "sunwayfoto_fl96.mspct"
lamp.info <- "Sunwayfoto FL96"

names(lamp.info) <- spectrum

lamp.type <- "LED white bi-colour video"
names(lamp.type) <- spectrum

names(new.names) <- spectrum

how.measured <- "Array spectrometer, Ocean Optics Maya 2000 Pro; Bentham cosine diffuser D7H; distance unknown."

temp.mspct <- get(spectrum)
names(temp.mspct)

summary(temp.mspct, which.metadata = "what.measured")

comment.text <- lamp.info
for (i in names(temp.mspct)) {
  temp.spct <- temp.mspct[[i]]
  what.measured <- gsub("K ", "K dimmed to ", what_measured(temp.spct))
  what.measured <- gsub("FL96 ", "FL96 at ", what.measured)
  what.measured <- paste(lamp.type, "lamp:", what.measured)
  # temp.spct <- normalize(temp.spct)
  temp.spct <- smooth_spct(temp.spct, method = "supsmu")
  temp.spct <- thin_wl(temp.spct, max.slope.delta = 0.001)
  temp.spct <- trim_wl(temp.spct, c(375, NA), fill = 0)
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

names(sunwayfoto_fl96.mspct) <- gsub("Sunwayfoto\\.FL96\\.|\\.spct", "", names(sunwayfoto_fl96.mspct))
summary(sunwayfoto_fl96.mspct)

save(sunwayfoto_fl96.mspct, file = "data/sunwayfoto-fl96-mspct.rda")
