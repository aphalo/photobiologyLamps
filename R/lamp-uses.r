#' Spectral data for Lamps designed for specific uses
#' 
#' Names of members of the \code{\link{lamps.mspct}} collection of spectra
#' grouped by intended use.
#' 
#' @details These vectors can be used to extract subsets of spectra from
#'   \code{lamps.mspct}. The set of names is not exhaustive.  One additional
#'   vector, \code{lamp_uses} contains the naming given to intended specific
#'   lamp uses. Photography and video lamps are listed together in the vector
#'   \code{photography_lamps}.
#' 
#' @note In the case of LED-based lamps we include here only ready built
#'   commercially available lamps. In some cases assembled from multiple
#'   discrete LEDs, possible of mixed types and spectral output. For emission
#'   spectra for LEDs available as electronic components please see
#'   \code{\link[photobiologyLEDs]{photobiologyLEDs-package}}.
#' 
#' @docType data
#' @keywords datasets
#' @format A vector of character strings.
#' 
#' @concept lamps by intended use
#' @family indexing vectors of names
#' 
#' @examples 
#' plant_grow_lamps
#' photography_lamps
#' 
#' # select lamps for photography
#' lamps.mspct[photography_lamps]
#' 
#' @seealso \code{\link{lamps.mspct}}
#'
"lamp_uses"

#' @rdname lamp_uses
"photography_lamps"

#' @rdname lamp_uses
"plant_grow_lamps"

#' @rdname lamp_uses
"germicidal_lamps"

#' @rdname lamp_uses
"flashlights"
