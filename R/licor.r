#' @title Spectra aqcuired with LI-COR LI-1800
#'   
#' @description A collection of spectra measured with a LI-COR LI-1800
#'   spectroradiometer. Member spectra containing the wavelengths at a 0.5 nm,
#'   1.0 nm, or 2.0 nm interval and tabulated values of spectral irradiance for
#'   different lamps. As absolute values are not meaningful because measuring
#'   distances are in most cases unknown data have been normalized to one at the
#'   wavelength of maximum energy irradiance.
#'   
#' @details The \code{"source_mspct"} object contains \code{"source_spct"}
#' objects incandescent.60w osram.36w.25 philips.pls11w.827 philips.tld36w.15 
#' philips.tld36w.18 philips.tld36w.83 philips.tld36w.865  philips.tld36w.89 
#' philips.tld36w.92  philips.tll36w.950 sylvania.215w.vho
#' 
#' The variables in each member spectrum are as follows: \itemize{ \item
#' w.length (nm) \item s.e.irrad (relative energy based units) }
#' 
#' @note Instrument used: LI-COR LI1800 scanning single monochromator 
#'   spectroradiometer with a cosine corrected input optics. Recently calibrated
#'   with a LI-COR calibration lamp. Measurements done by Pedro J. Aphalo
#'   between 1992 and 2001.
#'   
#' @docType data
#' @keywords datasets
#' @format A \code{"source_mspct"} object containing a collection of
#'   \code{"source_spct"} objects, each with 601 rows (300 nm to 900 nm, 1 nm
#'   stes) or or 501 rows (300 nm to 800 nm, 1 nm step) or 401 rows (and 2
#'   variables).
#'   
#' @examples
#' licor.mspct$incandescent.60w
#' 
#' @aliases incandescent.60w osram.36w.25 philips.pls11w.827 philips.tld36w.15
#' philips.tld36w.18 philips.tld36w.83 philips.tld36w.865 philips.tld36w.89
#' philips.tld36w.92 philips.tll36w.950 sylvania.215w.vho
"licor.mspct"