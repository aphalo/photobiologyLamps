#' Spectral data for lamps
#' 
#' Datasets containing the wavelengths at a 0.5 nm, 1.0 nm, or 2.0 nm interval
#' and tabulated values spectral emittance for different lamps. Absolute values
#' are not meaningful as the measuring distance are variable, and in most cases
#' unknown.
#' 
#' The variables are as follows: 
#' \itemize{ 
#'   \item w.length (nm) 
#'   \item s.e.irrad (W m-2 nm-1) 
#'   \item s.q.irrad (mol m-2 s-1 nm-1)
#' }
#' 
#' @note Instrument used: LI-COR LI1800 scanning single monochromator
#' spectroradiometer with a cosine corrected input optics. Recently colibrated
#' with a LI-COR calibration lamp. Measurements done by Pedro J. Aphalo between
#' 1992 and 2001.
#' 
#' @docType data
#' @keywords datasets
#' @format A source.spct with 601 rows (300 nm to 900 nm, 1 nm stes) or or 501
#'   rows (300 nm to 800 nm, 1 nm step)
#' @name lamps.licor.data
#' @aliases incandescent.60w.spct osram.36w.25.spct philips.pls11w.827.spct
#' philips.tld36w.15.spct philips.tld36w.18.spct philips.tld36w.83.spct
#' philips.tld36w.865.spct philips.tld36w.89.spct philips.tld36w.92.spct
#' philips.tll36w.950.spct sylvania.215w.vho.spct
NULL