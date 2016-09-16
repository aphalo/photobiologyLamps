#' @title Spectra acquired with Ocean Optics Maya2000 Pro
#'
#' @description Dataset containing the wavelengths and tabulated values spectral
#'   emittance for a germicidal lamp. This lamps are low pressure mercury
#'   discharge lamps lacking a phosphor in their envelope, and clearly showing
#'   the emission lines of mercury. They are used for disinfection. Absolute
#'   spectral irradiance values are not meaningful as the distance was not
#'   measured. In this case the measurement was on the working surface of a
#'   laboratory hood, using its built-in lamp.
#'
#' @details \code{oo_maaya} is a character vector with indexes to members of 
#'   \code{\link{lamps.mspct}}: germicidal
#'
#' The variables in each member spectrum are as follows: \itemize{ \item
#' w.length (nm) \item s.e.irrad (relative energy based units) }
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
#' lamps.mspct[oo_maya]
#' lamps.mspct[["germicidal"]]
#' lamps.mspct$germicidal
#'
#' @aliases germicidal
"oo_maya"
