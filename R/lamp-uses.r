#' Spectral data for Lamps designed for specific uses
#' 
#' Names of datasets containing the wavelengths and tabulated values spectral emittance 
#' for the lamps grouped by special use. 
#' 
#' @note In the case of LED-based lamps we include here only ready built commercially 
#' available lamps.
#' In some cases assembled from multiple descrete LEDs, possible of mixed types and 
#' spectral output. For emission spectra for LEDs available as electronic components
#' please see \code{\link[photobiologyLEDs]{photobiologyLEDs-package}}.
#' 
#' @aliases uses
#' 
#' @docType data
#' @keywords datasets
#' @format A vector of character strings.
#' 
#' @aliases plant_grow_lamps photography_lamps
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
"photography_lamps"

#' @rdname photography_lamps
"plant_grow_lamps"


#' @rdname photography_lamps
"germicidal_lamps"
