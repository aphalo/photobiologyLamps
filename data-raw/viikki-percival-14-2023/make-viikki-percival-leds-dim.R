library(photobiology)
library(photobiologyWavebands)
library(photobiologyPlants)
library(dplyr)
library(ggpmisc)
library(ggspectra)

rm(list = ls(pattern = "*"))

photon_as_default()

load("data-raw/viikki-percival-14-2023/collection.chamber_14.Rda")

rm(list = ls(pattern = "raw_mspct$"))

Percival_LED_dim.mspct <- collection.chamber_14.irrad.mspct |> clean()
selector <- grepl("trays", names(Percival_LED_dim.mspct))
length(selector)
Percival_LED_dim.mspct <- Percival_LED_dim.mspct[selector]
names(Percival_LED_dim.mspct) <- 
  gsub("chamber_14|_trays\\.spct", "", names(Percival_LED_dim.mspct)) |>
  gsub("^pc", "", x = _) |>
  gsub("^_|^\\.", "", x = _)

autoplot(Percival_LED_dim.mspct)
summary(Percival_LED_dim.mspct)

how_measured(Percival_LED_dim.mspct) # correct values already set
when_measured(Percival_LED_dim.mspct) # correct values already set
what_measured(Percival_LED_dim.mspct) # set to spct.idx!
what_measured(Percival_LED_dim.mspct) <- "Percival growth chamber LEDs"
what_measured(Percival_LED_dim.mspct) # set to spct.idx!

comment(Percival_LED_dim.mspct) # Not set.
comment(Percival_LED_dim.mspct) <-
  "Dimming response of spectral irradiance from white LEDs in a Percival growth chamber at different nominal dimming settings."


q_irrad(Percival_LED_dim.mspct, c(list(PAR = PAR(), IRA = IRA(), NIR = NIR()),
                             Plant_bands("Sellaro"),
                             Plant_bands()[6:7]),
        scale.factor = 1e6) |>
  mutate(dimming = as.numeric(gsub("pc$", "", spct.idx))) -> irrads.df

for (i in names(Percival_LED_dim.mspct)) {
  what_measured(Percival_LED_dim.mspct[[i]]) <-
                  paste(what_measured(Percival_LED_dim.mspct[[i]]),
                        ", dimming set at ", gsub("pc", "%", i), sep = "")
}
what_measured(Percival_LED_dim.mspct)[ , 2]

autoplot(Percival_LED_dim.mspct, facets = 3, span = 101)

q_irrad(Percival_LED_dim.mspct, 
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

save(Percival_LED_dim.mspct,
     file = "./data/percival-led-dim-mspct.rda")
