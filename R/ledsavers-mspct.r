#' @title Spectra for a multichannel LED bulb
#'
#' @description A collection of lamp emission spectra for a household LED bulb
#'   with four channels and a remote control allowing color mixing. In addition
#'   character vectors useful as indexes for extracting subsets of the data are
#'   defined. Pairs of RGB channels are used in mixes. This is by design of the
#'   lamp and/or its remote control. The lamp here used is a 7.6 W, 230 V, E-27
#'   LED lamp bulb accompanied by a small wireless remote control from a Swedish
#'   supplier. Similar (identical?) lamps are at the moment (early 2018) widely
#'   available through eBay and Aliexpress sellers.
#'
#' @details \code{ledsavers.mspct}  contains a collection of 16 \code{"source_spct"}
#'   objects with spectral emission data for each of the colors obtainable from
#'   the lamp. All colors were measured at maximum power output although the lamp
#'   supports dimming. The lamp was maintained at the same distance from the 
#'   input optics so the different spectra are comparable and provided expressed
#'   in calibrated units.
#'
#'   The variables in each member spectrum are as follows: \itemize{ \item
#'   w.length (nm) \item s.e.irrad (relative energy based units) }
#'
#' @note Instrument used: Ocean Optics Maya2000 Pro single-monochromator array
#'   spectroradiometer with a Bentham cosine corrected input optics. A complex
#'   set of corrections and calibration procedure used. Raw spectral data
#'   processed with R package MayaCalc. The \code{source_spct} objects have 
#'   attributes with additional information on the measurement and data processing.
#'   Measurements done by Pedro J. Aphalo. Data acquired using R package 'ooacquire'.
#'
#' @section Acknowledgements:
#' We thank Prof. Lars Olof Björn for the gift of the lamp.
#' 
#' @docType data
#' @keywords datasets
#' 
#' @format \code{ledsavers.mspct} is a \code{"source_mspct"} object containing 
#'   a collection of 16 \code{"source_spct"} objects as members. Members are
#'   named.
#'   
#' \code{ledsavers_channels}, \code{ledsavers_mixes}, \code{ledsavers_RG_mixes},
#' \code{ledsavers_RB_mixes}, \code{ledsavers_GB_mixes} are character vectors
#' containing subsets of \code{names(ledsavers.mspct)}.
#' 
#' @references \url{http://www.ledsavers.com/}
#'
#' @examples
#' ledsavers_channels
#' ledsavers.mspct$W
#' ledsavers.mspct[["W"]]
#' ledsavers.mspct[ledsavers_channels]
#' 
"ledsavers.mspct"

#' @rdname ledsavers.mspct
"ledsavers_channels"

#' @rdname ledsavers.mspct
"ledsavers_mixes"

#' @rdname ledsavers.mspct
"ledsavers_RG_mixes"

#' @rdname ledsavers.mspct
"ledsavers_RB_mixes"

#' @rdname ledsavers.mspct
"ledsavers_GB_mixes"
