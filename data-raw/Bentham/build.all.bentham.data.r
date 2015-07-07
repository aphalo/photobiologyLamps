library(photobiology)

load("./data-raw/Bentham/Bentham.raw.data.Rda")
philips.tl12.bentham.data <- philips.tl01.bentham.data <- Bentham.raw.data
philips.tl01.bentham.data$TL12 <- NULL
philips.tl12.bentham.data$TL01 <- NULL
philips.tl01.bentham.data$s.e.irrad <- 
  with(philips.tl01.bentham.data, ifelse(TL01 < 0, 0, TL01 * 1e-3))
philips.tl01.bentham.data$TL01 <- NULL
philips.tl12.bentham.data$s.e.irrad <- 
  with(philips.tl12.bentham.data, ifelse(TL12 < 0, 0, TL12 * 1e-3))
philips.tl12.bentham.data$TL12 <- NULL

philips.tl01.bentham.spct <- setSourceSpct(philips.tl01.bentham.data)
setkey(philips.tl01.bentham.spct, w.length)
philips.tl12.bentham.spct <- setSourceSpct(philips.tl12.bentham.data)
setkey(philips.tl12.bentham.spct, w.length)
save(philips.tl01.bentham.spct, file="./data/philips.tl01.bentham.spct.rda")
save(philips.tl12.bentham.spct, file="./data/philips.tl12.bentham.spct.rda")

spct.names <- ls(pattern=".bentham.spct")

all.names <- NULL
for (str in spct.names){
  all.names <- paste(all.names, str)
}
print(all.names)
all.names <- paste("#\'", all.names, "\nNULL")
oldwd <- getwd()
setwd("./data-raw/Bentham")
system("cp bentham.lamps.data.template.r bentham.lamps.data.r")
cat(all.names, file="bentham.lamps.data.r", append=TRUE)
setwd(oldwd)
