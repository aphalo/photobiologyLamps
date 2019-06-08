rm(list = ls(pattern = "*"))

library(photobiology)
library(ggspectra)

file.names <- list.files("./data-raw/Maya", "spct.Rda|spct.rda", full.names = TRUE)

for (f in file.names) {
  load(f, verbose = TRUE)
}
rm(f)
rm(file.names)
rm(list = ls(pattern = ".raw_mspct"))

# Renaming
Valoya_B50_AP67.spct <- Valoya.AP67.no.filter.210mm.100pc.spct
Osram_LED_8W_2700K.spct <- test_led_desk01.spct
Airam_LED_Oiva_9W_3000K.spct <- Airam_LED_Oiva_3000K_9W.spct
Osram_L36W_840.spct <- L36W.840.spct
Philips_TLD_36W_18.spct <- TLD.36W.18.spct
Pirkka_Halogen_53W_E27.spct <- Halogen_53W_E27_Pirkka.spct
Amaran_AL_M9.spct <- Amaran_100.spct
Airam_LED_11W_4000K.spct <- Airam.LED.11W.4000K.spct
Godox_AD200_H200j_ADFT200.spct <- bare.bulb.godox.1.128.spct
Godox_AD200_H200j_ADFT200_IR.spct <- Godox.bare.128.spct
Godox_AD200_H200.spct <- speedlight.1.128.spct
Godox_AD200_H200R.spct <- round.1.128.spct
Godox_AD200_H200j_FTSTS40w.spct <- bare.bulb.israel.1.128.spct
Convoy_UV_flashlight.spct <- Convoy_2plus.spct
Philips_LED_T8_10W_840.spct <- Philips.LED.T8.10W.840.daylight.spct
Sunwayfoto_FL96_3000K.spct <- sunwayfoto_100_3000K.spct
Sunwayfoto_FL96_5500K.spct <- Sunwayfoto_100_5500K.spct

rm(Valoya.AP67.no.filter.210mm.100pc.spct, 
   Airam.LED.11W.4000K.spct,
   Amaran_100.spct,
   test_led_desk01.spct,
   Airam_LED_Oiva_3000K_9W.spct,
   L36W.840.spct,
   TLD.36W.18.spct,
   Convoy_2plus.spct,
   Halogen_53W_E27_Pirkka.spct,
   bare.bulb.godox.1.128.spct,
   bare.bulb.israel.1.128.spct,
   Godox.bare.128.spct,
   speedlight.1.128.spct,
   round.1.128.spct,
   sunwayfoto_100_3000K.spct,
   Sunwayfoto_100_5500K.spct,
   Philips.LED.T8.10W.840.daylight.spct)

# trim out bad data
all.spectra <- ls(pattern = ".spct$")

for (s in all.spectra[grepl("^Godox", all.spectra) & !grepl("IR", all.spectra)]) {
   tmp <- trim_wl(get(s), range = c(300,800))
   assign(s, tmp)
}
rm(tmp)
Godox_AD200_H200j_ADFT200_IR.spct <- trim_wl(Godox_AD200_H200j_ADFT200_IR.spct, range = c(300, NA))

## What measured
setWhatMeasured(Godox_AD200_H200j_ADFT200_IR.spct, 
                "Godox AD200 flash, head: Godox H200j (bare bulb), lamp: Godox AD-FT200, power setting: 1/128")
setWhatMeasured(Godox_AD200_H200j_ADFT200.spct, 
                "Godox AD200 flash, head: Godox H200j (bare bulb), lamp: Godox AD-FT200, power setting: 1/128")
setWhatMeasured(Godox_AD200_H200j_FTSTS40w.spct, 
                "Godox AD200 flash, head: Godox H200j (bare bulb), lamp: xenonflashtubes.com FT-ST-S40w, power setting: 1/128")
setWhatMeasured(Godox_AD200_H200.spct, 
                "Godox AD200 flash, head: Godox H200 (speedligh fresnel), power setting: 1/128")
setWhatMeasured(Godox_AD200_H200R.spct, 
                "Godox AD200 flash, head: Godox H200R (round), power setting: 1/128")
setWhatMeasured(Convoy_UV_flashlight.spct, 
                "Convoy 2+ flashlight, Nichia 365 nm LED, filter: UV-pass (unknown type), 1mm")
setWhatMeasured(Cree_UV_flashlight.spct, 
                "Convoy 2+ flashlight, Nichia 365 nm LED, filter: UV-pass (unknown type), 1mm")
setWhatMeasured(Philips_LED_T8_10W_840.spct, 
                "Philips LED T8 tube, 10W, colour: 840 (daylight)")
setWhatMeasured(Sunwayfoto_FL96_3000K.spct, 
                "Sunwayfoto FL-96, photography LED light with CRI >95, colour setting: 3000 K, power setting: 100%")
setWhatMeasured(Sunwayfoto_FL96_5500K.spct, 
                "Sunwayfoto FL-96, photography LED light with CRI >95, colour setting: 5500 K, power setting: 100%")
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
setWhatMeasured(Osram_LED_8W_2700K.spct, 
                "Osram Warm white LED bulb, 8W 230V 2700K E27")
setWhatMeasured(V.light.LED.2W.6000K.spct, 
                "INFORMATION TO BE ADDED")

object.names <- ls(pattern = ".spct")

oo_maya.mspct <- list()
for (o in object.names) {
   tmp <- get(o)
   setHowMeasured(tmp, "Measured with an array spectrometer")
   oo_maya.mspct[[tolower(gsub(".spct|.lfd|.E27", "", gsub("_", ".", o)))]] <- trimInstrDesc(tmp)
}
rm(o, tmp)

oo_maya.mspct <- normalize(clean(source_mspct(oo_maya.mspct)))

names(oo_maya.mspct)

save(oo_maya.mspct, file = "data-raw/oo-maya-mspct.rda")
