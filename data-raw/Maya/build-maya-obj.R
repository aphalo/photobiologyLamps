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
Valoya_B50_AP67.spct <- Valoya.AP67.no.filter.210mm.100pc.spct
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

setWhatMeasured(Valoya_B50_AP67.spct, 
                "Valoya B50/AP67 inside Aralab FitoClima 1200 chamber at 100% output")
setWhatMeasured(Osram_LED_8W_2700K.spct,
                "Osram LED STAR CLASSIC A 60 2700K Ra 80 E27")
setWhatMeasured(Toshiba_LED_9.5W_2700K.spct,
                "Toshiba 9.5W 2700K 806 lm E27")
# setWhatMeasured(,
#                 "Airam Compact 2000 Longlife 1W compact fluorescent 2700K E27")
setWhatMeasured(Osram_conc_spot_60W_E27.spct,
                "Osram CONC SPOT RG3 30 degrees 230V 60W")
setWhatMeasured(Osram_Classic_20W_E27_lfd.spct,
                "Osram Classic 64541 A 20W 230V Halogen E27 235 lm 2700K Ra 100")
setWhatMeasured(Pirkka_Halogen_53W_E27.spct,
                "Pirkka Halogeenilampuu 53W 240V E27 2800K")
setWhatMeasured(Airam_spiraali_lfd.spct,
                "Airam Spiraali 14W 220-240W 3000K E27 900 lm CRI>=80")

object.names <- ls(pattern = ".spct")

oo_maya.mspct <- list()
for (o in object.names) {
  oo_maya.mspct[[tolower(gsub(".spct|.lfd|.E27", "", gsub("_", ".", o)))]] <- trimInstrDesc(get(o))
}
rm(o)

oo_maya.mspct <- normalize(clean(source_mspct(oo_maya.mspct)))

names(oo_maya.mspct)

save(oo_maya.mspct, file = "data-raw/oo-maya-mspct.rda")
