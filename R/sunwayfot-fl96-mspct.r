#' @title Spectra for a Sunwayfoto FL96 LED video light
#'
#' @description A collection of lamp emission spectra for a Sunwayfoto LED
#'   fill light type FL96.
#'
#' @details \code{sunwayfoto_fl96.mspct}  contains a collection of
#'   \code{"source_spct"} objects with spectral emission data for different
#'   dimming and colour temperature settings. The lamp was maintained at the
#'   same distance from the input optics of the spectrometer. Thus, the
#'   different spectra are comparable and provided expressed in calibrated
#'   spectral energy irradiance units.
#'   
#'   This light source has 96 white LEDs half emitting warm white light and half
#'   emitting cool white light. The LEDs are in SMD packages and are
#'   interspersed. A built-in Lithium battery powers it. The mix of warm and
#'   cool light can be adjusted as well as the overall power output.
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
#' Lamp manufacturer: \url{https://sunwayfoto.com/}.
#' 
#' Aphalo, Pedro J. (2022) Small fill/video LED lights revisited: A new 
#'   comparison. \url{https://www.photo-spectrum.info/pages/illumination/led-fill-lights-2.html}.
#' 
#' @format \code{sunwayfoto_fl96.mspct} is a \code{"source_mspct"} object containing 
#'   a collection of 6 \code{"source_spct"} objects as members. Members are
#'   named.
#' 
#' @examples
#' 
#' summary(sunwayfoto_fl96.mspct)
#' 
"sunwayfoto_fl96.mspct"
