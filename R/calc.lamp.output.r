#' Calculate lamp output by interpolation from lamp data
#' 
#' @description
#' Calculate interpolated values by interpolation from user-supplied spectral emission
#' data or by name for data included in the package, scaling the values.
#' The use of this function is DEPRECATED as it will soon be removes. Please use
#' calc_source_output() instead.
#'
#' @usage calc_lamp_output(w.length.out, lamp.name=NULL, 
#'                                w.length.in=NULL, s.irrad.in=NULL, 
#'                                unit.in="energy", unit.out=NULL,
#'                                scaled=NULL, fill=NA)
#' 
#' @param w.length.out numeric vector of wavelengths (nm) for output
#' @param lamp.name a character string giving the name of a lamp data set, default is NULL
#' @param w.length.in numeric vector of wavelengths (nm) for input
#' @param s.irrad.in numeric vector of spectral transmittance value (fractions or percent)
#' @param unit.in a character string "energy" or "photon"
#' @param unit.out a character string "energy" or "photon", if NULL (the default) unit.out is set to unit.in (which depends on lamp data, if selected with lamp.name)
#' @param scaled NULL, "peak", "area"; div ignored if !is.null(scaled) 
#' @param fill if NA, no extrapolation is done, and NA is returned for wavelengths outside the range of the input. If NULL then the tails are deleted. If 0 then the tails are set to zero.
#'  
#' @return a dataframe with four numeric vectors with wavelength values (w.length), scaled and interpolated spectral energy or photon irradiance (s.irrad) depending on the argument passed to unit.out (s.irrad)
#' @keywords manip misc
#' @export
#' @importFrom photobiology calc_source_output
#' 
#' @note This is a convenience function that adds no new functionality but makes it a little easier to plot lamp spectral emission data consistently.
#' It automates interpolation, extrapolation/trimming and scaling.
#' @examples
#' with(incandescent.60w.spct, calc_lamp_output(290:1100, w.length.in=w.length, s.irrad.in=s.e.irrad))
#' with(incandescent.60w.spct, calc_lamp_output(290:1100, w.length.in=w.length, 
#'                                                        s.irrad.in=s.e.irrad, unit.out="photon"))
#' calc_lamp_output(290:1100, w.length.in=incandescent.60w.spct$w.length, 
#'                         s.irrad.in=incandescent.60w.spct$s.e.irrad)
#' calc_lamp_output(290:1100, "incandescent.60w")
#' calc_lamp_output(500:600, "incandescent.60w", unit.out="photon")
#' 
calc_lamp_output <- function(w.length.out,
                                    lamp.name=NULL, 
                                    w.length.in=NULL, s.irrad.in=NULL, 
                                    unit.in="energy", unit.out=NULL,
                                    scaled=NULL, fill=NA) { 
  warning("The use of 'calc_lamp_output()' is deprecated, please use 'calc_source_output()' instead.")
  # we just call calc_source_output()
  out.data <- calc_source_output(w.length.out=w.length.out,
                                 source.name=lamp.name, 
                                 w.length.in=w.length.in, s.irrad.in=s.irrad.in, 
                                 unit.in=unit.in,
                                 scaled=scaled, fill=fill)
  
  if (is.null(unit.out)) unit.out <- unit.in
  
  if (unit.out == "energy") {
    out.data$s.irrad <- out.data$s.e.irrad
  } else if (unit.out == "photon") {
    out.data$s.irrad <- out.data$s.e.irrad
  }
  out.data$s.e.irrad <- NULL
  out.data$s.q.irrad <- NULL

  return(out.data)
}