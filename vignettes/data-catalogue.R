## ------------------------------------------------------------------------
knitr::opts_chunk$set(fig.width=8, fig.height=4)

## ------------------------------------------------------------------------
library(photobiology)
library(photobiologyWavebands)
library(photobiologyLamps)
library(ggplot2)
library(ggspectra)

## ------------------------------------------------------------------------
options(photobiology.plot.annotations =
          c("boxes", "labels", "colour.guide", "peaks", "title"))

## ------------------------------------------------------------------------
cat(comment(oo_maya.mspct$germicidal))
plot(oo_maya.mspct$germicidal)

## ------------------------------------------------------------------------
plot(bentham.mspct$philips.tl01)
plot(bentham.mspct$philips.tl12)

## ------------------------------------------------------------------------
plot(macam.mspct$philips.tl12)
plot(macam.mspct$qpanel.uvb313)

## ------------------------------------------------------------------------
fig_temp <- ggplot(data=qp_uvb313_temp.spct,
                   aes(x=w.length, y=s.e.irrad, colour=factor(temperature))) +
             scale_colour_brewer(type="seq", palette="YlOrRd")
fig_temp <- fig_temp + geom_line() +
  labs(x="Wavelength (nm)", y="Spectral energy irradiance (W m-2 nm-1)",
       colour="Temperature (C)")
print(fig_temp)

## ---- fig.width=8, fig.height=10-----------------------------------------
qp_uvb313_temp.spct$t_factor <- factor(qp_uvb313_temp.spct$temperature)
plot(qp_uvb313_temp.spct, annotations = c("boxes", "labels", "title")) +
  facet_wrap(~t_factor, ncol = 2)

## ------------------------------------------------------------------------
plot(macam.mspct$qpanel.uva340)

## ------------------------------------------------------------------------
plot(licor.mspct$philips.tld36w.15)
plot(licor.mspct$philips.tld36w.18)

## ------------------------------------------------------------------------
attach(licor.mspct)
plot(incandescent.60w)
plot(osram.36w.25)
plot(philips.tld36w.83)
plot(philips.tld36w.89)
plot(philips.tld36w.92)
plot(philips.tld36w.865)
plot(philips.tll36w.950)
plot(philips.pls11w.827)
plot(sylvania.215w.vho)
plot(osram.hqit.400w)
plot(osram.super.vialox)
detach(licor.mspct)

## ------------------------------------------------------------------------
FEL.spct <- FEL_spectrum(300:900)
D2.spct <- D2_spectrum(200:400)
plot(FEL.spct)
plot(D2.spct)

