#' Spectral irradiance data for UV lamps.
#'
#' Dataset of spectral irradiance from a set of two Q-Panel UVB-313 and UVA-340 40W fluorescent tubes, and
#' for Philips TL12 40W.
#'  
#' The variables are as follows:
#' \itemize{
#'   \item w.length (nm)  
#'   \item s.e.irrad (W m-2 nm-1)
#'   \item s.q.irrad (mol m-2 s-1 nm-1)
#' }
#' 
#' @note
#' Instrument used: Macam SR-9010-PC scanning double monochromator spectroradiometer with
#' a cosine corrected input optics. Recently calibrated. The lamps were probably driven by a high
#' frequency electronic ballast. Measured bwteen 1996 to 1998.
#' 
#' @references 
#' Aphalo, P J, R Tegelberg, and R Julkunen-Tiitto. 1999. The Modulated UV-B Irradiation System at the 
#' University of Joensuu.” Biotronics 28: 109–120. 
#' \url{http://133.5.207.201/ijob/Biotronics/1999_IJOBS_V28/V28_p109-120.pdf}.
#' 
#' @docType data
#' @keywords datasets
#' @format A source.spct with 561 rows (240 nm to 800 nm, 1.0 nm step) and 3 variables.
#' @name macam.lamps.data
#' @aliases qpanel.uvb313.spct qpanel.uva340.spct philips.tl12.spct
#' @examples
#' head(qpanel.uvb313.spct)
NULL
