library(photobiology)

load("~/Rpackages/photobiologyLamps/raw.data/Bentham/Bentham.raw.data.Rda")
philips.tl12.bentham.data <- philips.tl01.bentham.data <- Bentham.raw.data
philips.tl01.bentham.data$TL12 <- NULL
philips.tl12.bentham.data$TL01 <- NULL
philips.tl01.bentham.data$s.e.irrad <- philips.tl01.bentham.data$TL01 * 1e-3
philips.tl01.bentham.data$TL01 <- NULL
philips.tl12.bentham.data$s.e.irrad <- philips.tl12.bentham.data$TL12 * 1e-3
philips.tl12.bentham.data$TL12 <- NULL

philips.tl01.bentham.spct <- setSourceSpct(philips.tl01.bentham.data)
setkey(philips.tl01.bentham.spct, w.length)
philips.tl12.bentham.spct <- setSourceSpct(philips.tl12.bentham.data)
setkey(philips.tl12.bentham.spct, w.length)
save(philips.tl01.bentham.spct, file="~/Rpackages/photobiologyLamps/data/philips.tl01.bentham.spct.rda")
save(philips.tl12.bentham.spct, file="~/Rpackages/photobiologyLamps/data/philips.tl12.bentham.spct.rda")

spct.names <- ls(pattern=".bentham.spct")

all.names <- NULL
for (str in spct.names){
  all.names <- paste(all.names, str)
}
print(all.names)
all.names <- paste("#\'", all.names, "\nNULL")
oldwd <- getwd()
setwd("~/Rpackages/photobiologyLamps/raw.data/Bentham")
system("cp bentham.lamps.data.template.r bentham.lamps.data.r")
cat(all.names, file="bentham.lamps.data.r", append=TRUE)
setwd(oldwd)
