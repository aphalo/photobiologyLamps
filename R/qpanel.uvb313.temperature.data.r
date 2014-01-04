#' Spectral irradiance data for UVB lamps at different temperatures.
#'
#' Dataset of spectral irradiance from a set of two Q-Panel UVB-313 40W fluorescent tubes, measured
#' at different temperatures.
#' 
#' Absolute values are comparable among the different temperatures. The laamps and the cosine diffuser
#' were located inside a Conviron growth chamber. The measurements were done with a recently calibrated
#' Macam double-monochromator spectroradiometer located outside the chamber and maintained at
#' constant room temperature of 22 C. After each change in the temperarure controller set-point enough time was
#' allowed after the temperature had stabilized inside the chamber, for the output of the lamps to
#' also become stable.
#' 
#' The variables are as follows:
#' \itemize{
#'   \item w.length (nm)  
#'   \item s.e.irrad (W m-2 nm-1)
#'   \item s.q.irrad (mol m-2 s-1 nm-1)
#'   \item temperature (C)
#' }
#' 
#' @note
#' Instrument used: Macam SR-9010-PC scanning double monochromator spectroradiometer with
#' a cosine corrected input optics. Recently calibrated. The lamps were driven by a high
#' frequency electronic ballast.
#' 
#' @reference 
#' Aphalo, P J, R Tegelberg, and R Julkunen-Tiitto. 1999. The Modulated UV-B Irradiation System at the 
#' University of Joensuu.” Biotronics 28: 109–120. 
#' \url{http://133.5.207.201/ijob/Biotronics/1999_IJOBS_V28/V28_p109-120.pdf}.
#' 
#' @docType data
#' @keywords datasets
#' @format A data frame with 301 rows (250 nm to 400 nm, 1.0 nm step) and 4 variables.
#' @name qpanel.uvb313.temperature.data
#' 
NULL
