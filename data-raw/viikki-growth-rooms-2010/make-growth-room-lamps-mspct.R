library(photobiology)
library(ggspectra)
library(lubridate)

# clear workspace
rm(list = ls(pattern = "*"))

files <- list.files(path = "data-raw/viikki-growth-rooms-2010/",
                    pattern = ".[Rr]da",
                    full.names = TRUE)

for (f in files) {
  load(f)
}

rm("spectra")

spectra <- ls(pattern = "\\.spct")

lamp.info <- "Osram.FT.L36W.865"

lamp.type <- "Fluorescent tube, T8:"

new.names <- lamp.info

how.measured <- "Ocean Optics Maya 2000Pro; cosine diffuser; distance unknown."

comment.text <- "Fluorescent tubes in growth rooms of Viikki greenhouse facility at the University of Helsinki."
what.measured <- gsub("\\.", " ", new.names)
what.measured <- paste(lamp.type, what.measured, "Lumilux")
temp.spct <- normalize(get(spectra))
#  temp.spct <- thin_wl(temp.spct)
setHowMeasured(temp.spct, how.measured)
setWhatMeasured(temp.spct, what.measured)
setWhenMeasured(temp.spct, ymd("2011-12-10"))
comment(temp.spct) <- comment.text
print(str(get_attributes(temp.spct)))
print(autoplot(temp.spct, annotations = c("+", "title:what:when:comment")))

growth_room.mspct <- source_mspct(list(Osram.FT.L36W.865 = temp.spct))

growth_room.mspct

autoplot(growth_room.mspct)

save(growth_room.mspct, file = "data-raw/rda/growth-room.mspct.rda")
