#' @title Spectral irradiance for diverse lamps
#'
#' @description A collection of lamp emission spectra measured with different
#'   spectroradiometers.
#'
#' @details The \code{"source_mspct"} object contains \code{"source_spct"}
#'   objects with spectral emission data. These classes are defined in
#'   package \code{\link[photobiology]{photobiology-package}} together with
#'   corresponding methods and functions.
#'
#'   The variables in each member spectrum are as follows: \itemize{ \item
#'   w.length (nm) \item s.e.irrad (relative energy based units) }
#'
#' @note Please see the help corresponding to each instrument for details.
#'
#' @seealso \code{\link{bentham_lamps}}, \code{\link{licor_lamps}}, \code{\link{macam_lamps}},
#'   \code{\link{oo_maya_lamps}} for information on the spectroradiometers, and
#'   \code{\link[photobiologyLEDs]{photobiologyLEDs-package}} for spectra for LEDs available
#'   as electronic components.
#'
#' @docType data
#' @keywords datasets
#' @format A \code{"source_mspct"} object containing several
#'   \code{"source_spct"}.
#'
#' @examples
#' uv_lamps
#' union(qpanel_lamps, uv_lamps)
#' lamps.mspct[union(philips_lamps, red_lamps)]
#' 
#' lamps.mspct$qpanel.uvb313
#' 
"lamps.mspct"
