## ------------------------------------------------------------------------
knitr::opts_chunk$set(fig.width=8, fig.height=4)

## ------------------------------------------------------------------------
library(photobiology)
library(photobiologyWavebands)
library(photobiologyLamps)

## ------------------------------------------------------------------------
names(lamps.mspct)

## ------------------------------------------------------------------------
lamps.mspct$incandescent.60w

## ------------------------------------------------------------------------
lamps.mspct[["incandescent.60w"]]

## ------------------------------------------------------------------------
lamps.mspct["incandescent.60w"]

## ------------------------------------------------------------------------
lamps.mspct[macam]

## ------------------------------------------------------------------------
lamps.mspct[grep("osram", names(lamps.mspct))]

## ------------------------------------------------------------------------
my.spct <- fscale(lamps.mspct$incandescent.60w,
                  range = c(400, 700),
                  e_irrad,
                  target = 100
                  )
e_irrad(my.spct, waveband(c(400,700)))

## ------------------------------------------------------------------------
e_irrad(setNormalized(lamps.mspct$incandescent.60w))

## ------------------------------------------------------------------------
q_ratio(lamps.mspct$incandescent.60w, Red("Smith10"), Far_red("Smith10"))

## ------------------------------------------------------------------------
head(as.data.frame(lamps.mspct$incandescent.60w))

## ------------------------------------------------------------------------
attach(lamps.mspct)
q_irrad(setNormalized(incandescent.60w)) * 1e6
detach(lamps.mspct)

## ------------------------------------------------------------------------
attach(lamps.mspct)
with(incandescent.60w, max(w.length))
detach(lamps.mspct)

## ------------------------------------------------------------------------
with(lamps.mspct, q_irrad(setNormalized(incandescent.60w)) * 1e6)

