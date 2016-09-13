library(photobiologyInOut)

oldwd <- setwd("data-raw/LI1800")
file.list <- list.files(pattern = "*.PRN$")
licor.mspct <- normalize(read_m_licor_prn(file.list))

setwd("../..")

save(licor.mspct, file = "data/licor-mspct.rda")

