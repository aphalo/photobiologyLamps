library(photobiology)

load("~/Rpackages/photobiologyLamps/raw.data/Bentham/Bentham.raw.data.Rda")
philips.tl12.bentham.data <- philips.tl01.bentham.data <- Bentham.raw.data
philips.tl12.bentham.data$TL01 <- NULL
philips.tl12.bentham.data$s.e.irrad <- philips.tl12.bentham.data$TL12
philips.tl12.bentham.data$s.q.irrad <- with(philips.tl12.bentham.data, as_quantum_mol(w.length, s.e.irrad))
philips.tl01.bentham.data$TL12 <- NULL
philips.tl01.bentham.data$s.e.irrad <- philips.tl01.bentham.data$TL01
philips.tl01.bentham.data$s.q.irrad <- with(philips.tl01.bentham.data, as_quantum_mol(w.length, s.e.irrad))

save(philips.tl01.bentham.data, file="~/Rpackages/photobiologyLamps/data/philips.tl01.bentham.data.rda")
save(philips.tl12.bentham.data, file="~/Rpackages/photobiologyLamps/data/philips.tl12.bentham.data.rda")

df.names <- ls(pattern=".bentham.data")

all.names <- NULL
for (str in df.names){
  all.names <- paste(all.names, str)
}
print(all.names)
all.names <- paste("#\'", all.names, "\nNULL")
oldwd <- getwd()
setwd("~/Rpackages/photobiologyLamps/raw.data/Bentham")
system("cp bentham.lamps.data.template.r bentham.lamps.data.r")
cat(all.names, file="bentham.lamps.data.r", append=TRUE)
setwd(oldwd)
