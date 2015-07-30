library(photobiologyWavebands)

Bentham.raw.data <- read.csv("raw.data/Bentham/Bentham_01_and_12.csv")
names(Bentham.raw.data)

fl2.data$s.e.irrad <- with(fl2.data, as_energy(w.length, s.q.irrad * 1e-6))
with(fl2.data, photon_irradiance(w.length, s.e.irrad, PAR()))
with(fl2.data, photon_irradiance(w.length, s.q.irrad * 1e-6, PAR(), unit.in="photon"))

tl12.ac.s.e.irrad <- with(Bentham.raw.data, TL12 * calc_filter_multipliers(w.length, "acetate.115um.new"))
tl12.s.e.irrad <- with(Bentham.raw.data, tl12.ac.s.e.irrad / energy_irradiance(w.length, tl12.ac.s.e.irrad, GEN.G(300)) * 0.1)
tl12.w.length <- Bentham.raw.data$w.length

tl865.s.e.irrad <- with(fl2.data, s.e.irrad / photon_irradiance(w.length, s.e.irrad, PAR()) * 30.0e-6)
tl865.w.length <- fl2.data$w.length

sum.data <- photobiology:::sum_spectra(tl12.w.length, tl865.w.length, tl12.s.e.irrad, tl865.s.e.irrad)
plot(s.irrad.sum ~ w.length, data=sum.data, type="l")
plot(s.e.irrad ~ w.length, data=fl2.data, type="l")
plot(TL12 ~ w.length, data=Bentham.raw.data, type="l")
lines(tl12.ac.s.e.irrad ~ Bentham.raw.data$w.length, col="red")

plot(tl12.s.e.irrad ~ tl12.w.length, type="l")
plot(tl865.s.e.irrad ~ tl865.w.length, type="l")

with(sum.data, plot(as_quantum_mol(w.length, s.irrad.sum) ~ w.length, type="l"))

with(sum.data, photon_ratio(w.length, s.irrad.sum, UVB(), UVA()))
with(sum.data, photon_ratio(w.length, s.irrad.sum, UVB(), PAR()))
with(sum.data, photon_irradiance(w.length, s.irrad.sum, PAR()))
with(sum.data, energy_irradiance(w.length, s.irrad.sum, GEN.G()))

