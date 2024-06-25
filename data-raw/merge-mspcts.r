library(photobiology)
library(photobiologyWavebands)

verbose_as_default()
old.options <- options(warn = 1)
on.exit(options(old.options))

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

load(file = "data-raw/growth-room.mspct.rda")

load(file = "data-raw/fluence-mspct.rda")

load(file = "data-raw/philips-mspct.rda")

load(file = "data-raw/LCDlighting-mspct.rda")

lamps.mspct <- c(licor.mspct, macam.mspct, bentham.mspct, oo_maya.mspct, 
                 fluence.mspct, philips.mspct, LCDlighting.mspct, growth_room.mspct)

lamps.mspct <- lamps.mspct[order(names(lamps.mspct))]
lamps.mspct <- normalize(lamps.mspct, nrom = "max", unit.out = "energy", keep.scaling = 100) # W m-2
names(lamps.mspct)

normalized.ls <- list()
for (s in names(lamps.mspct)) {
  normalized.ls[[s]] <- getNormalised(lamps.mspct[[s]])
}
peak.wl <- unlist(normalized.ls)
setdiff(names(lamps.mspct), names(peak.wl))
length(peak.wl)

# as the spectra are normalised, a broad spectrum will have a large integral
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
  sort(grep("\\.XeF\\.", names(lamps.mspct), value = TRUE))

lamp_types <- sort(c(Inc = "incandescent_lamps",
                     FT = "fluorescent_lamps",
                     CF = "fluorescent_lamps",
                     LED = "led_lamps",
                     Hg = "mercury_lamps",
                     Germicidal = "mercury_lamps",
                     MH = "multimetal_lamps",
                     HPS = "sodium_lamps",
                     LPS = "sodium_lamps",
                     XeF = "xenon_lamps"))

## test vectors
type_idxs <- unique(c(sodium_lamps, incandescent_lamps, multimetal_lamps, mercury_lamps))
# stopifnot(all(type_idxs %in% names(lamps.mspct)))

# lists by make
Osram_lamps <- sort(grep("osram", names(lamps.mspct), value = TRUE, ignore.case = TRUE))
Sylvania_lamps <- sort(grep("sylvania", names(lamps.mspct), value = TRUE, ignore.case = TRUE))
QPanel_lamps <- sort(grep("qpanel", names(lamps.mspct), value = TRUE, ignore.case = TRUE))
Philips_lamps <- sort(grep("philips", names(lamps.mspct), value = TRUE, ignore.case = TRUE))
Airam_lamps <- sort(grep("airam", names(lamps.mspct), value = TRUE, ignore.case = TRUE))
Toshiba_lamps <- sort(grep("toshiba", names(lamps.mspct), value = TRUE, ignore.case = TRUE))
Valoya_lamps <- sort(grep("valoya", names(lamps.mspct), value = TRUE, ignore.case = TRUE))
Fluence_lamps <- sort(grep("fluence", names(lamps.mspct), value = TRUE, ignore.case = TRUE))
Aputure_lamps <- sort(grep("amaran|aputure", names(lamps.mspct), value = TRUE, ignore.case = TRUE))
Godox_lamps <- sort(grep("godox", names(lamps.mspct), value = TRUE, ignore.case = TRUE))
Sunwayfoto_lamps <- sort(grep("sunwayfoto", names(lamps.mspct), value = TRUE, ignore.case = TRUE))
Jaxman_lamps <- sort(grep("jaxman", names(lamps.mspct), value = TRUE, ignore.case = TRUE))
Convoy_lamps <- sort(grep("convoy", names(lamps.mspct), value = TRUE, ignore.case = TRUE))
Generic_lamps <- sort(grep("pirkka|v.light|LCDlighting|Ledstore|Generic|Ikea", names(lamps.mspct), value = TRUE, ignore.case = TRUE))

lamp_brands <- 
  sort(c("Osram", "Sylvania", "QPpanel", "Philips", "Airam", "Toshiba",
         "Valoya", "Aputure", "Godox", "Sunwayfoto", "Jaxman", "Convoy",
         "Fluence", "Generic"))

# lists by special uses
plant_grow_lamps <- c(Valoya_lamps, Fluence_lamps)
photography_lamps <- c(Aputure_lamps, Sunwayfoto_lamps, Godox_lamps)

save(list = c("lamps.mspct", "lamp_brands", "lamp_colors", "lamp_types", 
              ls(pattern = "*_lamps$")),
     file = "data/lamps-mspct.rda")

tools::resaveRdaFiles("data", compress="auto")
print(tools::checkRdaFiles("data"))
