library(readr)
library(lubridate)
library(ggpmisc)
library(photobiologyWavebands)
library(photobiologySun)
library(photobiologyFilters)
library(ggspectra)

Aralab_dim_24cm <- read_csv("Aralab-2021-02-12/collection.Aralab.Optisolis.dimming.24cm.csv")

View(Aralab_dim_24cm)

Aralab_dim_24cm$dim.pc <- c(100, 75, 66, 50, 33, 25, 20, 18)
Aralab_dim_24cm$li.190 <- c(1250, 907, 794, 575, 327, 200, 110, 73)

ggplot(Aralab_dim_24cm, aes(dim.pc, Q_PAR)) +
  geom_point() +
  geom_line()

ggplot(Aralab_dim_24cm, aes(dim.pc, `blue:green[q:q]`)) +
  geom_point() +
  geom_line()

ggplot(Aralab_dim_24cm, aes(dim.pc, `red:far-red[q:q]`)) +
  geom_point() +
  geom_line()

ggplot(Aralab_dim_24cm, aes(Q_PAR, li.190)) +
  geom_abline(slope = 1, intercept = 0, linetype = "dashed") +
  geom_point() +
  geom_line()

photon_as_default()

load("Aralab-2021-02-12/Aralab.3x100pc.spct.Rda")
load("Aralab-2021-02-12/Aralab.3x20pc.spct.Rda")
load("Aralab-2021-02-12/Aralab.3x100pc.yellow.plexi.spct.Rda")

moss_green_filter.mspct <-
  source_mspct(list("no filter" = Aralab.3x100pc.spct,
                    "moss green\nRosco gel" = Aralab.3x100pc.spct *
                      filters.mspct$Rosco_Moss_Green_EColour_no89_used))

yellow_filter.mspct <-
  source_mspct(list("no filter" = Aralab.3x100pc.spct,
                    "yellow\nPlexiglas" = Aralab.3x100pc.yellow.plexi.spct))

led_vs_sun.mspct <-
  source_mspct(list("LED 100%" = Aralab.3x100pc.spct,
                    "LED 10%" = Aralab.3x20pc.spct,
                    sun = sun_may_morning.spct))

autoplot(object = Aralab.3x100pc.spct)

ratios.par <- q_ratio(led_vs_sun.mspct, list(Blue("Sellaro"), Green("Sellaro"), Red("Sellaro")), PAR())
ratios.par[ , -1] <- round(ratios.par[ , -1], 2)
colnames(ratios.par) <- gsub("\\[q:q\\]", "", colnames(ratios.par))

sun_hourly_june.mspct <- subset2mspct(sun_hourly_june.spct)

irrad.sun <- q_irrad(sun_hourly_june.mspct, PAR(), scale.factor = 1e6)
ratios.sun <- q_ratio(sun_hourly_june.mspct[27:37], list(Blue("Sellaro"), Green("Sellaro"), Red("Sellaro")), PAR())
ratios.par[ , -1] <- round(ratios.par[ , -1], 2)
colnames(ratios.par) <- gsub("\\[q:q\\]", "", colnames(ratios.par))

ratios <- q_ratio(led_vs_sun.mspct, list(Blue("Sellaro"), Red("Smith10")), list(Green("Sellaro"), Far_red("Smith10")))
ratios[ , -1] <- round(ratios[ , -1], 2)
colnames(ratios) <- gsub("\\[q:q\\]", "", colnames(ratios))

autoplot(
  led_vs_sun.mspct
) +
  annotate(geom = "table_npc", npcx = c(1, 1), npcy = c(0.75, 0.9), label = list(ratios.par, ratios))

autoplot(
  normalize(led_vs_sun.mspct, norm = 550)
) +
  annotate(geom = "table_npc", npcx = c(0.5, 0.5), npcy = c(0.05, 0.2), label = list(ratios.par, ratios))

ratios.ylw <- q_ratio(yellow_filter.mspct, list(Blue("Sellaro"), Red("Smith10")), list(Green("Sellaro"), Far_red("Smith10")))
ratios.ylw[ , -1] <- round(ratios.ylw[ , -1], 2)
colnames(ratios.ylw) <- gsub("\\[q:q\\]", "", colnames(ratios.ylw))

autoplot(yellow_filter.mspct) +
  annotate(geom = "table_npc", npcx = 1, npcy = 0.8, label = ratios.ylw)

ratios.grn <- q_ratio(moss_green_filter.mspct, list(Blue("Sellaro"), Red("Smith10")), list(Green("Sellaro"), Far_red("Smith10")))
ratios.grn[ , -1] <- round(ratios.grn[ , -1], 2)
colnames(ratios.grn) <- gsub("\\[q:q\\]", "", colnames(ratios.grn))

autoplot(moss_green_filter.mspct) +
  annotate(geom = "table_npc", npcx = 1, npcy = 0.8, label = ratios.grn)

q_irrad(Aralab.3x100pc.spct, w.band = list(PAR(), Red("Sellaro"), Far_red("Sellaro")), scale.factor = 1e6)
q_irrad(Aralab.3x20pc.spct, w.band = list(PAR(), Red("Sellaro"), Far_red("Sellaro")), scale.factor = 1e6)
