rm(list = ls(pattern = "*"))

library(photobiology)
library(dplyr)

files <- list.files(path = "./data-raw/Maya-Ledsaver/",
                    pattern = ".*\\.Rda",
                    full.names = TRUE)

for (f in files) load(f)

# object.names <- gsub(".Rda", "", basename(files))

object.names <- grep("raw|dim", ls(pattern = ".spct"), value = TRUE, invert = TRUE)
how.measured <- "Array spectrometer, Ocean Optics Maya 2000 Pro; Bentham cosine diffuser D7H; distance unknown."

ledsavers.mspct <- source_mspct()
for (o in object.names) {
  temp.spct <- get(o)
#  temp.spct <- normalize(temp.spct)
  temp.spct <- smooth_spct(temp.spct)
  temp.spct <- thin_wl(temp.spct)
  temp.spct <- trim_wl(temp.spct, c(350, NA), fill = 0)
  setHowMeasured(temp.spct, how.measured)
  setWhatMeasured(temp.spct, "LedSavers 7.5W four channels (WRGB) LED lamp.")
  #  comment(temp.spct) <- comment.text
  trimInstrDesc(temp.spct)
  trimInstrSettings(temp.spct)
  print(str(get_attributes(temp.spct)))
  print(autoplot(temp.spct, annotations = c("+", "title:what:when:comment")))
  ledsavers.mspct[[o]] <- temp.spct
  readline("next:")
}
rm(o, tmp.spct)

names(ledsavers.mspct) <- gsub("_", ".",
                               gsub("LedSaver_7\\.5W_", "", 
                              gsub("\\.spct", "", names(ledsavers.mspct))))

names(ledsavers.mspct)[names(ledsavers.mspct) == "Fuchsia"] <- "fuchsia"
names(ledsavers.mspct)

comment(ledsavers.mspct) <- 
  paste("Different settings of a four channel WRGB LED bulb",
        "Bulb 'Ledsavers 7.5 W with remote control', 230 V, E-27",
        "Ledsavers RGB-lampa med fjaerrkontroll E27 350 lm, Art. 62559",
        sep = "\n")

cat(comment(ledsavers.mspct))

ledsavers_channels <- c("W", "R", "G", "B")
ledsavers_mixes <- setdiff(names(ledsavers.mspct), ledsavers_channels)
ledsavers_GB_mixes <- c("cool_green", "bluish_green", "blue_green", "greenish_blue")
ledsavers_RG_mixes <- c("orange", "dark_orange", "yellow", "sand")
ledsavers_RB_mixes <- c("warm_blue", "purple", "fuchsia", "pink")

save(ledsavers.mspct, 
     ledsavers_channels, ledsavers_mixes, 
     ledsavers_GB_mixes, ledsavers_RG_mixes, ledsavers_RB_mixes,
     file="./data/ledsavers.rda")

tools::resaveRdaFiles("data", compress="auto")
print(tools::checkRdaFiles("data"))

