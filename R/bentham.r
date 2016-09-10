#' Spectra aqcuired with Bentham spectrometer
#' 
#' A collection of spectra measured with a Bentham spectroradiometer. Datasets 
#' contain wavelengths at a 0.5 nm interval and corresponing values for spectral
#' emittance from different lamps. As absolute values are not meaningful because
#' measuring distances are in most cases unknown data have been normalized to 
#' one at the wavelength of maximum energy irradiance.
#' 
#' The \code{"source_mspct"} object contains \code{"source_spct"} objects 
#' philips.tl01 philips.tl12
#' 
#' The variables in each member spectrum are as follows: \itemize{ \item
#' w.length (nm) \item s.e.irrad (relative energy based units) }
#' 
#' @note Instrument used: Bentham scanning double monochromator
#' spectroradiometer with a cosine corrected input optics. Recently calibrated
#' at STUK (Radiation Safety Authority Finland). Measurements done by Lasse
#' Ylianttila (STUK, Helsinki, Finland).
#' 
#' @docType data
#' @keywords datasets
#' @format A \code{"source.mspct"} with two member \code{"source.spct objects"}, 
#'   each with 301 rows (250 nm to 400 nm, 0.5 nm step) and 2 variables.
#' @aliases philips.tl01 philips.tl12
"bentham.mspct"