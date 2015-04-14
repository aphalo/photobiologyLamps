#' @title Spectral data for lamp emission
#' 
#' @description This package provides data for some frequently used lamps. The
#'   package is designed to complement package
#'   \code{\link[photobiology]{photobiology-package}}.
#' 
#' @docType package
#' @keywords misc
#' @name photobiologyLamps-package
#' @author Pedro J. Aphalo
#' @details
#' \tabular{ll}{
#' Package: \tab photobiologyLamps\cr
#' Type: \tab Package\cr
#' Version: \tab 0.3.0\cr
#' Date: \tab 2015-04-13\cr
#' License: \tab GPL (>= 3.0)\cr
#' URL: \tab \url{http://www.r4photobiology.info},\cr
#'      \tab \url{https://bitbucket.org/aphalo/photobiologyLamps}\cr
#' BugReports: \tab \url{https://bitbucket.org/aphalo/photobiologyLamps}\cr
#' }
#' 
#' @import photobiology
#' 
#' @references
#' Aphalo, P. J., Albert, A., Björn, L. O., McLeod, A. R., Robson, T. M., 
#' Rosenqvist, E. (Eds.). (2012). Beyond the Visible: A handbook of best 
#' practice in plant UV photobiology (1st ed., p. xxx + 174). 
#' Helsinki: University of Helsinki, Department of Biosciences, 
#' Division of Plant Biology. ISBN 978-952-10-8363-1 (PDF), 
#' 978-952-10-8362-4 (paperback). Open access PDF download available at 
#' \url{http://hdl.handle.net/10138/37558}
#' 
#' @examples
#' library(photobiologyLamps)
#' library(photobiologyWavebands)
#' q_ratio(incandescent.60w.spct, Blue(), Green())
NULL
