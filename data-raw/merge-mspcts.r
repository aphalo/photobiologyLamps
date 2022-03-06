rm(list = ls(pattern = "*"))

library(photobiology)
library(photobiologyWavebands)

# merge

load(file = "data-raw/licor-mspct.rda")
licor_lamps <- names(licor.mspct)

load(file = "data-raw/macam-mspct.rda")
macam_lamps <- names(macam.mspct)

load(file = "data-raw/oo-maya-mspct.rda")
oo_maya_lamps <- names(oo_maya.mspct)

load(file = "data-raw/bentham-mspct.rda")
bentham_lamps <- names(bentham.mspct)

load(file = "data-raw/fluence-mspct.rda")
fluence_lamps <- names(fluence.mspct)

load(file = "data-raw/philips-mspct.rda")

load(file = "data-raw/LCDlighting-mspct.rda")

lamps.mspct <- c(licor.mspct, macam.mspct, bentham.mspct, oo_maya.mspct, 
                 fluence.mspct, philips.mspct, LCDlighting.mspct)

lamps.mspct <- lamps.mspct[order(names(lamps.mspct))]

normalized.ls <- list()
for (s in names(lamps.mspct)) {
  normalized.ls[[s]] <- getNormalised(lamps.mspct[[s]])
}
peak.wl <- unlist(normalized.ls)

# as the spectra are normalised, a broad spectrum with have a large integral
white_lamps <- lamps.mspct[q_irrad(lamps.mspct, allow.scaled = TRUE)[["Q_Total"]] > 2e-4 & 
                             (peak.wl <= 700 | peak.wl > 890) & peak.wl >= 400]
names(white_lamps)

names_narrow <- setdiff(names(lamps.mspct), names(white_lamps))
names_narrow

peak.wl_narrow <- peak.wl[names_narrow]
names_narrow == names(peak.wl_narrow)
peak.wl_narrow <- unname(peak.wl_narrow)

uv_lamps <- names_narrow[peak.wl_narrow <= wl_max(UV())]
ir_lamps <- names_narrow[peak.wl_narrow > 700]
purple_lamps <- names_narrow[peak.wl_narrow > wl_max(UV()) &
                              peak.wl_narrow <= wl_max(Purple())]
blue_lamps <- names_narrow[peak.wl_narrow > wl_min(Blue()) &
                            peak.wl_narrow <= wl_max(Blue())]
green_lamps <- names_narrow[peak.wl_narrow > wl_min(Green()) &
                             peak.wl_narrow <= wl_max(Green())]
yellow_lamps <- names_narrow[peak.wl_narrow > wl_min(Yellow()) &
                              peak.wl_narrow <= wl_max(Yellow())]
orange_lamps <- names_narrow[peak.wl_narrow > wl_min(Orange()) &
                              peak.wl_narrow <= wl_max(Orange())]
red_lamps <-  names_narrow[peak.wl_narrow > wl_min(Red()) &
                            peak.wl_narrow <= wl_max(Red())]
amber_lamps <- sort(c(yellow_lamps, orange_lamps))

lamp_colors <- c("uv", "purle", "blue", "green", "yellow", "orange", "red", "ir")

## lists by type
sodium_lamps <- "osram.super.vialox"
incandescent_lamps <- 
        sort(c("incandescent.60w", "osram.conc.spot.60w", 
               "osram.classic.20w", "pirkka.halogen.53w"))
multimetal_lamps <- "osram.hqit.400w"
mercury_lamps <- 
        sort(c("philips.pls11w.827", "philips.tld36w.83", "philips.tld36w.865",
               "philips.tld36w.89",  "philips.tld36w.92",  "philips.tll36w.950",
               "philips.BLB.tld108", "sylvania.215w.vho", "osram.36w.25", 
               "airam.cf.15w.2700k", "airam.spiraali", "osram.l36w.840",
               "philips.tld.36w.18", "philips.tl5.35w.830he",
               "germicidal", "philips.tl01", "philips.tl12", "philips.tl12.mc",
               "qpanel.uva340", "qpanel.uvb313", "philips.tld36w.15", 
               "philips.tld36w.18", "LCDlighting.UVA.BL"))
led_lamps <- 
        sort(c("osram.led.8w.2700k", "toshiba.led.9.5w.2700k", 
               "airam.led.oiva.9w.3000k", "airam.led.11w.4000k",
               "osram.led.10w.2700k.classicstar",
               "philips.led.t8.10w.840",
               "valoya.b50.ap67", "v.light.led.2w.6000k",
               "amaran.al.m9", "sunwayfoto.fl96.3000k", "sunwayfoto.fl96.5500k", 
               "convoy.uv.flashlight", "cree.uv.flashlight", 
               fluence_lamps))
xenon_lamps <- grep("^godox", names(lamps.mspct), value = TRUE)

## test vectors
type_idxs <- unique(c(sodium_lamps, incandescent_lamps, multimetal_lamps, mercury_lamps))
stopifnot(all(type_idxs %in% names(lamps.mspct)))

# lists by make
osram_lamps <- sort(grep("osram", names(lamps.mspct), value = TRUE))
sylvania_lamps <- sort(grep("sylvania", names(lamps.mspct), value = TRUE))
qpanel_lamps <- sort(grep("qpanel", names(lamps.mspct), value = TRUE))
philips_lamps <- sort(grep("philips", names(lamps.mspct), value = TRUE))
airam_lamps <- sort(grep("airam", names(lamps.mspct), value = TRUE))
toshiba_lamps <- sort(grep("toshiba", names(lamps.mspct), value = TRUE))
valoya_lamps <- sort(grep("valoya", names(lamps.mspct), value = TRUE))
aputure_lamps <- sort(grep("amaran|aputure", names(lamps.mspct), value = TRUE))
godox_lamps <- sort(grep("godox", names(lamps.mspct), value = TRUE))
sunwayfoto_lamps <- sort(grep("sunwayfoto", names(lamps.mspct), value = TRUE))
jaxman_lamps <- sort(grep("jaxman", names(lamps.mspct), value = TRUE))
convoy_lamps <- sort(grep("convoy", names(lamps.mspct), value = TRUE))
generic_lamps <- sort(grep("pirkka|v.light|LCDlighting", names(lamps.mspct), value = TRUE))

lamp_brands <- 
  sort(c("osram", "sylvania", "qpanel", "philips", "airam", "toshiba",
         "valoya", "aputure", "godox", "sunwayfoto", "jaxman", "convoy",
         "generic"))

# lists by special uses
plant_grow_lamps <- c(valoya_lamps, fluence_lamps)
photography_lamps <- c(aputure_lamps, sunwayfoto_lamps, godox_lamps)

save(list = c("lamps.mspct", "lamp_brands", "lamp_colors", ls(pattern = "*_lamps")),
     file = "data/lamps-mspct.rda")

tools::resaveRdaFiles("data", compress="auto")
print(tools::checkRdaFiles("data"))
