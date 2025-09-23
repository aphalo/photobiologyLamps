#' Spectral data for Lamps of different types
#' 
#' Names of members of the \code{\link{lamps.mspct}} collection of spectra
#' grouped by the technology their are based on, i.e., type.
#' 
#' @details
#'   These vectors can be used to extract subsets of spectra from
#'   \code{lamps.mspct}.  One additional vector, \code{lamp_types} contains the 
#'   names used for types of lamps in the names and vectors.
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
#' @concept lamps by technology
#' @family indexing vectors of names
#' 
#' @examples
#' lamp_types
#' 
#' sodium_lamps
#' multimetal_lamps
#' mercury_lamps
#' led_lamps
#' 
#' # select lamps emitting in the amber, yellow, orange region
#' lamps.mspct[sodium_lamps]
#' 
#' @seealso \code{\link{lamps.mspct}}
#'
"lamp_types"

#' @rdname lamp_types
"incandescent_lamps"

#' @rdname lamp_types
"fluorescent_lamps"

#' @rdname lamp_types
"led_lamps"

#' @rdname lamp_types
"mercury_lamps"

#' @rdname lamp_types
"multimetal_lamps"

#' @rdname lamp_types
"sodium_lamps"

#' @rdname lamp_types
"xenon_lamps"
