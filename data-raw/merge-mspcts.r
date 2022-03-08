library(photobiology)
library(photobiologyWavebands)

rm(list = ls(pattern = "*"))

# merge

load(file = "data-raw/licor-mspct.rda")
licor_lamps <- names(licor.mspct)

load(file = "data-raw/macam-mspct.rda")
macam_lamps <- names(macam.mspct)

load(file = "data-raw/maya-LED-lamps.mspct.rda")
load(file = "data-raw/maya-discharge-lamps.mspct.rda")
load(file = "data-raw/maya-flash-lamps.mspct.rda")
load(file = "data-raw/maya-incandescent-lamps.mspct.rda")
oo_maya.mspct <- c(maya_LED_lamps.mspct, 
                   maya_discharge_lamps.mspct,
                   maya_flash_lamps.mspct,
                   maya_incandescent_lamps.mspct)
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
names(lamps.mspct)

normalized.ls <- list()
for (s in names(lamps.mspct)) {
  normalized.ls[[s]] <- getNormalised(lamps.mspct[[s]])
}
peak.wl <- unlist(normalized.ls)
setdiff(names(lamps.mspct), names(peak.wl))
length(peak.wl)

# as the spectra are normalised, a broad spectrum with have a large integral
white_lamps <- names(lamps.mspct[q_irrad(lamps.mspct, allow.scaled = TRUE)[["Q_Total"]] > 2e-4 & 
                             (peak.wl <= 700 | peak.wl > 890) & peak.wl >= 400])
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
sodium_lamps <- 
  sort(grep("\\.HPS\\.|\\.LPS\\.", names(lamps.mspct), value = TRUE))
incandescent_lamps <- 
  sort(grep("\\.Inc\\.", names(lamps.mspct), value = TRUE))
multimetal_lamps <-
  sort(grep("\\.MH\\.", names(lamps.mspct), value = TRUE))
fluorescent_lamps <- 
  sort(grep("\\.FT\\.|\\.CF\\.", names(lamps.mspct), value = TRUE))
germicidal_lamps <- 
  sort(grep("Germicidal", names(lamps.mspct), value = TRUE, ignore.case = TRUE))
mercury_lamps <- c(fluorescent_lamps, germicidal_lamps)
led_lamps <- 
  sort(grep("\\.LED\\.", names(lamps.mspct), value = TRUE))
xenon_lamps <- 
  sort(grep("\\.XF\\.", names(lamps.mspct), value = TRUE))

## test vectors
type_idxs <- unique(c(sodium_lamps, incandescent_lamps, multimetal_lamps, mercury_lamps))
# stopifnot(all(type_idxs %in% names(lamps.mspct)))

# lists by make
osram_lamps <- sort(grep("osram", names(lamps.mspct), value = TRUE, ignore.case = TRUE))
sylvania_lamps <- sort(grep("sylvania", names(lamps.mspct), value = TRUE, ignore.case = TRUE))
qpanel_lamps <- sort(grep("qpanel", names(lamps.mspct), value = TRUE, ignore.case = TRUE))
philips_lamps <- sort(grep("philips", names(lamps.mspct), value = TRUE, ignore.case = TRUE))
airam_lamps <- sort(grep("airam", names(lamps.mspct), value = TRUE, ignore.case = TRUE))
toshiba_lamps <- sort(grep("toshiba", names(lamps.mspct), value = TRUE, ignore.case = TRUE))
valoya_lamps <- sort(grep("valoya", names(lamps.mspct), value = TRUE, ignore.case = TRUE))
fluence_lamps <- sort(grep("fluence", names(lamps.mspct), value = TRUE, ignore.case = TRUE))
aputure_lamps <- sort(grep("amaran|aputure", names(lamps.mspct), value = TRUE, ignore.case = TRUE))
godox_lamps <- sort(grep("godox", names(lamps.mspct), value = TRUE, ignore.case = TRUE))
sunwayfoto_lamps <- sort(grep("sunwayfoto", names(lamps.mspct), value = TRUE, ignore.case = TRUE))
jaxman_lamps <- sort(grep("jaxman", names(lamps.mspct), value = TRUE, ignore.case = TRUE))
convoy_lamps <- sort(grep("convoy", names(lamps.mspct), value = TRUE, ignore.case = TRUE))
generic_lamps <- sort(grep("pirkka|v.light|LCDlighting|Ledstore|Generic|Ikea", names(lamps.mspct), value = TRUE, ignore.case = TRUE))

lamp_brands <- 
  sort(c("osram", "sylvania", "qpanel", "philips", "airam", "toshiba",
         "valoya", "aputure", "godox", "sunwayfoto", "jaxman", "convoy",
         "fluence", "generic"))

# lists by special uses
plant_grow_lamps <- c(valoya_lamps, fluence_lamps)
photography_lamps <- c(aputure_lamps, sunwayfoto_lamps, godox_lamps)

save(list = c("lamps.mspct", "lamp_brands", "lamp_colors", ls(pattern = "*_lamps$")),
     file = "data/lamps-mspct.rda")

tools::resaveRdaFiles("data", compress="auto")
print(tools::checkRdaFiles("data"))
