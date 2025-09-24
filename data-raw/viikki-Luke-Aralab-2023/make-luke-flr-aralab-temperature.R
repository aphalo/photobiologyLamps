library(photobiology)
library(photobiologyWavebands)
library(photobiologyPlants)
library(dplyr)
library(ggpmisc)
library(ggspectra)

rm(list = ls(pattern = "*"))

photon_as_default()

file.names <- list.files(path = "data-raw/viikki-Luke-Aralab-2023/",
                         pattern = "aralab_100pc_.*Rda|Aralab.Luke.100pc.*Rda",
                         full.names = TRUE)

for (f in file.names) {
  load(f)
}

rm(list = ls(pattern = "raw_mspct$"))

aralab_luke.mspct <- collect2mspct() |> subset2mspct() |> clean()

# load("collection.Aralab.Luke.fluorescent.temperature.Rda")
# aralab_luke.mspct <- collection.Aralab.Luke.fluorescent.temperature.irrad.mspct[-1]

summary(aralab_luke.mspct)

how_measured(aralab_luke.mspct) # correct values already set
when_measured(aralab_luke.mspct) # correct values already set
what_measured(aralab_luke.mspct) # set to spct.idx!
what_measured(aralab_luke.mspct) <- "Osram L 18W/840 Lumilux, used, dimming at 100%"
what_measured(aralab_luke.mspct) # set to spct.idx!

comment(aralab_luke.mspct) # Not set.
comment(aralab_luke.mspct) <-
  "Temperature response of spectral irradiance from white fluorescent tubes in an Aralab FitoClima 1200 growth chamber."

# from chamber controller display of current temperature

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

names(temperature.true) <- names(aralab_luke.mspct)
temperature.true

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

irrads.df$temperature <- unname(temperature.true)

selector <- !grepl("series", irrads.df$spct.idx)
selector <- selector & 
  round(irrads.df$temperature) %in% c(5, 10, 15, 20, 22, 25, 30, 35)
selector <- ifelse(is.na(selector), FALSE, selector)
sum(selector)
irrads.df$temperature[selector]

spct.names <- names(aralab_luke.mspct)[selector]
round.tC <- round(temperature.true[names(aralab_luke.mspct)[selector]])

Osram_L_18W_840_temp.mspct <- source_mspct()
Osram_L_18W_840_temp.mspct[["5C"]] <- 
  s_median(aralab_luke.mspct[names(round.tC[round.tC == 5])])
Osram_L_18W_840_temp.mspct[["10C"]] <-
  s_median(aralab_luke.mspct[names(round.tC[round.tC == 10])])
Osram_L_18W_840_temp.mspct[["15C"]] <-
  s_median(aralab_luke.mspct[names(round.tC[round.tC == 15])])
Osram_L_18W_840_temp.mspct[["20C"]] <-
  s_median(aralab_luke.mspct[names(round.tC[round.tC == 20])])
Osram_L_18W_840_temp.mspct[["22C"]] <-
  s_median(aralab_luke.mspct[names(round.tC[round.tC == 22])])
Osram_L_18W_840_temp.mspct[["25C"]] <-
  s_median(aralab_luke.mspct[names(round.tC[round.tC == 25])])
Osram_L_18W_840_temp.mspct[["30C"]] <-
  s_median(aralab_luke.mspct[names(round.tC[round.tC == 30])])
Osram_L_18W_840_temp.mspct[["35C"]] <- 
  s_median(aralab_luke.mspct[names(round.tC[round.tC == 35])])

for (i in names(Osram_L_18W_840_temp.mspct)) {
  what_measured(Osram_L_18W_840_temp.mspct[[i]]) <-
                  paste(what_measured(Osram_L_18W_840_temp.mspct[[i]]),
                        ", t =", i)
  Osram_L_18W_840_temp.mspct[[i]] <- trimInstrDesc(Osram_L_18W_840_temp.mspct[[i]])
  Osram_L_18W_840_temp.mspct[[i]] <- trimInstrSettings(Osram_L_18W_840_temp.mspct[[i]])
}
what_measured(Osram_L_18W_840_temp.mspct)[ , 2]

autoplot(Osram_L_18W_840_temp.mspct, facets = 3, span = 101)

q_irrad(Osram_L_18W_840_temp.mspct, 
        c(list(PAR = PAR(), IRA = IRA(), NIR = NIR()),
          Plant_bands("Sellaro"),
          Plant_bands()[6:7],
          list(total = waveband(x = c(250, 1050)))),
        scale.factor = 1e6) |>
  mutate(temperature = as.numeric(gsub("C", "", spct.idx))) -> irrads.df

# Pfr_Ptot() uses data up to 760nm which is not enough in this case!!
aralab_Pfr_Ptot <- msdply(Osram_L_18W_840_temp.mspct, Pfr_Ptot)

irrads.df <- full_join(irrads.df, aralab_Pfr_Ptot)

nrow(irrads.df)
colnames(irrads.df)

ggplot(irrads.df,
       aes(temperature, Q_PAR)) +
  geom_point() +
  geom_smooth() +
  expand_limits(y = 0)

ggplot(irrads.df,
       aes(temperature, Q_IRA)) +
  geom_point() +
  geom_smooth() +
  expand_limits(y = 0)

ggplot(irrads.df,
       aes(temperature, Q_NIR)) +
  geom_point() +
  geom_smooth() +
  expand_limits(y = 0)

ggplot(irrads.df,
       aes(temperature, Q_UVA1.CIE)) +
  geom_point() +
  geom_smooth() +
  expand_limits(y = 0)

ggplot(irrads.df,
       aes(temperature, Q_PAR / Q_total)) +
  geom_point() +
  geom_smooth() +
  expand_limits(y = 0)

ggplot(irrads.df,
       aes(temperature, Q_IRA / Q_total)) +
  geom_point() +
  geom_smooth() +
  expand_limits(y = 0)

ggplot(irrads.df,
       aes(temperature, Q_NIR / Q_total)) +
  geom_point() +
  geom_smooth() +
  expand_limits(y = 0)

ggplot(irrads.df,
       aes(temperature, Q_UVA1.CIE / Q_total * 1e3)) +
  geom_point() +
  geom_smooth() +
  expand_limits(y = 0)

ggplot(irrads.df,
       aes(temperature, Q_Blue.Sellaro / Q_Green.Sellaro)) +
  geom_point() +
  geom_smooth() +
  expand_limits(y = 0)

ggplot(irrads.df,
       aes(temperature, Q_Red.Sellaro / Q_FarRed.Sellaro)) +
  geom_point() +
  geom_smooth() +
  expand_limits(y = 0)

ggplot(irrads.df,
       aes(temperature, Q_Blue.Sellaro / Q_Red.Sellaro)) +
  geom_point() +
  geom_smooth() +
  expand_limits(y = 0)

ggplot(irrads.df,
       aes(temperature, Q_Red.Smith20 / Q_FarRed.Smith20)) +
  geom_point() +
  geom_smooth() +
  expand_limits(y = 0)

ggplot(irrads.df,
       aes(temperature, Pfr_Ptot_V1)) +
  geom_point() +
  geom_smooth() +
  expand_limits(y = 0)

save(Osram_L_18W_840_temp.mspct,
     file = "./data/osram-l-18w-840-temp-mspct.rda")
