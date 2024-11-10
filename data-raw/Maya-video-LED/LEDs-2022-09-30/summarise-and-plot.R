library(photobiology)
library(photobiologyWavebands)
library(photobiologyInOut)
library(photobiologyLEDs)
library(ggspectra)
library(stringr)
library(poorman)

files <- list.files("./LEDs-2022-09-30", pattern = "collection.*.Rda", full.names = TRUE)

for (f in files) load(f)

elgato_170mm.mspct <- collection.Elgato.170mm.irrad.mspct[grepl("elgato\\.max", names(collection.Elgato.170mm.irrad.mspct))]

spectra <- names(elgato_170mm.mspct)
elgato_170mm.mspct <- elgato_170mm.mspct[-11] # duplicate spct.idx

irrads <- e_irrad(elgato_170mm.mspct)

irrads <-
  inner_join(irrads,
            msdply(elgato_170mm.mspct, q_irrad, scale.factor = 1e6))

irrads <-
  inner_join(irrads,
             msdply(elgato_170mm.mspct, illuminance))

irrads <-
  full_join(irrads,
            msdply(elgato_170mm.mspct, spct_CCT, strict = FALSE))

irrads <-
  full_join(irrads,
            msdply(elgato_170mm.mspct, spct_CRI, tol = 1e-2))

colnames(irrads) <- gsub("_V1|spct_", "", colnames(irrads))

irrads["CCT.nominal"] <- as.integer(gsub("elgato\\.max\\.|K\\.spct|\\.spct", "", irrads[["spct.idx"]]))

colnames(irrads)

irrads$Brand <- "Elgato"
irrads$Model <- "Key Light Mini"
irrads$Name <- "Elgato Key Light Mini"
irrads$dimming <- 100
irrads$day <- "A"

# adjust measurements from 2021-09-30 from 170mm to 160 mm
irrads$E_Total <- irrads$E_Total * 170^2 / 162^2
irrads$Q_Total <- irrads$Q_Total * 170^2 / 162^2

load("./LEDs-2022-09-30/irrads-photo-leds1.Rda")
irrads_photo_leds1$day <- "B"

irrads_160mm.tb <- rbind(irrads, irrads_photo_leds1)
irrads_160mm_max.tb <- subset(irrads_160mm.tb, dimming == 100 & !is.na(CCT.nominal))


E_vs_CCT.fig <-
  ggplot(irrads_160mm_max.tb,
         aes(CCT, E_Total, colour = Name)) +
  geom_line(size = 1) +
  geom_point(aes(shape = day), size = 3) +
  expand_limits(y = 0) +
  labs(x = "CCT, measured (K)", y = expression("Irradiance at 160 mm  "*(W~m^{-2}))) +
  theme_bw(14)
E_vs_CCT.fig

Q_vs_CCT.fig <-
  ggplot(irrads_160mm_max.tb,
         aes(CCT, Q_Total, colour = Name)) +
  geom_line(size = 1) +
  geom_point(aes(shape = day), size = 3) +
  expand_limits(y = 0) +
  labs(x = "CCT, measured (K)", y = expression("Photon irradiance at 160 mm  "*(mu*mol~m^{-2}~s^{-1}))) +
  theme_bw(14)
Q_vs_CCT.fig

Ev_vs_CCT.fig <-
  ggplot(irrads_160mm_max.tb,
         aes(CCT, `illuminance_Ev[lx]` / max(`illuminance_Ev[lx]`), colour = Name)) +
  geom_line(size = 1) +
  geom_point(aes(shape = day), size = 3) +
  expand_limits(y = 0) +
  labs(x = "CCT, measured (K)", y = "Illuminance at 160 mm (rel. lx)") +
  theme_bw(14)
Ev_vs_CCT.fig

CCT_meas_vs_nominal.fig <-
  ggplot(irrads_160mm_max.tb,
         aes(CCT.nominal, CCT, colour = Name)) +
  geom_abline(linetype = "dashed") +
  geom_line(size = 1) +
  geom_point(aes(shape = day), size = 3) +
  labs(x = "CCT nominal (K)", y = "CCT measured (K)") +
  expand_limits(x = c(2800, 7000), y = c(2800, 7000)) +
  coord_equal() +
  theme_bw(14)
CCT_meas_vs_nominal.fig

CRI_vs_CCT.fig <-
  ggplot(irrads_160mm_max.tb,
         aes(CCT, CRI, colour = Name)) +
  geom_hline(yintercept = c(94, 96, 95), linetype = "dashed", colour = c("green", "blue", "red"), size = 0.5) +
  geom_line(size = 1) +
  geom_point(aes(shape = day), size = 3) +
  labs(x = "CCT measured (K)",
       y = "CRI measured (%)") +
  expand_limits(x = 6000, y = c(85, 100)) +
  theme_bw(14)
CRI_vs_CCT.fig

svg("./LEDs-2022-09-30/E_vs_CCT.svg", width = 7, height = 3.5)
print(E_vs_CCT.fig)
dev.off()

svg("./LEDs-2022-09-30/Q_vs_CCT.svg", width = 7, height = 3.5)
print(Q_vs_CCT.fig)
dev.off()

svg("./LEDs-2022-09-30/Ev_vs_CCT.svg", width = 7, height = 3.5)
print(Ev_vs_CCT.fig)
dev.off()

svg("./LEDs-2022-09-30/CCT_meas_vs_nominal.svg", width = 7, height = 3.5)
print(CCT_meas_vs_nominal.fig)
dev.off()

svg("./LEDs-2022-09-30/CRI_vs_CCT.svg", width = 7, height = 3.5)
print(CRI_vs_CCT.fig)
dev.off()


spct_CRI(leds.mspct$Nichia_NF2W757GT_F1_sm505_Rfc00)
spct_CCT(leds.mspct$Nichia_NF2W757GT_F1_sm505_Rfc00)

spct_CRI(leds.mspct$SeoulSemicon_S4SM_1564509736_0B500H3S_00001)
spct_CCT(leds.mspct$SeoulSemicon_S4SM_1564509736_0B500H3S_00001)
