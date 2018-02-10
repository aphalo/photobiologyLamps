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
lamps.mspct[macam_lamps]

## ------------------------------------------------------------------------
lamps.mspct[osram_lamps]

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
getScaled(my.spct)
setScaled(my.spct)
getScaled(my.spct)

## ------------------------------------------------------------------------
my.lamp <- lamps.mspct$incandescent.60w
setNormalized(my.lamp)
e_irrad(my.lamp)

## ------------------------------------------------------------------------
q_ratio(lamps.mspct$incandescent.60w, Red("Smith10"), Far_red("Smith10"))

## ------------------------------------------------------------------------
head(as.data.frame(lamps.mspct$incandescent.60w))

## ------------------------------------------------------------------------
attach(lamps.mspct)
q_ratio(incandescent.60w, Blue(), Red())
detach(lamps.mspct)

## ------------------------------------------------------------------------
attach(lamps.mspct)
with(incandescent.60w, max(w.length))
detach(lamps.mspct)

## ------------------------------------------------------------------------
with(lamps.mspct, q_ratio(incandescent.60w, Blue(), Red()))

