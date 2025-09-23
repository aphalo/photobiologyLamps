#' Spectral data for Lamps of different colours
#' 
#' Names of members of the \code{\link{lamps.mspct}} collection of spectra
#' grouped by colour or wavelength band.
#' 
#' @details contain the names of the members of \code{lamps.mspct} with peaks of
#'   emission within the wavelength range corresponding to the light colours as
#'   defined by ISO standards. Vector \code{amber_lamps} is the union of
#'   \code{"yellow_lamps"} and \code{"orange_lamps"}. Vector \code{white_lamps}
#'   contains the names of spectra for lamps with broad or multiple peaks of
#'   emission in the visible range. Vectors \code{"uv_lamps"} and
#'   \code{"ir_lamps"} contain the names for lamps with peak emission at
#'   wavelengths < 400 nm and wavelengths > 700 nm, respectively.  One 
#'   additional vector, \code{lamp_colors} contains the names of
#'   the colors as used in the vectors.
#'
#'   These vectors can be used to extract subsets of spectra from
#'   \code{lamps.mspct}.
#' 
#' @docType data
#' @keywords datasets
#' @format A vector of character strings.
#' 
#' @concept lamps by color
#' @family indexing vectors of names
#' 
#' @examples
#' lamp_colors
#' 
#' uv_lamps
#' blue_lamps
#' red_lamps
#' white_lamps
#' 
#' # select data for lamps  emitting in the ultraviolet region
#' lamps.mspct[uv_lamps]
#' 
#' @seealso \code{\link{lamps.mspct}}
#' 
"lamp_colors"

#' @rdname lamp_colors
"uv_lamps"

#' @rdname lamp_colors
"purple_lamps"

#' @rdname lamp_colors
"blue_lamps"

#' @rdname lamp_colors
"green_lamps"

#' @rdname lamp_colors
"yellow_lamps"

#' @rdname lamp_colors
"orange_lamps"

#' @rdname lamp_colors
"red_lamps"

#' @rdname lamp_colors
"ir_lamps"

#' @rdname lamp_colors
"amber_lamps"

#' @rdname lamp_colors
"white_lamps"

