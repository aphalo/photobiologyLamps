#' @title Spectra for an Andoer IR49 LED video lamp
#'
#' @description A collection of two light emission spectra for a small infra-red
#'   emitting LED-based light source for video and photography. The lamp is
#'   advertised as "Andoer IR49S Mini IR Night Vision Light" 
#'
#' @details \code{andoer_ir49.mspct} contains a collection of two
#'   \code{"source_spct"} objects with spectral emission data for the lamp at
#'   full and minimum power. Dimming setting is stepless. The lamp was
#'   maintained at the same distance from the input optics so the two spectra
#'   are comparable and provided expressed in calibrated spectral energy
#'   irradiance units.
#'   
#'   This light source has 49 LEDs in a 7 \eqn{\times} 7 grid. The LEDs are
#'   in through-hole packages. A built-in Lithium battery powers it.
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
#' @concept light dimming
#' 
#' @format \code{andoer_ir49.mspct} is a \code{"source_mspct"} object containing 
#'   a collection of two \code{"source_spct"} objects as members. Members are
#'   named.
#'   
#' @examples
#' 
#' summary(andoer_ir49.mspct)
#' 
"andoer_ir49.mspct"
