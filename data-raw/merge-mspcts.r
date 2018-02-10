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

uv_lamps <- c("germicidal", "philips.tl01", "philips.tl12", "philips.tl12.mc",
              "qpanel.uva340", "qpanel.uvb313")
amber_lamps <- sodium_lamps <- c("osram.super.vialox")
red_lamps <- "philips.tld36w.15"
blue_lamps <- "philips.tld36w.18"
white_lamps <- c("philips.pls11w.827", "philips.tld36w.83", "philips.tld36w.865",
                 "philips.tld36w.89",  "philips.tld36w.92",  "philips.tll36w.950",
                 "sylvania.215w.vho", 
                 "incandescent.60w", "osram.36w.25", "osram.hqit.400w", "ww_led_bulb")
## test vectors
color_idxs <- unique(c(uv_lamps, amber_lamps, red_lamps, blue_lamps, white_lamps))
stopifnot(all(color_idxs %in% names(lamps.mspct)))

sodium_lamps <- "osram.super.vialox"
incandescent_lamps <- "incandescent.60w"
multimetal_lamps <- "osram.hqit.400w"
mercury_lamps <- c("philips.pls11w.827", "philips.tld36w.83", "philips.tld36w.865",
                   "philips.tld36w.89",  "philips.tld36w.92",  "philips.tll36w.950",
                   "sylvania.215w.vho", "osram.36w.25", 
                   "germicidal", "philips.tl01", "philips.tl12", "philips.tl12.mc",
                   "qpanel.uva340", "qpanel.uvb313", "philips.tld36w.15", "philips.tld36w.18")
led_lamps <- "ww_led_bulb"

## test vectors
type_idxs <- unique(c(sodium_lamps, incandescent_lamps, multimetal_lamps, mercury_lamps))
stopifnot(all(type_idxs %in% names(lamps.mspct)))

osram_lamps <- c("osram.super.vialox", "osram.36w.25", "osram.hqit.400w")
sylvania_lamps <- "sylvania.215w.vho"
qpanel_lamps <- c("qpanel.uva340", "qpanel.uvb313")
philips_lamps <- c("philips.pls11w.827", "philips.tld36w.83", "philips.tld36w.865",
                  "philips.tld36w.89",  "philips.tld36w.92",  "philips.tll36w.950",
                  "philips.tl01", "philips.tl12", "philips.tl12.mc",
                  "philips.tld36w.15", "philips.tld36w.18")

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
     file = "data/lamps-mspct.rda")

tools::resaveRdaFiles("data", compress="auto")
print(tools::checkRdaFiles("data"))
