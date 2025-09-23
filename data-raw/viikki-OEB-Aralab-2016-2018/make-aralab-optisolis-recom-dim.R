library(photobiology)
library(photobiologyWavebands)
library(photobiologyPlants)
library(dplyr)
library(ggpmisc)
library(ggspectra)

rm(list = ls(pattern = "*"))

photon_as_default()

load("data-raw/viikki-OEB-Aralab-2016-2018/Aralab-Optisolis-2021-02-12/collection.Aralab.Optisolis.dimming.24cm.Rda")

rm(list = ls(pattern = "raw"))

Nichia_LED_RECOM_dim.mspct <- collection.Aralab.Optisolis.dimming.24cm.irrad.mspct |> clean()
summary(Nichia_LED_RECOM_dim.mspct)

names(Nichia_LED_RECOM_dim.mspct) <- 
  gsub("Aralab\\.3x|\\.spct", "", names(Nichia_LED_RECOM_dim.mspct))

autoplot(Nichia_LED_RECOM_dim.mspct)

how_measured(Nichia_LED_RECOM_dim.mspct) # not set

when_measured(Nichia_LED_RECOM_dim.mspct) # correct values already set
what_measured(Nichia_LED_RECOM_dim.mspct) # set to ""!
what_measured(Nichia_LED_RECOM_dim.mspct) <- "Nichia Optisolis LEDs driven by RECOM Power RCD-48 drivers. CC dimming"
what_measured(Nichia_LED_RECOM_dim.mspct) # set to spct.idx!

comment(Nichia_LED_RECOM_dim.mspct) # Not set.
comment(Nichia_LED_RECOM_dim.mspct) <-
  "Dimming response of spectral irradiance from custom-built light sources with CRI > 95 white LEDs in an Aralab growth chamber at different nominal dimming settings. Measurement distance 24 cm."

q_irrad(Nichia_LED_RECOM_dim.mspct, c(list(PAR = PAR(), IRA = IRA(), NIR = NIR()),
                             Plant_bands("Sellaro"),
                             Plant_bands()[6:7]),
        scale.factor = 1e6) |>
  mutate(dimming = as.numeric(gsub("pc$", "", spct.idx))) -> irrads.df

for (i in names(Nichia_LED_RECOM_dim.mspct)) {
  what_measured(Nichia_LED_RECOM_dim.mspct[[i]]) <-
                  paste(what_measured(Nichia_LED_RECOM_dim.mspct[[i]]),
                        ", dimming set at ", gsub("pc", "%", i), sep = "")
}
what_measured(Nichia_LED_RECOM_dim.mspct)[ , 2]

autoplot(Nichia_LED_RECOM_dim.mspct, facets = 3, span = 101)

q_irrad(Nichia_LED_RECOM_dim.mspct, 
        c(list(PAR = PAR(), IRA = IRA(), NIR = NIR()),
          Plant_bands("Sellaro"),
          Plant_bands()[6:7],
          list(total = waveband(x = c(250, 1050)))),
        scale.factor = 1e6) |>
  mutate(dimming = as.numeric(gsub("pc", "", spct.idx))) -> irrads.df

nrow(irrads.df)
colnames(irrads.df)

ggplot(irrads.df,
       aes(dimming, Q_PAR)) +
  geom_point() +
  geom_smooth() +
  expand_limits(y = 0)

ggplot(irrads.df,
       aes(dimming, Q_IRA)) +
  geom_point() +
  geom_smooth() +
  expand_limits(y = 0)

ggplot(irrads.df,
       aes(dimming, Q_NIR)) +
  geom_point() +
  geom_smooth() +
  expand_limits(y = 0)

ggplot(irrads.df,
       aes(dimming, Q_UVA1.CIE)) +
  geom_point() +
  geom_smooth() +
  expand_limits(y = 0)

ggplot(irrads.df,
       aes(dimming, Q_PAR / Q_total)) +
  geom_point() +
  geom_smooth() +
  expand_limits(y = 0)

ggplot(irrads.df,
       aes(dimming, Q_IRA / Q_total)) +
  geom_point() +
  geom_smooth() +
  expand_limits(y = 0)

ggplot(irrads.df,
       aes(dimming, Q_NIR / Q_total)) +
  geom_point() +
  geom_smooth() +
  expand_limits(y = 0)

ggplot(irrads.df,
       aes(dimming, Q_UVA1.CIE / Q_total * 1e3)) +
  geom_point() +
  geom_smooth() +
  expand_limits(y = 0)

ggplot(irrads.df,
       aes(dimming, Q_Blue.Sellaro / Q_Green.Sellaro)) +
  geom_point() +
  geom_smooth() +
  expand_limits(y = 0)

ggplot(irrads.df,
       aes(dimming, Q_Red.Sellaro / Q_FarRed.Sellaro)) +
  geom_point() +
  geom_smooth() +
  expand_limits(y = 0)

ggplot(irrads.df,
       aes(dimming, Q_Blue.Sellaro / Q_Red.Sellaro)) +
  geom_point() +
  geom_smooth() +
  expand_limits(y = 0)

ggplot(irrads.df,
       aes(dimming, Q_Red.Smith20 / Q_FarRed.Smith20)) +
  geom_point() +
  geom_smooth() +
  expand_limits(y = 0)

save(Nichia_LED_RECOM_dim.mspct,
     file = "./data/nichia-led-recom-dim-mspct.rda")
