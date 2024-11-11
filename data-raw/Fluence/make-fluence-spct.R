library(magrittr)
library(lubridate)
library(photobiology)
library(ggspectra)

# clear workspace
rm(list = ls(pattern = "*"))

energy_as_default()

AnthoSpec <- read.csv("data-raw/Fluence/AnthoSpec-RAY.csv",
                      skip = 1, header = FALSE, col.names = c("w.length", "s.q.irrad"))
PhysioSpecGreenhouse <- read.csv("data-raw/Fluence/PhysioSpecGreenhouseRAY.csv",
                      skip = 1, header = FALSE, col.names = c("w.length", "s.q.irrad"))
PhysioSpecIndoor <- read.csv2("data-raw/Fluence/PhysioSpec-Indoor.csv",
                                 skip = 1, header = FALSE, col.names = c("w.length", "s.q.irrad"))
PhysioSpecBROAD <- read.csv2("data-raw/Fluence/PhysioSpec-BROAD.csv",
                             skip = 1, header = FALSE, col.names = c("w.length", "s.q.irrad"))
PhysioSpecBROAD_R3 <- read.csv2("data-raw/Fluence/PhysioSpec-BROAD-R3.csv",
                            skip = 1, header = FALSE, col.names = c("w.length", "s.q.irrad"))
PhysioSpecBROAD_R6 <- read.csv2("data-raw/Fluence/PhysioSpec-BROAD-R6.csv",
                            skip = 1, header = FALSE, col.names = c("w.length", "s.q.irrad"))
PhysioSpecBROAD_R9B <- read.csv2("data-raw/Fluence/PhysioSpec-BROAD-R9B.csv",
                            skip = 1, header = FALSE, col.names = c("w.length", "s.q.irrad"))

Fluence_AnthoSpec.spct <- as.source_spct(AnthoSpec) %>% clean() %>% normalize()
Fluence_PhysioSpec_Greenhouse.spct <- as.source_spct(PhysioSpecGreenhouse) %>% clean() %>% normalize()
Fluence_PhysioSpec_Indoor.spct <- as.source_spct(PhysioSpecIndoor) %>% clean() %>% normalize()
Fluence_PhysioSpec_BROAD.spct <- as.source_spct(PhysioSpecBROAD) %>% clean() %>% normalize()
Fluence_PhysioSpec_BROAD_R3.spct <- as.source_spct(PhysioSpecBROAD_R3[-69, ]) %>% clean() %>% normalize()
Fluence_PhysioSpec_BROAD_R6.spct <- as.source_spct(PhysioSpecBROAD_R6) %>% clean() %>% normalize()
Fluence_PhysioSpec_BROAD_R9B.spct <- as.source_spct(PhysioSpecBROAD_R9B[-14, ]) %>% clean() %>% normalize()

fluence.mspct <- normalise(collect2mspct())
names(fluence.mspct) <- gsub("_", ".", 
                             gsub("Fluence_", "Fluence_LED_",
                                  gsub(".spct", "", names(fluence.mspct))))

autoplot(fluence.mspct)

for (s in names(fluence.mspct)) {
  vintage <- if (grepl("AnthoSpec|Greenhouse", s)) "2019" else "2022"
  fluence.mspct[[s]] <- interpolate_wl(fluence.mspct[[s]], w.length.out = 360:830, fill = 0)
  what_measured(fluence.mspct[[s]]) <- 
                  paste("LED grow light:", 
                  gsub("_|\\.", " ", gsub("LED\\.", "", s)))
  how_measured(fluence.mspct[[s]]) <- 
                 paste("Digitized from figure in manufacturer's brochure or image from web site in ",
                       vintage, ".", sep = "")
  when_measured(fluence.mspct[[s]]) <- 
    if (grepl("AnthoSpec|Greenhouse", s)) ymd("2019-06-04") else ymd("2022-03-06")
  print(str(get_attributes(fluence.mspct[[s]])))
  print(autoplot(fluence.mspct[[s]], 
                 span = 11,
                 annotations = c("+", "title:what:when:comment")))
  readline("next:")
}

autoplot(fluence.mspct)
summary(fluence.mspct)
what_measured(fluence.mspct)
how_measured(fluence.mspct)
when_measured(fluence.mspct)

# fluence_lamps <- names(fluence.mspct)
save(fluence.mspct, file = "data-raw/fluence-mspct.rda")

