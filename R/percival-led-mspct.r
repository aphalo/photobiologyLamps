#' @title Spectra for a Percival growth chamber
#'
#' @description A collection of lamp emission spectra for the white LEDs in a
#'   Percival plant-cultivation chamber at different nominal dimming settings.
#'
#' @details \code{Percival_LED_dim.mspct} contains a collection of
#'   \code{"source_spct"} objects with spectral emission data for different
#'   dimming settings. The diffuser was maintained at the same distance from the
#'   LEDs. Thus, the different spectra are comparable and provided expressed in
#'   calibrated spectral energy irradiance units.
#'   
#'   This growth chamber uses as light source a panel of LEDs above each shelf
#'   at a close distance from plants.
#'
#'   The variables in each member spectrum are as follows: \itemize{ \item
#'   w.length (nm) \item s.e.irrad (\eqn{\mathrm{W\,m^{-2}\,nm^{-1}}}) }
#'
#'   Instrument used: Ocean Optics Maya2000 Pro single-monochromator array
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
#' @references
#' Growth chamber manufacturer: \url{https://percival-scientific.com/}.
#' 
#' @format \code{Percival_LED_dim.mspct} is a \code{"source_mspct"} object
#'   containing a collection of 11 \code{"source_spct"} objects as members.
#'   Members are named.
#' 
#' @examples
#' 
#' summary(Percival_LED_dim.mspct)
#' 
"Percival_LED_dim.mspct"
