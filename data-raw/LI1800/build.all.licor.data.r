library(photobiologyInOut)

oldwd <- setwd("data-raw/LI1800")
file.list <- list.files(pattern = "*.PRN$")
file.list <- file.list[-2]
licor.mspct <- normalize(read_m_licor_prn(file.list))

setwd("../..")

save(licor.mspct, file = "data/licor-mspct.rda")

# For some reason file 'Osram.36W.25.PRN gives an error

