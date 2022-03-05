rm(list = ls(pattern = "*"))

library(photobiology)
library(dplyr)

files <- list.files(path = "./data-raw/Maya-Ledsaver/",
                    pattern = ".*\\.Rda",
                    full.names = TRUE)

for (f in files) load(f)

# object.names <- gsub(".Rda", "", basename(files))

object.names <- grep("raw|dim", ls(pattern = ".spct"), value = TRUE, invert = TRUE)

ledsavers.mspct <- source_mspct()
for (o in object.names) {
  tmp <- get(o)
  setWhatMeasured(tmp, "LedSaver 7.5W four channels (WRGB) LED lamp.")
  setHowMeasured(tmp, "Measured with an array spectrometer.")
  ledsavers.mspct[[o]] <- trimInstrDesc(tmp)
}
rm(o, tmp)

names(ledsavers.mspct) <- gsub("LedSaver_7.5W_", "", 
                              gsub(".spct", "", names(ledsavers.mspct)))

names(ledsavers.mspct)[names(ledsavers.mspct) == "Fuchsia"] <- "fuchsia"

ledsavers.mspct <- clean(ledsavers.mspct)

ledsavers.mspct <- trim_wl(ledsavers.mspct, range = c(350, 900))

# ledsavers.mspct <- normalize(ledsavers.mspct)

ledsavers.mspct %>% 
  msmsply(.fun = trimInstrDesc) -> ledsavers.mspct

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

