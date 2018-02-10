#' Spectral data for Lamps of different types
#' 
#' Names of datasets containing the wavelengths and tabulated values spectral emittance 
#' for the lamps of different types. 
#' 
#' @note In the case of LED-based lamps we include here only ready built commercially 
#' available lamps.
#' In some cases assembled from multiple descrete LEDs, possible of mixed types and 
#' spectral output. For emission spectra for LEDs available as electronic components
#' please see \code{\link[photobiologyLEDs]{photobiologyLEDs}}.
#' 
#' @docType data
#' @keywords datasets
#' @format A vector of character strings.
#' 
#' @aliases sodium_lamps mercury_lamps multimetal_lamps led_lamps
#' 
#' @examples 
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
"incandescent_lamps"
