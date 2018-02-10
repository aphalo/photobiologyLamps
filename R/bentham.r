#' Spectra acquired with Bentham spectrometer
#'
#' Spectra measured with a Bentham spectroradiometer. Datasets
#' contain wavelengths at a 0.5 nm interval and corresponding values for spectral
#' emittance from different lamps. As absolute values are not meaningful because
#' measuring distances are in most cases unknown data have been normalized to
#' one at the wavelength of maximum energy irradiance.
#'
#' @details \code{bentham_lamps} is a character vector with indexes to members of 
#'   \code{\link{lamps.mspct}}
#'
#' @note Instrument used: Bentham scanning double monochromator
#' spectroradiometer with a cosine corrected input optics. Recently calibrated
#' at STUK (Radiation Safety Authority Finland). Measurements done by Lasse
#' Ylianttila (STUK, Helsinki, Finland).
#'
#' @docType data
#' @keywords datasets
#'   
#' @examples
#' bentham_lamps
#' 
"bentham_lamps"
