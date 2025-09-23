#' @title Spectra for a custom LED source in growth chamber
#'
#' @description A collection of LED emission spectra for the white LEDs in an
#'   Aralab plant-cultivation chamber at different nominal dimming settings.
#'
#' @details \code{Nichia_LED_RECOM_dim.mspct} contains a collection of
#'   \code{"source_spct"} objects with spectral emission data for different
#'   dimming settings. The entrance optics, a cosine diffuser, was kept at a
#'   distance of 24 cm from light source. Thus, the different spectra are
#'   comparable and provided expressed in calibrated spectral energy irradiance
#'   units.
#'   
#'   This growth chamber uses as light source a custom-built panel of Nichia
#'   Optisolis LEDs with CRI 97 rating based on LinearZ modules suplied by
#'   Lumitronix. Each LED module is driven by an RCD-48-.350 driver dimmed in
#'   constant current mode using a voltage supplied by the chamber controller.
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
#' Growth chamber manufacturer: \url{https://aralab.pt/en/aralab-environmental-chambers/}.
#' 
#' LED modules manufacturer: \url{https://www.lumitronix.com/en}.
#' 
#' SMD LEDs manufacturer: \url{https://www.nichia.co.jp/en/}.
#' 
#' LED drivers manufacturer: \url{https://recom-power.com/en/}.
#' #' 
#' @format \code{Nichia_LED_RECOM_dim.mspct} is a \code{"source_mspct"} object
#'   containing a collection of 11 \code{"source_spct"} objects as members.
#'   Members are named.
#' 
#' @examples
#' 
#' summary(Nichia_LED_RECOM_dim.mspct)
#' 
"Nichia_LED_RECOM_dim.mspct"
