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
#' vectors to be used as indexes to extract different subsets of spectra.
#' 
#' The temperature response data is included as a separate collection of
#' spectra both as a \code{source_mspct} object and as a \code{source_spct}
#' object.
#'
#' @import photobiology
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
#' lamps.mspct[bentham]
#'
"_PACKAGE"
