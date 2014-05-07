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
#' @param unit.out (DEPRECATED) a character string "energy" or "photon", if NULL (the default) unit.out is set to unit.in (which depends on lamp data, if selected with lamp.name)
#' @param scaled NULL, "peak", "area"; div ignored if !is.null(scaled) 
#' @param fill if NA, no extrapolation is done, and NA is returned for wavelengths outside the range of the input. If NULL then the tails are deleted. If 0 then the tails are set to zero.
#'  
#' @return a dataframe with four numeric vectors with wavelength values (w.length), scaled and interpolated spectral energy irradiance (s.e.irrad), 
#'    scaled and interpolated spectral photon irradiance values (s.q.irrad), and for backwards compatibility a vector which is equal to either s.e.irrad or s.q.irrad
#'    depending on the argument passed to unit.out (s.irrad)
#' @keywords manip misc
#' @export
#' @importFrom photobiology check_spectrum trim_tails integrate_irradiance as_quantum_mol as_energy
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
    if (is.null(lamp.name)) {
      return(NA) 
    } else {
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
      } else if (with(lamp.object, exists("s.q.irrad"))) {
        unit.in <- "photon"
        s.irrad.in <- lamp.object$s.q.irrad
      } else {
        return(NA)
      }
    }
  } else if (!check_spectrum(w.length.in, s.irrad.in)) {
      return(NA)
  }

  if (is.null(unit.out)) unit.out <- unit.in
  
  # we interpolate using a spline or linear interpolation

  if (length(w.length.out) < 25) {
    # cubic spline
    out.fill.selector <- w.length.out < w.length.in[1] | w.length.out > w.length.in[length(w.length.in)]
    s.irrad.out[out.fill.selector] <- fill
    s.irrad.out[!out.fill.selector] <- spline(w.length.in, s.irrad.in, xout=w.length.out[!out.fill.selector])$y
  } else {
    # linear interpolation
    s.irrad.out <- approx(x = w.length.in, y = s.irrad.in, xout = w.length.out, ties = "ordered", yleft = fill, yright = fill)$y
  }

  # do scaling
  
  if (!is.null(scaled)) {
    if (scaled=="peak") {
      div <- max(s.irrad.out, na.rm=TRUE)
    } else if (scaled=="area") {
      s.irrad.na.sub <- s.irrad.out
      s.irrad.na.sub[is.na(s.irrad.na.sub)] <- 0.0
      div <- integrate_irradiance(w.length.out, s.irrad.na.sub)
    } else {
      warning("Ignoring unsupported scaled argument: ", scaled)
      div <- 1.0
    }
    s.irrad.out <- s.irrad.out / div
  }
  
  # we check unit.in and unit.out and convert the output spectrum accordingly

  if (unit.in == "energy") {
    out.data <- data.frame(w.length = w.length.out, s.e.irrad = s.irrad.out, s.q.irrad = as_quantum_mol(w.length.out, s.irrad.out))
  } else if (unit.in == "photon") {
    out.data <- data.frame(w.length = w.length.out, s.e.irrad = as_energy(w.length.out, s.irrad.out), s.q.irrad = s.irrad.out)
  } else {
    warning("Bad argument for unit.in: ", unit.in)
    return(NA)
  }
  if (unit.out == "energy") {
    out.data$s.irrad <- out.data$s.e.irrad
  } else if (unit.out == "photon") {
    out.data$s.irrad <- out.data$s.e.irrad
  }
  return(out.data)
}