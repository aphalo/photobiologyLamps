#' @title Spectra for an Amaran AL-M9 LED video light
#'
#' @description A collection of lamp emission spectra for an Aputure Amaran 
#'   pocket-sized daylight-balanced LED light type AL-M9.
#'
#' @details \code{amaran_m9.mspct}  contains a collection of
#'   \code{"source_spct"} objects with spectral emission data for six different
#'   dimming settings. The lamp was maintained at the same distance of 160 mm
#'   from the input optics of the spectrometer. In all cases the diffuser was
#'   kept in place. Thus, the different spectra are comparable and provided
#'   expressed in calibrated spectral energy irradiance units.
#'   
#'   This light source has 9 LEDs in a 3 \eqn{\times} 3 grid. The LEDs are
#'   in SMD packages. A built-in Lithium battery powers it. It comes with a
#'   detachable plastic diffuser
#'
#'   The variables in each member spectrum are as follows: \itemize{ \item
#'   w.length (nm) \item s.e.irrad (\eqn{\mathrm{W\,m^{-2}\,nm^{-1}}}) }
#'
#' @note Instrument used: Ocean Optics Maya2000 Pro single-monochromator array
#'   spectroradiometer with a Bentham cosine corrected input optics. A complex
#'   set of corrections and calibration procedure used. The \code{source_spct}
#'   objects have attributes with additional information on the measurement and
#'   data processing. Measurements done by Pedro J. Aphalo. Data acquired and
#'   processed using R packages 'ooacquire' and 'photobiology'.
#'
#' @docType data
#' @keywords datasets
#' 
#' @references
#' Lamp manufacturer: \url{https://aputure.com/}.
#' 
#' Aphalo, Pedro J. (2022) Small fill/video LED lights revisited: A new 
#'   comparison. \url{https://www.photo-spectrum.info/pages/illumination/led-fill-lights-2.html}.
#' 
#' @format \code{amaran_m9.mspct} is a \code{"source_mspct"} object containing 
#'   a collection of 6 \code{"source_spct"} objects as members. Members are
#'   named.
#' 
#' @examples
#' 
#' summary(amaran_m9.mspct)
#' 
"amaran_m9.mspct"
