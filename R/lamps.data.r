#' Spectral data for lamps
#'
#' Datasets containing the wavelengths at a 0.5 nm, 1.0 nm, or 2.0 nm interval and
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
#' Instrument used: LI-COR LI1800 scanning single monochromator spectroradiometer with
#' a cosine corrected input optics.
#' 
#' @docType data
#' @keywords datasets
#' @format A data frame with 551 rows and 2 variables
#' @name lamps.data
#' @aliases fl1.data, fl2.data, fl3.data, fl4.data, red1.data, sany.data, tlc1.data,
#' gr8d.data, gr8e.data, pls1.data
#' @example
#' plot(s.e.irrad~w.length, data=fl1.data, main=comment(fl1.data), type="l")
NULL
