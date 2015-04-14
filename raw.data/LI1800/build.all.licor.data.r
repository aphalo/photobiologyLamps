library(photobiologyInOut)

oldwd <- setwd("raw.data/LI1800")
df.names <- read_licor_files("./", "../../data/", high.limit = 900, unit.out = "energy", date = NA)
all.names <- NULL
for (str in df.names){
  all.names <- paste(all.names, str)
}
all.names <- paste("#\'", all.names, "\nNULL")
message(all.names)
system("cp licor.lamps.data.template.r licor.lamps.data.r")
cat(all.names, file="licor.lamps.data.r", append=TRUE)
setwd(oldwd)
