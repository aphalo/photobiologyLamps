
# photobiologyLamps <img src="man/figures/logo.png" align="right" width="120" />

<!-- badges: start -->

[![CRAN
version](https://www.r-pkg.org/badges/version-last-release/photobiologyLamps)](https://cran.r-project.org/package=photobiologyLamps)
[![cran
checks](https://badges.cranchecks.info/worst/photobiologyLamps.svg)](https://cran.r-project.org/web/checks/check_results_photobiologyLamps.html)
[![R Universe
vwersion](https://aphalo.r-universe.dev/badges/photobiologyLEDs)](https://aphalo.r-universe.dev/photobiologyLEDs)
[![R-CMD-check](https://github.com/aphalo/photobiologyLamps/workflows/R-CMD-check/badge.svg)](https://github.com/aphalo/photobiologyLamps/actions)
[![Documentation](https://img.shields.io/badge/documentation-photobiologyLamps-informational.svg)](https://docs.r4photobiology.info/photobiologyLamps/)
[![doi](https://img.shields.io/badge/doi-10.32614/CRAN.package.photobiologyLamps-blue.svg)](https://doi.org/10.32614/CRAN.package.photobiologyLamps)
<!-- badges: end -->

Package ‘**photobiologyLamps**’ complements other packages in the [*R
for photobiology* suite](https://www.r4photobiology.info/). It contains
spectral emission data for LED, fluorescent, incandescent and other
lamps (`lamps.mspct`) in several collections of spectra.

Spectra in the package are contained in several collections, listed in
the table below.

| Collection | Description | n |
|----|----|---:|
| `lamps.mspct` | Spectra from imdividual lamps at full power and ambient temperature | 67 |
| `amaran_m9.mspct` | Aputure Amaran M9 LED video lamp dimming | 6 |
| `andoer_ir49.mspct` | Andoer IR LED photo/video lamp dimming | 2 |
| `elgato_klm_cct.mspct` | ElGato Key Light Mini LED video lamp colour temperature | 12 |
| `elgato_klm_dim.mspct` | ElGato Key Light Mini LED video lamp dimming | 6 |
| `ledsavers.mspct` | LedSavers 4 channel LED bulb channel mixing | 16 |
| `Nichia_LED_RECOM_dim.mspct` | Custom LED light source in Aralab plant-growth chamber, dimming | 8 |
| `Osram_L_18W_840_temp.mspct` | White fluorescent tubes in Aralab plant-growth chamber at temperatures 5 C to 35 C | 8 |
| `Percival_LED_dim.mspct` | White LEDs in Percival plant-growth chamber, dimming | 11 |
| `qp_uvb313_temp.mspct` and `qp_uvb313_temp.spct` | Q-Panel UVB-313 UV-B fluorescent tubes at temperatures -5 C to 35 C | 7 |
| `sunwayfoto_fl96.mspct` | Sunwayfoto FL96 LED fill light dimming and colour temperature | 7 |

Collections of spectra in package ‘photobiologyLamps’. **n** gives the
number of spectra. Collection `lamps.mspct` contains spectra for
different lamps, one spectrum for each lamp. Each of the other
collections contains multiple spectra measured under different
conditions or settings from one lamp or luminaire.

The data are for the most part original but also include some spectra
digitized from plots in manufacturers’ specifications. Data have been
acquired over many years, although when possible lamps have been
measured again after we acquired a spectrometer with improved wavelength
resolution. It is important for users to be aware that depending on the
optical wavelength resolution of the instruments used, spectra can look
quite different because of the broadening of peaks. This is most obvious
in lamps with narrow emission peaks like mercury vapours lamps. If you
make use of the data, please inspect the metadata and read the
documentation. The metadata is in most cases fairly complete, although
the distance from lamps to the entrance optics is frequently unknown.
For this reason some spectra have been normalized. The multiplier used
for normalization is part of the metadata, making it possible to recover
the original spectrum. The metadata includes, when available, a
descriptor of the spectrometer and the settings used for acquiring the
spectral data.

This package contains only data. Data are stored as collections of
spectra of class `source_mspct` from package ‘photobiology’, which is
the core of the [*R for photobiology*
suite](https://www.r4photobiology.info/). Spectra can be easily plotted
with functions and methods from package
[‘ggspectra’](https://docs.r4photobiology.info/ggspectra/). The spectra
can be used seamlesly with functions from package
[‘photobiology’](https://docs.r4photobiology.info/photobiology/).
However, class `source_mspct` is derived from `list` and class
`source_spct` is derived from `data.frame` making the data also usable
as is with base R functions.

Spectra for light emitting diodes (LEDs) and LED arrays (`leds.mspct`)
available as electronic components are included in the companion package
[‘photobioloyLEDs’](https://docs.r4photobiology.info/photobiologyLEDs/).

## Examples

``` r
library(ggspectra)
library(photobiologyLamps)
theme_set(theme_bw())
```

The package includes spectral data for several lamps.

``` r
length(lamps.mspct)
#> [1] 67
```

The members of the collections are named, and several vectors of names
are available indexing `lamps.mspct`, such as by manufacturer,

``` r
Philips_lamps
#>  [1] "Philips.CF.PLS.11W.927"       "Philips.FT.TL.40W.01.uv"     
#>  [3] "Philips.FT.TL.40W.12"         "Philips.FT.TL.40W.12.uv"     
#>  [5] "Philips.FT.TL5.35W.830.HE"    "Philips.FT.TLD.36W.15"       
#>  [7] "Philips.FT.TLD.36W.18"        "Philips.FT.TLD.36W.18.lores" 
#>  [9] "Philips.FT.TLD.36W.83"        "Philips.FT.TLD.36W.89"       
#> [11] "Philips.FT.TLD.36W.92"        "Philips.FT.TLD.36W.965"      
#> [13] "Philips.FT.TLD.36W.BLB.108"   "Philips.FT.TLL.36W.950"      
#> [15] "Philips.Inc.50W.spot.halogen" "Philips.LED.T8.10W.840"
```

or type of lamp.

``` r
incandescent_lamps
#> [1] "Generic.Inc.bulb.60W"         "Osram.Inc.20W"               
#> [3] "Philips.Inc.50W.spot.halogen"
```

Response to temperature of UV-B fluorescent tubes.

``` r
what_measured(qp_uvb313_temp.mspct)
#> # A tibble: 7 × 2
#>   spct.idx what.measured                              
#>   <fct>    <chr>                                      
#> 1 minus05C Fluorescent tube: Q-Panel UVB313 40W at -5C
#> 2 plus00C  Fluorescent tube: Q-Panel UVB313 40W at 0C 
#> 3 plus05C  Fluorescent tube: Q-Panel UVB313 40W at 5C 
#> 4 plus10C  Fluorescent tube: Q-Panel UVB313 40W at 10C
#> 5 plus20C  Fluorescent tube: Q-Panel UVB313 40W at 20C
#> 6 plus30C  Fluorescent tube: Q-Panel UVB313 40W at 30C
#> 7 plus35C  Fluorescent tube: Q-Panel UVB313 40W at 35C
```

Different settings of a four-channel LED bulb, with its own indexing
vectors of member names.

``` r
what_measured(ledsavers.mspct)
#> # A tibble: 16 × 2
#>    spct.idx      what.measured                                 
#>    <fct>         <chr>                                         
#>  1 B             LED lamp: LedSavers 7.5W four channels (WRGB).
#>  2 blue.green    LED lamp: LedSavers 7.5W four channels (WRGB).
#>  3 bluish.green  LED lamp: LedSavers 7.5W four channels (WRGB).
#>  4 cool.green    LED lamp: LedSavers 7.5W four channels (WRGB).
#>  5 dark.orange   LED lamp: LedSavers 7.5W four channels (WRGB).
#>  6 fuchsia       LED lamp: LedSavers 7.5W four channels (WRGB).
#>  7 G             LED lamp: LedSavers 7.5W four channels (WRGB).
#>  8 greenish.blue LED lamp: LedSavers 7.5W four channels (WRGB).
#>  9 orange        LED lamp: LedSavers 7.5W four channels (WRGB).
#> 10 pink          LED lamp: LedSavers 7.5W four channels (WRGB).
#> 11 purple        LED lamp: LedSavers 7.5W four channels (WRGB).
#> 12 R             LED lamp: LedSavers 7.5W four channels (WRGB).
#> 13 sand          LED lamp: LedSavers 7.5W four channels (WRGB).
#> 14 W             LED lamp: LedSavers 7.5W four channels (WRGB).
#> 15 warm.blue     LED lamp: LedSavers 7.5W four channels (WRGB).
#> 16 yellow        LED lamp: LedSavers 7.5W four channels (WRGB).
```

Different small video/photography LED lamps: `sunwayfoto_fl96.mspct`,
`elgato_klm_cct.mspct`, `elgato_klm_dim.mspct`, `amaran_m9.mspct` and
`andoer_ir49.mspct`. Each of these collections of spectra contains data
for one lamp with different dimming and/or colour temperature settings.

The first example below shows you how to plot the emission spectrum of
one of the lamps.

``` r
autoplot(lamps.mspct$Airam.CF.Spiraali.14W.3000K, geom = "spct",
         annotations = c("+", "title:what"))
```

![](man/figures/README-example1-1.png)<!-- -->

The second example shows how to access metadata.

``` r
what_measured(lamps.mspct$Airam.CF.Spiraali.14W.3000K)
#> [1] "Compact fluorescent lamp: Airam CF Spiraali 14W 3000K"
```

## Installation

Installation of the most recent stable version from CRAN:

``` r
install.packages("photobiologyLamps")
```

Installation of the current under development version from R-Universe
CRAN-like repository (source and binaries available):

``` r
install.packages('photobiologyLamps', 
                 repos = c('https://aphalo.r-universe.dev', 
                           'https://cloud.r-project.org'))
```

## Documentation

HTML documentation is available at
(<https://docs.r4photobiology.info/photobiologyLamps/>), including a
*User Guide*.

News on updates to the different packages of the ‘r4photobiology’ suite
are regularly posted at (<https://www.r4photobiology.info/>).

Two articles introduce the basic ideas behind the design of the suite
and describe its use: Aphalo P. J. (2015)
(<https://doi.org/10.19232/uv4pb.2015.1.14>) and Aphalo P. J. (2016)
(<https://doi.org/10.19232/uv4pb.2016.1.15>).

A book is under preparation, and the draft is currently available at
(<https://leanpub.com/r4photobiology/>).

A handbook written before the suite was developed contains useful
information on the quantification and manipulation of ultraviolet and
visible radiation: Aphalo, P. J., Albert, A., Björn, L. O., McLeod, A.
R., Robson, T. M., & Rosenqvist, E. (Eds.) (2012) Beyond the Visible: A
handbook of best practice in plant UV photobiology (1st ed., p. xxx +
174). Helsinki: University of Helsinki, Department of Biosciences,
Division of Plant Biology. ISBN 978-952-10-8363-1 (PDF),
978-952-10-8362-4 (paperback). PDF file available from
(<https://hdl.handle.net/10138/37558>).

## Contributing

Pull requests, bug reports, and feature requests are welcome at
(<https://github.com/aphalo/photobiologyLamps>).

## Citation

If you use this package to produce scientific or commercial
publications, please cite according to:

``` r
citation("photobiologyLamps")
#> To cite package ‘photobiologyLamps’ in publications use:
#> 
#>   Aphalo, Pedro J. (2015) The r4photobiology suite. UV4Plants Bulletin,
#>   2015:1, 21-29. DOI:10.19232/uv4pb.2015.1.14
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Article{,
#>     author = {Pedro J. Aphalo},
#>     title = {The r4photobiology suite},
#>     journal = {UV4Plants Bulletin},
#>     volume = {2015},
#>     number = {1},
#>     pages = {21-29},
#>     year = {2015},
#>     doi = {10.19232/uv4pb.2015.1.14},
#>   }
```

## License

© 2013-2025 Pedro J. Aphalo (<pedro.aphalo@helsinki.fi>). Released under
the GPL, version 2 or greater. This software carries no warranty of any
kind.
