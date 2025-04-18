## ----echo=FALSE---------------------------------------------------------------
knitr::opts_chunk$set(fig.width=8, fig.height=4)

## ----message=FALSE------------------------------------------------------------
library(photobiology)
library(photobiologyWavebands)
library(photobiologyLamps)
library(ggplot2)
library(ggspectra)

## -----------------------------------------------------------------------------
names(lamps.mspct)

## -----------------------------------------------------------------------------
lamps.mspct$Generic.Inc.bulb.60W

## -----------------------------------------------------------------------------
lamps.mspct[["Generic.Inc.bulb.60W"]]

## -----------------------------------------------------------------------------
lamps.mspct["Generic.Inc.bulb.60W"]

## -----------------------------------------------------------------------------
lamps.mspct[Toshiba_lamps]

## -----------------------------------------------------------------------------
lamps.mspct[grep("Toshiba", names(lamps.mspct))]

## -----------------------------------------------------------------------------
lamps.mspct[intersect(Philips_lamps, red_lamps)]

## -----------------------------------------------------------------------------
what_measured(lamps.mspct$Eiko.F36T8.BLB)

## -----------------------------------------------------------------------------
how_measured(lamps.mspct$Eiko.F36T8.BLB)

## -----------------------------------------------------------------------------
getInstrSettings(lamps.mspct$Eiko.F36T8.BLB)

## -----------------------------------------------------------------------------
getInstrDesc(lamps.mspct$Eiko.F36T8.BLB)

## -----------------------------------------------------------------------------
getNormalisation(lamps.mspct$Eiko.F36T8.BLB)

## -----------------------------------------------------------------------------
my.spct <- fscale(lamps.mspct$Generic.Inc.bulb.60W,
                  range = c(400, 700),
                  f = e_irrad,
                  target = 100
                  )
e_irrad(my.spct, waveband(c(400,700)))

## -----------------------------------------------------------------------------
is_scaled(my.spct)

## -----------------------------------------------------------------------------
my.spct <- fscale(lamps.mspct$Generic.Inc.bulb.60W,
                  range = c(400, 700),
                  f = q_irrad,
                  target = 300e-6
                  )
q_irrad(my.spct, waveband(c(400,700)))


## -----------------------------------------------------------------------------
my.spct <- fscale(lamps.mspct$Generic.Inc.bulb.60W,
                  range = c(400, 700),
                  f = e_irrad,
                  target = 1
                  )
is_scaled(my.spct)

## -----------------------------------------------------------------------------
normalize(lamps.mspct$Philips.FT.TLD.36W.15)

## -----------------------------------------------------------------------------
q_ratio(my.spct, Red("Smith10"), Far_red("Smith10"))

## -----------------------------------------------------------------------------
autoplot(lamps.mspct$Osram.LED.8W.2700K, w.band = VIS(), span = 51)

## -----------------------------------------------------------------------------
what_measured(ledsavers.mspct$purple)
how_measured(ledsavers.mspct$purple)

## -----------------------------------------------------------------------------
autoplot(ledsavers.mspct$purple, w.band = VIS(), span = 51)

## -----------------------------------------------------------------------------
ggplot(ledsavers.mspct$purple) +
  geom_line(linetype = "dashed") +
  theme_classic()

## -----------------------------------------------------------------------------
autoplot(ledsavers.mspct[c( "W", "R", "G", "B")],
         annotations = c("+", "title:what"), w.band = VIS(), span = 51) +
  labs(linetype = "Channel")

## -----------------------------------------------------------------------------
head(as.data.frame(lamps.mspct$Osram.LED.8W.2700K))

## -----------------------------------------------------------------------------
attach(lamps.mspct)
q_ratio(Osram.LED.8W.2700K, Blue(), Red())
detach(lamps.mspct)

## -----------------------------------------------------------------------------
attach(lamps.mspct)
with(Osram.LED.8W.2700K, max(w.length))
detach(lamps.mspct)

## -----------------------------------------------------------------------------
with(lamps.mspct, q_ratio(Osram.LED.8W.2700K, Blue(), Red()))

## -----------------------------------------------------------------------------
head(qp_uvb313_temp.spct)

## -----------------------------------------------------------------------------
unique(qp_uvb313_temp.spct$temperature)

## -----------------------------------------------------------------------------
names(qp_uvb313_temp.mspct)

## -----------------------------------------------------------------------------
summary(qp_uvb313_temp.mspct)

## -----------------------------------------------------------------------------
head(qp_uvb313_temp.mspct$minus05C)

## -----------------------------------------------------------------------------
names(ledsavers.mspct)

## -----------------------------------------------------------------------------
autoplot(ledsavers.mspct[c("R", "G", "B", "W")], 
         w.band = VIS_bands(), span = 51)

## -----------------------------------------------------------------------------
names(sunwayfoto_fl96.mspct)

## -----------------------------------------------------------------------------
what_measured(sunwayfoto_fl96.mspct)

## -----------------------------------------------------------------------------
names(elgato_klm_cct.mspct)

## -----------------------------------------------------------------------------
what_measured(elgato_klm_cct.mspct)

## -----------------------------------------------------------------------------
autoplot(elgato_klm_cct.mspct)

## -----------------------------------------------------------------------------
names(elgato_klm_dim.mspct)

## -----------------------------------------------------------------------------
what_measured(elgato_klm_dim.mspct)

## -----------------------------------------------------------------------------
autoplot(elgato_klm_dim.mspct)

## -----------------------------------------------------------------------------
names(amaran_m9.mspct)

## -----------------------------------------------------------------------------
what_measured(amaran_m9.mspct)

## -----------------------------------------------------------------------------
names(andoer_ir49.mspct)

## -----------------------------------------------------------------------------
what_measured(andoer_ir49.mspct)

