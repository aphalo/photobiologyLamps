library(photobiologyInOut)
library(ggspectra)

rm(list = ls(pattern = "*"))

oldwd <- setwd("data-raw/LI1800")
file.list <- list.files(pattern = ".*PRN$")
licor.mspct <- normalize(read_m_licor_prn(file.list))

new.names <- c("Generic.Inc.bulb.60W",
               "Osram.FT.36W.25",
               "Osram.MH.HQIT.400W",
               "Osram.HPS.Super.Vialox",
               "Philips.CF.PLS.11W.927",
               "Philips.FT.TLD.36W.15",
               "Philips.FT.TLD.36W.18.lores",
               "Philips.FT.TLD.36W.83",
               "Philips.FT.TLD.36W.965",
               "Philips.FT.TLD.36W.89",
               "Philips.FT.TLD.36W.92",
               "Philips.FT.TLL.36W.950",
               "Sylvania.FT.215W.VHO"
)


what.measured <- ifelse(grepl("\\.FT\\.", new.names), 
                        "Fluorescent tube:",
                        ifelse(grepl("\\.CF\\.", new.names), 
                               "Compact fluorescent lamp:",
                               ifelse(grepl("\\.HPS\\.", new.names), 
                               "High pressure sodium lamp:",
                               ifelse(grepl("\\.MH\\.", new.names), 
                                      "Metal halide lamp:",
                                      "Incandescent lamp:"))))

names(what.measured) <- new.names
names(licor.mspct) <- new.names

for (s in new.names) {
#  licor.mspct[[s]] <- thin_wl(licor.mspct[[s]])
  what_measured(licor.mspct[[s]]) <- 
    paste(what.measured[s], 
          gsub("\\.", " ", gsub("Inc\\.|FT\\.|CF\\.|HPS\\.|MH\\.", "", s)), 
          "ca. 1995")
  how_measured(licor.mspct[[s]]) <- "LI-COR LI-1200 single monochromator scanning spectrometer"
  comment(licor.mspct[[s]]) <- NULL
  print(autoplot(licor.mspct[[s]], annotations = c("+", "title:what:when:comment")))
  readline("next:")
}

setwd("../..")

length(licor.mspct)

autoplot(licor.mspct)

save(licor.mspct, file = "data-raw/licor-mspct.rda")



