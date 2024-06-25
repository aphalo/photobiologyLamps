library(photobiology)
library(photobiologyWavebands)
library(photobiologyInOut)
library(photobiologyLEDs)
library(ggspectra)
library(stringr)
library(poorman)

files <- list.files("./LEDs-2022-09-10", pattern = "*.Rda", full.names = TRUE)

for (f in files) load(f)

photo_lamps.mpsct <- collect2mspct()

spectra <- names(photo_lamps.mpsct)

irrads <- e_irrad(photo_lamps.mpsct)
irrads[["Brand"]] <- str_to_title(str_split(irrads[["spct.idx"]], "\\.", simplify = TRUE)[ , 1])
models <- c(Amaran = "AL-M9", Sunwayfoto = "FL96", Elgato = "Key Light Mini", Andoer = "IR49S")
irrads[["Model"]] <- models[irrads[["Brand"]]]
irrads[["Name"]] <- paste(irrads[["Brand"]], irrads[["Model"]])
irrads[["CCT.nominal"]] <-
  ifelse(grepl("2900K", irrads[["spct.idx"]]), 2900,
               ifelse(grepl("3000K", irrads[["spct.idx"]]), 3000,
                            ifelse(grepl("4000K", irrads[["spct.idx"]]), 4000,
                                         ifelse(grepl("5500K|amaran", irrads[["spct.idx"]]), 5500,
                                                      ifelse(grepl("6500K", irrads[["spct.idx"]]), 6500,
                                                                   ifelse(grepl("7000K", irrads[["spct.idx"]]), 7000, NA_real_)
                                                             )
                                                )
                                   )
                      )
  )

irrads[["dimming"]] <-
  ifelse(grepl("100pc|max", irrads[["spct.idx"]]), 100,
         ifelse(grepl("50pc", irrads[["spct.idx"]]), 50,
                ifelse(grepl("25pc", irrads[["spct.idx"]]), 25,
                       ifelse(grepl("12pc", irrads[["spct.idx"]]), 12,
                              ifelse(grepl("6pc", irrads[["spct.idx"]]), 6,
                                     ifelse(grepl("5pc", irrads[["spct.idx"]]), 5,
                                            ifelse(grepl("3pc", irrads[["spct.idx"]]), 3, NA_real_)
                              )
                       )
                )
         )
  )
)
irrads <-
  full_join(irrads,
          msdply(photo_lamps.mpsct, spct_CCT, strict = FALSE))

irrads <-
  full_join(irrads,
            msdply(photo_lamps.mpsct, q_irrad, scale.factor = 1e6))

irrads <-
  full_join(irrads,
            msdply(photo_lamps.mpsct, illuminance))
irrads <-
  full_join(irrads,
            msdply(photo_lamps.mpsct, spct_CRI, tol = 1e-2))

names(irrads) <- gsub("spct_|_V1", "", names(irrads))

irrads_photo_leds1 <- irrads
save(irrads_photo_leds1, file = "./LEDs-2022-09-30/irrads-photo-leds1.Rda")

irrads %>%
  group_by(Brand) %>%
  summarize(E_Max = max(E_Total)) -> max.irrads

irrads <- full_join(irrads, max.irrads) %>%
  mutate(E_pc = E_Total / E_Max * 100)

subset(irrads, grepl("Sunwayfoto", spct.idx) & grepl("100pc", spct.idx))

E_vs_CCT.fig <-
  ggplot(subset(irrads,
                Brand %in% c("Sunwayfoto", "Elgato", "Amaran") &
                  grepl("100pc|max", spct.idx)),
         aes(CCT, E_Total, colour = Name)) +
  geom_point() +
  geom_line(linetype = "solid") +
  expand_limits(y = 0) +
  labs(x = "CCT, measured (K)", y = expression("Irradiance at 160 mm "*(W~m^{-2}))) +
  theme_bw(14)

CCT_meas_vs_nominal.fig <-
  ggplot(subset(irrads,
                Brand %in% c("Sunwayfoto", "Elgato", "Amaran") &
                  grepl("100pc|max", spct.idx)),
         aes(CCT.nominal, CCT, colour = Name)) +
  geom_abline(linetype = "dashed") +
  geom_point() +
  geom_line() +
  labs(x = "CCT nominal (K)", y = "CCT measured (K)") +
  expand_limits(x = c(2800, 7000), y = c(2800, 7000)) +
  coord_equal() +
  theme_bw(14)

CRI_vs_CCT.fig <-
  ggplot(subset(irrads,
                Brand %in% c("Sunwayfoto", "Elgato", "Amaran") &
                  grepl("100pc|max", spct.idx)),
         aes(CCT, CRI, colour = Name)) +
  geom_hline(yintercept = c(94, 96, 95), linetype = "dashed", colour = c("green", "blue", "red")) +
  geom_point() +
  geom_line() +
  geom_abline(linetype = "dotted") +
  labs(x = "CCT measured (K)",
       y = "CRI measured (%)") +
  expand_limits(x = 6000, y = c(90, 100)) +
  theme_bw(14)

dimming_Epc.fig <-
  ggplot(subset(irrads,
                Brand %in% c("Sunwayfoto", "Elgato") &
                  grepl("4000K", spct.idx)),
         aes(dimming, E_pc, colour = Name)) +
  geom_abline(linetype = "dashed") +
  geom_point(size = 3) +
  geom_line(size = 1) +
  labs(x = "Dimming, setting (%)", y = "Dimming, measured (%)") +
  scale_x_log10(limits = c(3, 100)) +
  scale_y_log10(limits = c(3, 100)) +
  coord_equal() +
  theme_bw(14) +
  theme(panel.grid.minor = element_blank())

dimming_CCT.fig <-
  ggplot(subset(irrads,
                Brand %in% c("Sunwayfoto", "Elgato") &
                  grepl("4000K", spct.idx)),
         aes(E_pc, CCT, colour = Name)) +
  geom_abline(linetype = "dashed") +
  geom_point(size = 3) +
  geom_line(size = 1) +
  expand_limits(y = c(3300, 4600)) +
  labs(x = "Dimming, measured (%)", y = "CCT, measured (K)") +
  theme_bw(14)

dimming_CRI.fig <-
  ggplot(subset(irrads,
                Brand %in% c("Sunwayfoto", "Elgato") &
                  grepl("4000K", spct.idx)),
         aes(E_pc, CRI, colour = Name)) +
  geom_point(size = 3) +
  geom_line(size = 1) +
  expand_limits(y = c(NA, 96)) +
  labs(x = "Dimming, measured (%)", y = "CRI, measured (%)") +
  theme_bw()

svg("./LEDs-2022-09-10/E_vs_CCT.svg", width = 7, height = 3.5)
print(E_vs_CCT.fig)
dev.off()

svg("./LEDs-2022-09-10/CCT_meas_vs_nominal.svg", width = 7, height = 3.5)
print(CCT_meas_vs_nominal.fig)
dev.off()

svg("./LEDs-2022-09-10/CRI_vs_CCT.svg", width = 7, height = 3.5)
print(CRI_vs_CCT.fig)
dev.off()

svg("./LEDs-2022-09-10/dimming_Epc.svg", width = 7, height = 3.5)
print(dimming_Epc.fig)
dev.off()

svg("./LEDs-2022-09-10/dimming_CCT.svg", width = 7, height = 3.5)
print(dimming_CCT.fig)
dev.off()

svg("./LEDs-2022-09-10/dimming_CRI.svg", width = 7, height = 3.5)
print(dimming_CRI.fig)
dev.off()

spct_CRI(leds.mspct$Nichia_NF2W757GT_F1_sm505_Rfc00)
spct_CCT(leds.mspct$Nichia_NF2W757GT_F1_sm505_Rfc00)

spct_CRI(leds.mspct$SeoulSemicon_S4SM_1564509736_0B500H3S_00001)
spct_CCT(leds.mspct$SeoulSemicon_S4SM_1564509736_0B500H3S_00001)
