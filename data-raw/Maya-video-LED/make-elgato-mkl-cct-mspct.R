library(photobiology)
library(ggspectra)
library(lubridate)

# clear workspace
rm(list = ls(pattern = "*"))

file <- list.files(path = "data-raw/Maya-video-LED/LEDs-2022-09-30",
                   pattern = "^collection.*\\.170mm\\.[Rr]da$",
                   full.names = TRUE)

load(file)

rm(list = ls(pattern = "*raw.lst"))

spectrum<- ls(pattern = "\\.mspct")[1]

new.names <- "elgato_klm_cct.mspct"
lamp.info <- "Elgato Key Light Mini"

lamp.type <- "LED white bi-colour video"

how.measured <- "Array spectrometer, Ocean Optics Maya 2000 Pro; Bentham cosine diffuser D7H; distance 170 mm."

temp.mspct <- get(spectrum)
summary(temp.mspct)

names(temp.mspct)

names(temp.mspct) <- make.names(names(temp.mspct), unique = TRUE)
autoplot(temp.mspct[c(11, 12)])
temp.mspct <- temp.mspct[-12] # duplicate

temp.mspct <- temp.mspct[grepl("max", names(temp.mspct))]

names(temp.mspct)

summary(temp.mspct, which.metadata = "what.measured")

comment.text <- lamp.info
member.names <- character()

for (i in seq_along(temp.mspct)) {
  temp.spct <- temp.mspct[[i]]
  what.measured <- gsub("elgato\\.|\\.spct|K", "", names(temp.mspct)[i])
  what.measured <- gsub("(max|half)\\.([0-9]{4})", "at \\2K dimmed to \\1", what.measured)
  what.measured <- gsub("max", "100pc", what.measured)
  what.measured <- gsub("half", "50pc", what.measured)
  member.names <- gsub(" ", ".", c(member.names, what.measured))
  what.measured <- paste(lamp.type, "lamp:", lamp.info, what.measured)
  # temp.spct <- normalize(temp.spct)
  temp.spct <- smooth_spct(temp.spct, method = "supsmu")
  temp.spct <- thin_wl(temp.spct, max.slope.delta = 0.0005)
  temp.spct <- trim_wl(temp.spct, c(375, NA), fill = 0)
  setHowMeasured(temp.spct, how.measured)
  setWhatMeasured(temp.spct, what.measured)
  comment(temp.spct) <- NULL
  temp.spct <- trimInstrDesc(temp.spct)
  temp.spct <- trimInstrSettings(temp.spct)
  print(str(get_attributes(temp.spct)))
  print(autoplot(temp.spct, annotations = c("+", "title:what:when:comment")))
  temp.mspct[[names(temp.mspct)[i]]] <- temp.spct
}
assign(new.names, temp.mspct)

names(elgato_klm_cct.mspct) <- member.names
summary(elgato_klm_cct.mspct)
what_measured(elgato_klm_cct.mspct)
how_measured(elgato_klm_cct.mspct)

print(autoplot(elgato_klm_cct.mspct))
q_irrad(elgato_klm_cct.mspct[["at.4000K.dimmed.to.100pc"]], scale.factor = 1e6)

save(elgato_klm_cct.mspct, file = "data/elgato-klm-cct-mspct.rda")

