#' Spectral data for Lamps of different colors
#' 
#' Names of datasets containing the wavelengths and tabulated values spectral emittance 
#' for the lamps of different types from various suppliers. 
#' 
#' @aliases colors
#' 
#' @docType data
#' @keywords datasets
#' @format A vector of character strings.
#' 
#' @examples 
#' uv_lamps
#' blue_lamps
#' red_lamps
#' amber_lamps
#' white_lamps
#' 
#' # select lamps emitting in the amber, yellow, orange region
#' lamps.mspct[red_lamps]
#' 
#' @seealso \code{\link{lamps.mspct}}
#' 
"uv_lamps"

#' @rdname uv_lamps
"amber_lamps"

#' @rdname uv_lamps
"blue_lamps"

#' @rdname uv_lamps
"red_lamps"

#' @rdname uv_lamps
"white_lamps"

