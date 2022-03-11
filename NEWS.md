---
editor_options: 
  markdown: 
    wrap: sentence
---

photobiologyLamps 0.5.0
=======================

This is a major and code-breaking update.
Naming conventions have been slightly changed and many new spectra have been added.
Previously included spectra have in most cases been recomputed and may slightly differ from earlier versions of the same data.
In part this was done to reduce the size of the data objects, making it possible to include more spectra while keeping the size of the package reasonable.

* Revise for 'ggspectra' (\>= 0.3.1).
* Rebuild all data objects with 'photobiology' (== 0.10.9) taking care that all spectra in `lamps.mspct` are normalized, also adding previously missing metadata.
* Apply function `photobiology::thin_wl()` to all spectra to reduce their stored size.
* Add data for additional flashlights.
* Add data for black light blue "BLB" fluorescent tubes.
* Add data for new grow lights from Fluence-Osram.
* Add data for various LED lamps and tubes.
* Replace a few spectra with newly measured ones from the same lamps.
* CODE BREAKING. Rename the members of the collection of spectra for easier identification and to improve consistency in naming with packages 'photobiologyLEDs' and 
  'photobiologyFilters'.
* Revise vignette and other documentation.
* Migrate the Git repository from Bitbucket to GitHub.

photobiologyLamps 0.4.3
=======================

* Add data for Fluence-Osram grow lamps.
* Add data for Sunwayfoto LED lamp and Godox flash.
* Add data for UV-A flashlights.
* Replace non-ASCII characters in documentation.
* Rebuild all spectral data objects.
* Correct some minor mistakes in the metadata stored in attribute `"what.measured"`
in some spectra, add missing attribute `"what.measured"` and new attribute
`"how.measured"`.

photobiologyLamps 0.4.2
=======================

Add data for several fixed-spectrum lamps and for a variable spectrum 
four-channel WRGB LED bulb.
Add indexing vectors and rename some of the existing ones.
Update documentation and vignette.

photobiologyLamps 0.4.1
=======================

_First CRAN release_ 
Further reorganization of data into fewer objects.
Update documentation to track these changes. 

photobiologyLamps 0.4.0
=======================

Major update, not backwards compatible.
Data reorganized into collections of spectra grouped by measurement
conditions/instrument used. This means that names of all data objects have
changed.
Documentation updated.
Vignette converted to Rmarkdown and updated to work with the new objects.
Most spectra have been normalized to one at the peak, as actual spectral
irradiance values are irrelevant when distance and geometry are not known.

photobiologyLamps 0.3.4
=======================

Partial update, released as a test version.

photobiologyLamps 0.3.3
=======================

Update for photobiology 0.9.1, ggspectra 0.1.0 and ggplot2 2.0.0.
Fixed bug in Q-Panel UV313 temperature response data that was triggering and
error with the now tighter checking.

photobiologyLamps 0.3.2
=======================

Rebuild data and package. Update data object building scripts.

photobiologyLamps 0.3.1
=======================

Add spectral data for germicidal lamp.

Rebuild all data, and the package under photobiology 0.7.0.

photobiologyLamps 0.3.0
=======================

Rebuilt all data, and the package under photobiology 0.6.0.

Now that spectral objects can contain more than one spectrum, a
source_spct object is used to store the spectra for the lamp
temperature response. Because of this the User Guide was also
edited.

photobiologyLamps 0.2.2
=======================

Edited vignette to use photobiologygg 0.2.8, adding titles to the figures.

photobiologyLamps 0.2.1
=======================

Edited vignette to use photobiologygg 0.2.5 functions to simplify code examples.

photobiologyLamps 0.2.0
=======================

Rebuilt vignette with photobiology 0.5.1, which is now required.
Removed `calc.lamp.multipliers()`.

photobiologyLamps 0.1.14
========================

Rebuilt all spectral data objects with photobiology 0.4.5 so that the time.unit attribute is not missing.

photobiologyLamps 0.1.13
========================

Minor changes.

photobiologyLamps 0.1.12
========================

source.spct objects now contain only spectral energy irradiance data.

photobiologyLamps 0.1.11
========================

All data is now in source.spct objects, except for a data.table with the temperature response data set.

photobiologyLamps 0.1.10
========================

Added functions `D2_spectrum()` and `FEL_spectrum()`. These functions use constants from high precision fits to known calibration lamps.

photobiologyLamps 0.1.9
=======================

Fixed bug introduced yesterday in 0.1.8. calc_lamp_output was not doing the rescaling correctly and moved most of the code to calc_source_output() in package photobiology.
calc_lamp_output() now just calls calc_source_output() and its use is deprecated.

photobiologyLamps 0.1.8
=======================

Substantial changes to calc_lamp_output to simplify use and to correctly handle NAs and cases when extrapolation is involved.

photobiologyLamps 0.1.7
=======================

Changes to adjust code to changes in package photobiology version 0.2.16

photobiologyLamps 0.1.6
=======================

Added three spectra from UV lamps measured in the range 240 nm to 800 nm, with a Macam scanning
spectroradiometer with double monochromator. Data not as good as from the Bentham instrument
but measured over a wider range of wavelengths.

photobiologyLamps 0.1.5
=======================

Corrected wrong units in Bentham data. It was in mW m<sup>-2</sup> nm<sup>-1</sup>, while documentation 
indicated that it was in W m<sup>-2</sup> nm<sup>-1</sup>. Data has been now rescaled. 

photobiologyLamps 0.1.4
=======================

Added data for Q-Panel UVB-313 lamp emission at different temperatures.

photobiologyLamps 0.1.3
=======================

Added function calc_lamp_output.
Wrote new vignette dataPlots with plots for all lamp data in the package.


photobiologyLamps 0.1.2
=======================

Merged some edits, and fixed some documentation bugs.

photobiologyLamps 0.1.1
=======================

Added data measured with a Bentham spectroradiometer.


photobiologyLamps 0.1.0
=======================

First version containing data measured with a LI-COR LI-1800 spectroradiometer.
