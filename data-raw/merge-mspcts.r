library(photobiology)

# merge

load(file = "data-raw/licor-mspct.rda")
licor <- names(licor.mspct)

load(file = "data-raw/macam-mspct.rda")
macam <- names(macam.mspct)

load(file = "data-raw/oo-maya-mspct.rda")
oo_maya <- names(oo_maya.mspct)

load(file = "data-raw/bentham-mspct.rda")
bentham <- names(bentham.mspct)

lamps.mspct <- c(licor.mspct, macam.mspct, bentham.mspct, oo_maya.mspct)

uv_lamps <- c("germicidal", "philips.tl01", "philips.tl12", "philips.tl12.mc",
              "qpanel.uva340", "qpanel.uvb313")
sodium_lamps <- c("osram.super.vialox")

save(lamps.mspct, licor, macam, oo_maya, bentham,
     file = "data/lamps-mspct.rda")

tools::resaveRdaFiles("data", compress="auto")
print(tools::checkRdaFiles("data"))
