
Bentham.raw.data <- read.csv("raw.data/Bentham/Bentham_01_and_12.csv")
var.names <- names(Bentham.raw.data)[-1]
df.names <- paste("philips", tolower(var.names), "dat", sep=".")

assign(df.names[1], Bentham.raw.data[,-3])
assign(df.names[2], Bentham.raw.data[,-2])

oldwd <- getwd()
setwd("data")
save(list=df.names[1], file=paste(df.names[1], ".rda", sep=""))
save(list=df.names[2], file=paste(df.names[2], ".rda", sep=""))
setwd(oldwd)

all.names <- NULL
for (str in df.names){
  all.names <- paste(all.names, str)
}
print(all.names)
all.names <- paste("#\'", all.names, "\nNULL")
oldwd <- getwd()
setwd("raw.data/Bentham")
system("cp bentham.lamps.data.template.r bentham.lamps.data.r")
cat(all.names, file="bentham.lamps.data.r", append=TRUE)
setwd(oldwd)
