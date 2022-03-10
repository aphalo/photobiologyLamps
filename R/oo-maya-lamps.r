#' @title Spectra acquired with Ocean Optics Maya2000 Pro
#'
#' @description Spectra measured with a Ocean Optics Maya2000 Pro spectroradiometer. Datasets
#' contain wavelengths at variable intervals and corresponding values for spectral
#' emittance from different lamps. Absolute values are not meaningful because
#' data have been normalized to one at the wavelength of maximum energy irradiance.
#'
#' @details \code{oo_maya_lamps} is a character vector with indexes to members of 
#'   \code{\link{lamps.mspct}}
#'
#' @note Instrument used: Ocean Optics Maya2000 Pro single-monochromator array
#'   spectroradiometer with a Bentham cosine corrected input optics. A complex
#'   set of corrections and calibration procedure used. Raw spectral data
#'   processed with R package MayaCalc. The \code{source_spct} object contains a
#'   comment with additional information on the measurement and data processing.
#'   Measurements done by Pedro J. Aphalo.
#'
#' @docType data
#' @keywords datasets
#' @format A vector of character strings.
#'
#' @examples
#' oo_maya_lamps
#' 
"oo_maya_lamps"
