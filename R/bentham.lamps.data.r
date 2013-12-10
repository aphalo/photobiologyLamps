#' Spectral data for lamps
#'
#' Datasets containing the wavelengths at a 0.5 nm interval and
#' tabulated values spectral emittance for different lamps. Absolute values are
#' not meaningful as the measuring distance are variable, and in most cases unknown.
#' 
#' The variables are as follows:
#' \itemize{
#'   \item w.length (nm)  
#'   \item s.e.irrad (W m-2 nm-1)
#'   \item s.q.irrad (mol m-2 s-1 nm-1) 
#' }
#' 
#' @note
#' Instrument used: Bentham scanning double monochromator spectroradiometer with
#' a cosine corrected input optics. Recently colibrated in an optical bench.
#' Measurements done by Lasse Ylianttila 2011.
#' 
#' @docType data
#' @keywords datasets
#' @format A data frame with 301 rows (250 nm to 400 nm, 0.5 nm stes) 3 variables
#' @name lamps.bentham.data
#' @aliases 
#'  philips.tl01.dat philips.tl12.dat 
NULL