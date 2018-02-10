#' @details
#' This package contains emission spectra for different types of lamps other
#' than LEDs. Measured with an assortment of different instruments over more
#' than 20 years in our lab or by collaborators. Some of the lamp types are no
#' longer in production but the data are relevant for the interpretation of old
#' scientific publications. Data for lamps emitting in the UV and VIS regions of
#' the spectrum are represented in these data sets. In addition a set of
#' spectral emission for UVB lamps exposed to different ambient temperatures is
#' include.
#'
#' The package contains one collection of spectra for different lamps all of
#' them measured at air temperatures between 20 C and 25 C and a series of
#' vectors to be used as indexes to extract different subsets of spectra. These
#' spectral data are normalized to spectral energy irradiance equal one at
#' their maximum (strongest emission peak).
#'
#' The temperature response data is included as a separate collection of
#' spectra both as a \code{source_mspct} object and as a \code{source_spct}
#' object.
#'
#' @section Warning!:
#' None of the spectral data included in this package are based on supplier's
#' specifications and are only for information. The exact emission spectrum
#' depends to some extent on testing conditions, but more importantly among
#' individual lamps. It is not uncommon for suppliers to revise specifications
#' during the lifetime of a product type without changing the product
#' denomination. There can be also some variation from batch to batch. It is
#' also important to make sure that the type considered exactly matches.
#' Frequently variations of a lamp type, with type denomination differing in
#' a single letter or number, have quite different spectral characteristics. In
#' other words, the data provided here are not a substitute for actual
#' measurements of radiation emission and spectrum of the lamps actually used in
#' a given piece of scientific research. For less demanding situations the data
#' are in most cases reliable enough but perfect agreement with measurements on
#' other lamps of the same exact type should not be expected. This is specially
#' true for those data measured more than a few years ago when compared to lamps
#' being currently sold under the same type denomination.
#'
#' @import photobiology
#' 
#' @seealso Packages \code{\link[photobiology]{photobiology}} and 
#' \code{\link[ggspectra]{ggspectra}}.
#'
#' @examples
#' library(photobiologyLamps)
#' library(photobiologyWavebands)
#' # extract one spectrum
#' lamps.mspct$incandescent.60w
#' lamps.mspct[["incandescent.60w"]]
#' # using one spectrum in a calculation
#' q_ratio(lamps.mspct$incandescent.60w, Blue(), Green())
#' # extracting all the spectra measured with a given instrument
#' lamps.mspct[bentham_lamps]
#'
"_PACKAGE"
