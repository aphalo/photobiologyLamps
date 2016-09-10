#' @title Spectra aqcuired with Ocean Optics Maya2000 Pro
#' 
#' @description Dataset containing the wavelengths and tabulated values spectral
#'   emittance for a germicidal lamp. This lamps are low pressure mercury
#'   discharge lamps lacking a phosphor in their envelope, and clearly showing
#'   the emission lines of mercury. They are used for desinfection. Absolute
#'   spectral irradiance values are not meaningful as the distance was not
#'   measured. In this case the measurement was on the working surface of a
#'   laboratory hood, using its built-in lamp.
#' 
#' @details The \code{"source_mspct"} object contains one \code{"source_spct"}
#' object germicidal
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
#' @format A \code{"source_mspct"} object containing one \code{"source.spct"}
#'  object with 1425 rows (250 nm to 900 nm, at steps < 1 nm)
#' 
#' @aliases germicidal
"oo_maya.mspct"
