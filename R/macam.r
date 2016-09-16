#' @title Spectra acquired with Macam SR-9010-PC
#'
#' @description A collection of lamp emission spectra measured with a Macam
#'   SR-9010-PC spectroradiometer.
#'
#' @details \code{macam} is a character vector with indexes to members of 
#'   \code{\link{lamps.mspct}} with spectral emission data for Q-Panel UVB-313
#'   and UVA-340 40W fluorescent tubes, and for Philips TL12 40W fluorescent
#'   tubes.
#'
#'   The variables in each member spectrum are as follows: \itemize{ \item
#'   w.length (nm) \item s.e.irrad (relative energy based units) }
#'
#' @note Instrument used: Macam SR-9010-PC scanning double monochromator
#'   spectroradiometer with a cosine corrected input optics. Recently
#'   calibrated. The lamps were probably driven by a high frequency electronic
#'   ballast. Measured between 1996 to 1998.
#'
#' @references Aphalo, P J, R Tegelberg, and R Julkunen-Tiitto. 1999. The
#'   Modulated UV-B Irradiation System at the University of Joensuu.” Biotronics
#'   28: 109–120.
#'   \url{http://133.5.207.201/ijob/Biotronics/1999_IJOBS_V28/V28_p109-120.pdf}.
#'
#' @docType data
#' @keywords datasets
#' @format A vector of character strings.
#' @aliases qpanel.uvb313 qpanel.uva340 philips.tl12.mc
#' 
#' @examples
#' lamps.mspct[macam]
#' lamps.mspct[["qpanel.uvb313"]]
#' lamps.mspct$qpanel.uvb313
#' 
"macam"
