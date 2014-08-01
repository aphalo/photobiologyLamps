library(photobiologyInOut)

df.names <- read_licor_prn_files("raw.data/LI1800/", "../../data/", trim.wl=900, unit.out="energy")
all.names <- NULL
for (str in df.names){
  all.names <- paste(all.names, str)
}
print(all.names)
all.names <- paste("#\'", all.names, "\nNULL")
oldwd <- getwd()
setwd("raw.data/LI1800")
system("cp licor.lamps.data.template.r licor.lamps.data.r")
cat(all.names, file="licor.lamps.data.r", append=TRUE)
setwd(oldwd)
