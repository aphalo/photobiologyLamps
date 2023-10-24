
# photobiologyLamps <img src="man/figures/logo.png" align="right" width="120" />

<!-- badges: start -->

[![CRAN
version](https://www.r-pkg.org/badges/version-last-release/photobiologyLamps)](https://cran.r-project.org/package=photobiologyLamps)
[![cran
checks](https://badges.cranchecks.info/worst/photobiologyLamps.svg)](https://cran.r-project.org/web/checks/check_results_photobiologyLamps.html)
[![R-CMD-check](https://github.com/aphalo/photobiologyLamps/workflows/R-CMD-check/badge.svg)](https://github.com/aphalo/photobiologyLamps/actions)
<!-- badges: end -->

Package ‘**photobiologyLamps**’ complements other packages in the [*R
for photobiology* suite](https://www.r4photobiology.info/). It contains
spectral emission data for LED, fluorescent, incandescent and other
lamps (`lamps.mspct`). Spectra for light emitting diodes (LEDs) and LED
arrays (`leds.mspct`) available as electronic components are included in
package
[‘photobioloyLEDs’](https://docs.r4photobiology.info/photobiologyLEDs/).
Package ‘**photobiologyLamps**’ also includes spectra from UV-B
fluorescent tubes operating at different temperatures
(`qp_uvb313_temp.mspct` and `qp_uvb313_temp.spct`) and for a
four-channel LED bulb supporting channel mixing (`ledsavers.mspct`).

The data are for the most part original but also include some spectra
digitized from plots in manufacturers’ specifications. Data have been
acquired over many years, although when possible lamps have been
measured again after we got a spectrometer with improved wavelength
resolution. It is important for users to be aware that depending on the
optical wavelength resolution of the instruments used spectra can look
quite different because of the broadening of peaks. This is most obvious
in lamps with narrow emission peaks like mercury vapours lamps. If you
make use of the data, please inspect the metadata and read the
documentation. The metadata is in most cases fairly complete, although
the distance from lamps to the entrance optics is frequently unknown.
For this reason spectra have been normalized. The multiplier used for
normalization is part of the metadata, making it possible to recover the
original spectrum. The metadata includes, when available, a descriptor
of the spectrometer and the settings used for acqiring the spectral
data.

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

## Examples

``` r
library(ggspectra)
library(photobiologyLamps)
```

The package includes spectral data for several lamps.

``` r
length(lamps.mspct)
#> [1] 62
```

``` r
length(qp_uvb313_temp.mspct)
#> [1] 7
```

``` r
length(ledsavers.mspct)
#> [1] 16
```

The first example below shows you how to plot the emission spectrum of
one of the lamps.

``` r
autoplot(lamps.mspct$Airam.CF.Spiraali.14W.3000K,
         annotations = c("+", "title:what"))
```

![](man/figures/README-example1-1.png)<!-- -->

The second example shows how to access metadata.

``` r
what_measured(lamps.mspct$Airam.CF.Spiraali.14W.3000K)
#> [1] "Compact fluorescent lamp: Airam CF Spiraali 14W 3000K"
```

The members of the collection are named, and several vectors of names
are available, such as by manufacturer,

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

Temperature response data for emision from UV-B fluorescent tubes is
provided as a separate collection of spectra.

``` r
names(qp_uvb313_temp.mspct)
#> [1] "minus05C" "plus00C"  "plus05C"  "plus10C"  "plus20C"  "plus30C"  "plus35C"
```

## Installation

Installation of the most recent stable version from CRAN:

``` r
install.packages("photobiologyLamps")
```

Installation of the current unstable version from GitHub:

``` r
# install.packages("devtools")
remotes::install_github("aphalo/photobiologylamps")
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
(<https://bitbucket.org/aphalo/photobiology>).

## Citation

If you use this package to produce scientific or commercial
publications, please cite according to:

``` r
citation("photobiologyLamps")
#> To cite package 'photobiologyLamps' in publications, please use:
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

© 2013-2023 Pedro J. Aphalo (<pedro.aphalo@helsinki.fi>). Released under
the GPL, version 2 or greater. This software carries no warranty of any
kind.
