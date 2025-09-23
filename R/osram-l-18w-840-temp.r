#' Spectral irradiance of white fluorescent tubes at different temperatures.
#'
#' Dataset of spectral irradiance from a set of four Osram L 18W/840 Lumilux
#' fluorescent tubes in an Aralab FitoClima 1200 growth chamber. The tubes are
#' located in the temperature controlled space.
#'
#' @details 
#' Absolute values are comparable among the different temperatures as
#' the location of the entrance optics remained unchanged and dimming at 100%.
#' The lamps and the cosine diffuser were located inside the growth chamber. The
#' Ocean Optics Maya 2000Pro array spectroradiometer as kept outside the chamber
#' at a room temperature of approximately 22 C. After each change in the
#' temperature controller set-point enough time was allowed after the
#' temperature had stabilized inside the chamber, for the output of the lamps to
#' also become stable.
#'
#' Instrument used: Ocean Optics Maya2000 Pro single-monochromator array
#' spectroradiometer with a Bentham cosine corrected input optics. A complex set
#' of corrections and calibration procedure used. The \code{source_spct} objects
#' have attributes with additional information on the measurement and data
#' processing. Measurements done by Pedro J. Aphalo. Data acquired and processed
#' using R packages 'ooacquire' and 'photobiology'.
#'
#' @docType data
#' @keywords datasets
#' @concept effect of temperature
#' 
#' @format 
#' \code{Osram_L_18W_840_temp.mspct} is a \code{"source_mspct"} object
#' containing a collection of \code{"source_spct"} objects, each with 1775 rows
#' (250 nm to 1050 nm, 0.42 to 0.48 nm step) and 2 variables.
#'   
#' The variables in the member spectra are as follows:
#' \itemize{
#'   \item w.length (nm)
#'   \item s.e.irrad (W m-2 nm-1)
#' }
#' 
#' @examples 
#' Osram_L_18W_840_temp.mspct[["20C"]]
#' 
"Osram_L_18W_840_temp.mspct"
