rm(list = ls(pattern = "*"))

library(photobiology)

file.names <- list.files("./data-raw/Maya", "spct.Rda|spct.rda", full.names = TRUE)

for (f in file.names) {
  load(f, verbose = TRUE)
}
rm(f)
rm(file.names)
rm(list = ls(pattern = ".raw_mspct"))

setWhatMeasured(test_led_desk01.spct, "Osram Warm white LED bulb, 8W 230V 2700K E27")

# Renaming
Valoya_B100_AP67.spct <- Valoya.AP67.no.filter.210mm.100pc.spct
Osram_LED_8W_2700K.spct <- test_led_desk01.spct
Airam_LED_Oiva_9W_3000K.spct <- Airam_LED_Oiva_3000K_9W.spct
Osram_L36W_840.spct <- L36W.840.spct
Philips_TLD_36W_18.spct <- TLD.36W.18.spct
Pirkka_Halogen_53W_E27.spct <- Halogen_53W_E27_Pirkka.spct
Amaran_AL_M9.spct <- Amaran.AL.M9.no1.spct
Airam_LED_11W_4000K.spct <- Airam.LED.11W.4000K.spct

rm(Valoya.AP67.no.filter.210mm.100pc.spct, 
   Airam.LED.11W.4000K.spct,
   Amaran.AL.M9.no1.spct,
   test_led_desk01.spct,
   Airam_LED_Oiva_3000K_9W.spct,
   L36W.840.spct,
   TLD.36W.18.spct,
   Halogen_53W_E27_Pirkka.spct)

object.names <- ls(pattern = ".spct")

oo_maya.mspct <- list()
for (o in object.names) {
  oo_maya.mspct[[tolower(gsub(".spct|.lfd|.E27", "", gsub("_", ".", o)))]] <- trimInstrDesc(get(o))
}
rm(o)

oo_maya.mspct <- normalize(clean(source_mspct(oo_maya.mspct)))

names(oo_maya.mspct)

save(oo_maya.mspct, file = "data-raw/oo-maya-mspct.rda")
