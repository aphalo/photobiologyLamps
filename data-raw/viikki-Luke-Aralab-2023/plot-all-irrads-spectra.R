library(photobiology)
library(photobiologyWavebands)
library(photobiologyPlants)
library(dplyr)

rm(list = ls(pattern = "*"))

photon_as_default()

file.names <- list.files(path = "data-raw/viikki-Luke-Aralab-2023/",
                         pattern = "aralab_100pc_.*Rda|Aralab.Luke.100pc.*Rda",
                         full.names = TRUE)

for (f in file.names) {
  load(f)
}

rm(list = ls(pattern = "raw_mspct$"))

aralab_luke.mspct <- collect2mspct()

# load("collection.Aralab.Luke.fluorescent.temperature.Rda")
# aralab_luke.mspct <- collection.Aralab.Luke.fluorescent.temperature.irrad.mspct[-1]

summary(aralab_luke.mspct)

q_irrad(aralab_luke.mspct, c(list(PAR = PAR(), IRA = IRA(), NIR = NIR()),
                             Plant_bands("Sellaro"),
                             Plant_bands()[6:7]),
        scale.factor = 1e6) |>
  mutate(temp = gsub("aralab_|Aralab.Luke.|.spct|.a", "", spct.idx),
         temp = strsplit(temp, c(".", "_"), fixed = TRUE),
         dimming = unlist(temp)[1],
         temperature = unlist(temp)[2],
         dimming = as.numeric(gsub("pc$", "", dimming)),
         temperature = as.numeric(gsub("C$", "", temperature)),
         temp = NULL,
         spct.idx = gsub(".spct$", "", spct.idx)) -> irrads.df

temperature.true <- c(10, 15, 20,
                      rep(22, 50),
                      22, 5, 5,
                      rep(22, 5), 22.3, 22.6, 22.9, 23.4, 23.8,
                      24.2, 24.6, 24.9, 25.1, 25.2, 25.3,
                      rep(NA, 7),
                      25.6, 25.7, 26.1, 26.2, 26.3, 26.4,
                      26.5, 26.4, 26.5, 26.7, 27.2, 27.7, 28.15, 28.5, 29.0, 29.3,
                      29.6, 29.8, 30.1,
                      30.5, 30.5, 30.6, 30.9, 31.2, 31.6, 32, 32.6, 33.1, 33.5,
                      34, 34.3, 34.6, 34.9, 35.0,
                      35.7, 35.8, 35.8, 35.8, 35.8, 35.8)

irrads.df$temperature <- temperature.true

nrow(irrads.df)
colnames(irrads.df)
unique(irrads.df$dimming)
sum(na.omit(irrads.df$temperature) == 22)

library(ggpmisc)
library(ggspectra)

ggplot(subset(irrads.df, dimming == 100),
       aes(temperature, Q_PAR)) +
  geom_point() +
  geom_line() +
  expand_limits(y = 0)

ggplot(subset(irrads.df, dimming == 100),
       aes(temperature, Q_IRA / Q_PAR)) +
  geom_point() +
  stat_poly_line(formula = y ~ poly(x, 3, raw = TRUE))

ggplot(subset(irrads.df, dimming == 100),
       aes(temperature, Q_NIR / Q_PAR)) +
  geom_point() +
  stat_poly_line(formula = y ~ poly(x, 3, raw = TRUE))

ggplot(subset(irrads.df, dimming == 100),
       aes(temperature, Q_UVA1.CIE / Q_PAR)) +
  geom_point() +
  stat_poly_line(formula = y ~ poly(x, 3, raw = TRUE))

ggplot(subset(irrads.df, dimming == 100),
       aes(temperature, Q_Blue.Sellaro / Q_Green.Sellaro)) +
  geom_point() +
  stat_poly_line(formula = y ~ poly(x, 2, raw = TRUE))

ggplot(subset(irrads.df, dimming == 100),
       aes(temperature, Q_Red.Sellaro / Q_FarRed.Sellaro)) +
  geom_point() +
  stat_poly_line(formula = y ~ poly(x, 2, raw = TRUE))

ggplot(subset(irrads.df, dimming == 100),
       aes(temperature, Q_Red.Smith20 / Q_FarRed.Smith20)) +
  geom_point() +
  stat_poly_line(formula = y ~ poly(x, 2, raw = TRUE))

ggplot(subset(irrads.df, temperature == 20),
       aes(dimming, Q_PAR / max(Q_PAR) * 100)) +
  geom_point() +
  stat_poly_line(se = FALSE) +
  expand_limits(y = 0)

ggplot(subset(irrads.df, temperature == 15),
       aes(dimming, Q_PAR / max(Q_PAR) * 100)) +
  geom_point() +
  stat_poly_line(se = FALSE) +
  expand_limits(y = 0)

ggplot(subset(irrads.df, temperature == 20),
       aes(dimming, Q_IRA/Q_PAR)) +
  geom_point() +
  geom_line() +
  expand_limits(y = 0)

ggplot(subset(irrads.df, temperature == 15),
       aes(dimming, Q_IRA/Q_PAR)) +
  geom_point() +
  geom_line() +
  expand_limits(y = 0)

ggplot(subset(irrads.df, temperature == 20),
       aes(dimming,  Q_Red.Smith20 / Q_FarRed.Smith20)) +
  geom_point() +
  geom_line() +
  expand_limits(y = 0)

ggplot(subset(irrads.df, temperature == 15),
       aes(dimming,  Q_Red.Smith20 / Q_FarRed.Smith20)) +
  geom_point() +
  geom_line() +
  expand_limits(y = 0)

autoplot(aralab_luke.mspct[grepl("100pc", names(aralab_luke.mspct))], facets = 1, span = 51)

autoplot(normalise(aralab_luke.mspct[grepl("100pc", names(aralab_luke.mspct))]), facets = 1, span = 51)

autoplot(normalise(aralab_luke.mspct[grepl("20C", names(aralab_luke.mspct))]), facets = 1, span = 51)
autoplot(normalise(aralab_luke.mspct[grepl("15C", names(aralab_luke.mspct))]), facets = 1, span = 51)

# Pfr_Ptot() uses data up to 760nm which is not enough in this case!!
aralab_Pfr_Ptot <-
msdply(aralab_luke.mspct, Pfr_Ptot)

