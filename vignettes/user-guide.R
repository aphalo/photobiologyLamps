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
lamps.mspct$incandescent.60w

## -----------------------------------------------------------------------------
lamps.mspct[["incandescent.60w"]]

## -----------------------------------------------------------------------------
lamps.mspct["incandescent.60w"]

## -----------------------------------------------------------------------------
lamps.mspct[toshiba_lamps]

## -----------------------------------------------------------------------------
lamps.mspct[grep("toshiba", names(lamps.mspct))]

## -----------------------------------------------------------------------------
lamps.mspct[intersect(philips_lamps, red_lamps)]

## -----------------------------------------------------------------------------
my.spct <- fscale(lamps.mspct$incandescent.60w,
                  range = c(400, 700),
                  f = e_irrad,
                  target = 100
                  )
e_irrad(my.spct, waveband(c(400,700)))

## -----------------------------------------------------------------------------
is_scaled(my.spct)

## -----------------------------------------------------------------------------
my.spct <- fscale(lamps.mspct$incandescent.60w,
                  range = c(400, 700),
                  f = q_irrad,
                  target = 300e-6
                  )
q_irrad(my.spct, waveband(c(400,700)))


## -----------------------------------------------------------------------------
my.spct <- fscale(lamps.mspct$incandescent.60w,
                  range = c(400, 700),
                  f = e_irrad,
                  target = 1
                  )
is_scaled(my.spct)

## -----------------------------------------------------------------------------
normalize(lamps.mspct$philips.tld.36w.18)

## -----------------------------------------------------------------------------
q_ratio(my.spct, Red("Smith10"), Far_red("Smith10"))

## -----------------------------------------------------------------------------
autoplot(lamps.mspct$osram.led.8w.2700k)

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
head(as.data.frame(lamps.mspct$incandescent.60w))

## -----------------------------------------------------------------------------
attach(lamps.mspct)
q_ratio(incandescent.60w, Blue(), Red())
detach(lamps.mspct)

## -----------------------------------------------------------------------------
attach(lamps.mspct)
with(incandescent.60w, max(w.length))
detach(lamps.mspct)

## -----------------------------------------------------------------------------
with(lamps.mspct, q_ratio(incandescent.60w, Blue(), Red()))

