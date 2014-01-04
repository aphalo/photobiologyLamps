#' Calculate lamp output by interpolation from lamp data
#' 
#' @description
#' Calculate interpolated values by interpolation from user-supplied spectral emission
#' data or by name for data included in the package, scaling the values.
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
#' @return a dataframe with two numeric vectors with wavelength values and scaled and interpolated spectral (energy or photon) irradiance values
#' @keywords manip misc
#' @export
#' 
#' @note This is a convenience function that adds no new functionality but makes it a little easier to plot lamp spectral emission data consistently.
#' It automates interpolation, extrapolation/trimming and scaling.
#' @examples
#' with(incandescent.60w.data, calc_lamp_output(290:1100, w.length.in=w.length, s.irrad.in=s.e.irrad))
#' with(incandescent.60w.data, calc_lamp_output(290:1100, w.length.in=w.length, 
#'                                                        s.irrad.in=s.e.irrad, unit.out="photon"))
#' calc_lamp_output(290:1100, w.length.in=incandescent.60w.data$w.length, 
#'                         s.irrad.in=incandescent.60w.data$s.e.irrad)
#' calc_lamp_output(290:1100, "incandescent.60w")
#' calc_lamp_output(500:600, "incandescent.60w", unit.out="photon")
#' 
calc_lamp_output <- function(w.length.out,
                                    lamp.name=NULL, 
                                    w.length.in=NULL, s.irrad.in=NULL, 
                                    unit.in="energy", unit.out=NULL,
                                    scaled=NULL, fill=NA) {  
  # we first check the different possible inputs and convert to
  # two vectors w.length.in and s.irrad.in
  
  if (is.null(w.length.in) | is.null(s.irrad.in)) {
    if (is.null(lamp.name)) return(NA) 
    else {
      lamp.object.name <- paste(lamp.name, "data", sep=".")
      if (!exists(lamp.object.name)) {
        warning("No data for lamp with name: ", lamp.object.name)
        return(NA)
      }
      lamp.object <- get(lamp.object.name)
      w.length.in <- lamp.object$w.length
      if (with(lamp.object, exists("s.e.irrad"))) {
        unit.in <- "energy"
        s.irrad.in <- lamp.object$s.e.irrad
      } 
      else if (with(lamp.object, exists("s.q.irrad"))) {
        unit.in <- "photon"
        s.irrad.in <- lamp.object$s.q.irrad
      }
      else {
        return(NA)
      }
    }
  }
  else if (!check_spectrum(w.length.in, s.irrad.in)) {
      return(NA)
    }

  # we check unit.in and unit.out and convert the input spectrum accordingly

  if (is.null(unit.out)) unit.out <- unit.in
    
  if (unit.in == unit.out) {
      s.irrad <- s.irrad.in
    }
    else if (unit.in == "energy" && unit.out == "photon") {
      s.irrad <- as_quantum_mol(w.length.in, s.irrad.in)
    }
    else if (unit.in == "photon" && unit.out == "energy") {
      s.irrad <- as_energy(w.length.in, s.irrad.in)
    }
    else {
      warning("Bad unit argument. unit.in: ", unit.in, "unit.out: ", unit.out)
      return(NA)
    }

  # we interpolate using a spline

  if (length(w.length.out) < 25) {
    # cubic spline
    s.irrad.out <- spline(w.length.in, s.irrad, xout=w.length.out)$y
  } else {
    # linear interpolation
    s.irrad.out <- approx(w.length.in, s.irrad, xout=w.length.out, ties="ordered")$y
  }

  # we trim the tails as it makes no sense to extrapolate
  
  out.data <- trim_tails(w.length.out, s.irrad.out, w.length.in[1], w.length.in[length(w.length.in)], use.hinges=FALSE, fill=fill)
  names(out.data)[2] <- "s.irrad"
  if (is.null(scaled)) {
    div <- 1.0
  }
  else if (scaled=="peak") {
    div <- with(out.data, max(s.irrad, na.rm=TRUE))
  }
  else if (scaled=="area") {
    div <- with(na.omit(out.data), integrate_irradianceC(w.length, s.irrad))
  }
  else {
    warning("Ignoring unsupported scaled argument: ", scaled)
  }
  out.data$s.irrad <- with(out.data, s.irrad / div)
  return(out.data)
}