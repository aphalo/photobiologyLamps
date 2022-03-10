## ---- echo=FALSE--------------------------------------------------------------
knitr::opts_chunk$set(fig.width=8, fig.height=4)

## ---- message=FALSE-----------------------------------------------------------
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
autoplot(lamps.mspct$Osram.LED.8W.2700K)

## -----------------------------------------------------------------------------
what_measured(ledsavers.mspct$purple)
how_measured(ledsavers.mspct$purple)

## -----------------------------------------------------------------------------
autoplot(ledsavers.mspct$purple)

## -----------------------------------------------------------------------------
ggplot(ledsavers.mspct$purple) +
  geom_line(linetype = "dashed") +
  theme_classic()

## -----------------------------------------------------------------------------
autoplot(ledsavers.mspct[c( "W", "R", "G", "B")],
         annotations = c("+", "title:what")) +
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

