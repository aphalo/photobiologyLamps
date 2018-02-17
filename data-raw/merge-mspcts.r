rm(list = ls(pattern = "*"))

library(photobiology)

# merge

load(file = "data-raw/licor-mspct.rda")
licor_lamps <- names(licor.mspct)

load(file = "data-raw/macam-mspct.rda")
macam_lamps <- names(macam.mspct)

load(file = "data-raw/oo-maya-mspct.rda")
oo_maya_lamps <- names(oo_maya.mspct)

load(file = "data-raw/bentham-mspct.rda")
bentham_lamps <- names(bentham.mspct)

lamps.mspct <- c(licor.mspct, macam.mspct, bentham.mspct, oo_maya.mspct)

uv_lamps <- sort(c("germicidal", "philips.tl01", "philips.tl12", "philips.tl12.mc",
              "qpanel.uva340", "qpanel.uvb313"))
amber_lamps <- sodium_lamps <- c("osram.super.vialox")
red_lamps <- "philips.tld36w.15"
blue_lamps <- c("philips.tld36w.18", "philips.tld.36w.18")
white_lamps <- sort(c("philips.pls11w.827", "philips.tld36w.83", "philips.tld36w.865",
                 "philips.tld36w.89",  "philips.tld36w.92",  "philips.tll36w.950",
                 "sylvania.215w.vho", 
                 "airam.cf.15w.2700k", "airam.spiraali", "osram.classic.20w",
                 "osram.l36w.840", "osram.led.8w.2700k", "toshiba.led.9.5w.2700k",
                 "airam.led.oiva.9w.3000k", "osram.conc.spot.60w", 
                 "osram.led.10w.2700k.classicstar", "philips.tl5.35w.830he",
                 "pirkka.halogen.53w", "valoya.b100.ap67",
                 "incandescent.60w", "osram.36w.25", "osram.hqit.400w"))
## test vectors
color_idxs <- unique(c(uv_lamps, amber_lamps, red_lamps, blue_lamps, white_lamps))
stopifnot(all(color_idxs %in% names(lamps.mspct)))

sodium_lamps <- "osram.super.vialox"
incandescent_lamps <- sort(c("incandescent.60w", "osram.conc.spot.60w", 
                        "osram.classic.20w", "pirkka.halogen.53w"))
multimetal_lamps <- "osram.hqit.400w"
mercury_lamps <- sort(c("philips.pls11w.827", "philips.tld36w.83", "philips.tld36w.865",
                   "philips.tld36w.89",  "philips.tld36w.92",  "philips.tll36w.950",
                   "sylvania.215w.vho", "osram.36w.25", 
                   "airam.cf.15w.2700k", "airam.spiraali", "osram.l36w.840",
                   "philips.tld.36w.18", "philips.tl5.35w.830he",
                   "germicidal", "philips.tl01", "philips.tl12", "philips.tl12.mc",
                   "qpanel.uva340", "qpanel.uvb313", "philips.tld36w.15", 
                   "philips.tld36w.18"))
led_lamps <- sort(c("osram.led.8w.2700k", "toshiba.led.9.5w.2700k", 
               "airam.led.oiva.9w.3000k", "osram.led.10w.2700k.classicstar",
               "valoya.b100.ap67"))
  

## test vectors
type_idxs <- unique(c(sodium_lamps, incandescent_lamps, multimetal_lamps, mercury_lamps))
stopifnot(all(type_idxs %in% names(lamps.mspct)))

osram_lamps <- sort(grep("osram", names(lamps.mspct), value = TRUE))
sylvania_lamps <- sort(grep("sylvania", names(lamps.mspct), value = TRUE))
qpanel_lamps <- sort(grep("qpanel", names(lamps.mspct), value = TRUE))
philips_lamps <- sort(grep("philips", names(lamps.mspct), value = TRUE))
airam_lamps <- sort(grep("airam", names(lamps.mspct), value = TRUE))
toshiba_lamps <- sort(grep("toshiba", names(lamps.mspct), value = TRUE))
generic_lamps <- sort(grep("pirkka", names(lamps.mspct), value = TRUE))

## test vectors
make_idxs <- unique(c(osram_lamps, sylvania_lamps, qpanel_lamps, philips_lamps))
stopifnot(all(make_idxs %in% names(lamps.mspct)))

message("Not in any index: ", 
        setdiff(c(make_idxs, type_idxs, color_idxs),
                names(lamps.mspct)))

save(lamps.mspct, licor_lamps, macam_lamps, oo_maya_lamps, bentham_lamps,
     uv_lamps, amber_lamps, red_lamps, blue_lamps, white_lamps,
     sodium_lamps, incandescent_lamps, multimetal_lamps, mercury_lamps, led_lamps,
     osram_lamps, sylvania_lamps, qpanel_lamps, philips_lamps,
     airam_lamps, toshiba_lamps, generic_lamps,
     file = "data/lamps-mspct.rda")

tools::resaveRdaFiles("data", compress="auto")
print(tools::checkRdaFiles("data"))
