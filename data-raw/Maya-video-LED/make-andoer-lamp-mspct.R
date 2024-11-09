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

comment.text <- lamp.info
what.measured <- lamp.info
what.measured <- paste(lamp.type, "lamp:", what.measured)
temp.spct <- get(spectrum)[1:2]
# temp.spct <- normalize(temp.spct)
temp.spct <- smooth_spct(temp.spct)
temp.spct <- thin_wl(temp.spct)
temp.spct <- trim_wl(temp.spct, c(315, NA), fill = 0)
setHowMeasured(temp.spct, how.measured)
setWhatMeasured(temp.spct, what.measured)
comment(temp.spct) <- NULL
temp.spct <- msmsply(temp.spct, trimInstrDesc)
temp.spct <- msmsply(temp.spct, trimInstrSettings)
print(str(get_attributes(temp.spct[[1]])))
print(autoplot(temp.spct, annotations = c("+", "title:what:when:comment")))
assign(new.names, temp.spct)

length(andoer_ir49.mspct)

save(andoer_ir49.mspct, file = "data/andoer-ir49.mspct.rda")
