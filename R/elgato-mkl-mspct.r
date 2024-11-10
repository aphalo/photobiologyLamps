#' @title Spectra for an Mini Key Light LED video lamp
#'
#' @description A collection of lamp emission spectra for an Elgato Mini Key 
#'   Light white bi-colour LED lamp for video and photography.
#'
#' @details \code{elgato_mkl_cct.mspct} contains a collection of
#'   \code{"source_spct"} objects with spectral emission data for different
#'   dimming and colour temperature settings. The lamp was maintained at the
#'   same distance of 170 mm from the input optics of the spectrometer. Thus, the
#'   different spectra are comparable and provided expressed in calibrated
#'   spectral energy irradiance units.
#'   
#'   This light source uses LEDs on the edges of a diffusion panel giving very
#'   evenly distributed diffuse light. It is based Osram warm white light and 
#'   cool white LEDs. A built-in Lithium battery powers it. The mix of warm and
#'   cool light can be adjusted as well as the dimming.
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
#' Lamp manufacturer: \url{https://www.elgato.com/}.
#' 
#' Aphalo, Pedro J. (2022) Small fill/video LED lights revisited: A new 
#'   comparison. \url{https://www.photo-spectrum.info/pages/illumination/led-fill-lights-2.html}.
#' 
#' @format \code{elgato_mkl_cct.mspct} is a \code{"source_mspct"} object containing 
#'   a collection of 6 \code{"source_spct"} objects as members. Members are
#'   named.
#' 
#' @examples
#' 
#' summary(elgato_mkl_cct.mspct)
#' 
"elgato_mkl_cct.mspct"
