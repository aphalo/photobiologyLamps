#' @title Spectra acquired with LI-COR LI-1800
#'   
#' @description Lamp emission spectra measured with a LI-COR LI-1800 
#'   spectroradiometer. Member spectra containing the wavelengths at a 0.5 nm, 
#'   1.0 nm, or 2.0 nm interval and tabulated values of spectral irradiance for 
#'   different lamps. As absolute values are not meaningful because measuring 
#'   distances are in most cases unknown data have been normalized to one at the
#'   wavelength of maximum energy irradiance.
#'   
#' @details \code{licor} is a character vector with indexes to members of 
#'   \code{\link{lamps.mspct}} 
#'   
#' @note Instrument used: LI-COR LI1800 scanning single monochromator 
#'   spectroradiometer with a cosine corrected input optics. Recently calibrated
#'   with a LI-COR calibration lamp. Measurements done by Pedro J. Aphalo 
#'   between 1992 and 2001.
#'   
#' @docType data
#' @keywords datasets
#' @format A vector of character strings.
#'   
#' @examples
#' licor_lamps
#' 
"licor_lamps"
