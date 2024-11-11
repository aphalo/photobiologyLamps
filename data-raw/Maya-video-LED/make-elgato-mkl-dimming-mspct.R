library(photobiology)
library(ggspectra)
library(lubridate)

# clear workspace
rm(list = ls(pattern = "*"))

file <- list.files(path = "data-raw/Maya-video-LED/LEDs-2022-09-10",
                   pattern = "^collection\\.Elgato.*\\.[Rr]da$",
                   full.names = TRUE)

load(file)

rm(list = ls(pattern = "*raw.lst"))

spectrum<- ls(pattern = "\\.mspct")[1]

new.names <- "elgato_klm_dim.mspct"
lamp.info <- "Elgato Key Light Mini"

lamp.type <- "LED white bi-colour video"

how.measured <- "Array spectrometer, Ocean Optics Maya 2000 Pro; Bentham cosine diffuser D7H; distance approx. 165 mm."

temp.mspct <- get(spectrum)
temp.mspct <- temp.mspct[-length(temp.mspct)] # remove duplicate
summary(temp.mspct, which.metadata = "what.measured")

temp.mspct <- temp.mspct[grepl("4000K", names(temp.mspct))]

names(temp.mspct)

# names(temp.mspct) <- make.names(names(temp.mspct), unique = TRUE)
# autoplot(temp.mspct[c(11, 12)])
# temp.mspct <- temp.mspct[-12] # duplicate
# names(temp.mspct)

summary(temp.mspct, which.metadata = "what.measured")

comment.text <- lamp.info
member.names <- character()

for (i in seq_along(temp.mspct)) {
  temp.spct <- temp.mspct[[i]]
  what.measured <- gsub("elgato\\.|\\.spct", "", names(temp.mspct)[i])
  what.measured <- gsub("K\\.", " dimmed to ", what.measured)
  what.measured <- gsub("4000", "at 4000K", what.measured)
  member.names <- gsub(" ", ".", c(member.names, what.measured))
  what.measured <- paste(lamp.type, "lamp:", lamp.info, what.measured)
  # temp.spct <- normalize(temp.spct)
  temp.spct <- smooth_spct(temp.spct, method = "supsmu")
  temp.spct <- thin_wl(temp.spct, max.slope.delta = 0.0005)
  temp.spct <- trim_wl(temp.spct, c(400, NA), fill = 0)
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

names(elgato_klm_dim.mspct) <- member.names
summary(elgato_klm_dim.mspct)
what_measured(elgato_klm_dim.mspct)

print(autoplot(elgato_klm_dim.mspct))
q_irrad(elgato_klm_dim.mspct[["at.4000K.dimmed.to.100pc"]], scale.factor = 1e6)

save(elgato_klm_dim.mspct, file = "data/elgato-klm-dim-mspct.rda")

