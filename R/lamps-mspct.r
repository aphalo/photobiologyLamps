#' @title Spectral irradiance for diverse lamps
#'
#' @description A collection of lamp emission spectra measured with different
#'   spectroradiometers.
#'
#' @details The \code{"source_mspct"} object contains \code{"source_spct"}
#'   objects with spectral emission data.
#'
#'   The variables in each member spectrum are as follows: \itemize{ \item
#'   w.length (nm) \item s.e.irrad (relative energy based units) }
#'
#' @note Please see the help corresponding to each instrument for details.
#'
#' @seealso \code{\link{bentham}}, \code{\link{licor}}, \code{\link{macam}},
#'   \code{\link{oo_maya}}
#'
#' @docType data
#' @keywords datasets
#' @format A \code{"source_mspct"} object containing several
#'   \code{"source_spct"}.
#'
#' @examples
#' lamps.mspct$qpanel.uvb313
"lamps.mspct"
