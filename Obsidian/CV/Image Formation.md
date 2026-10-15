# Sensors
Types: area (CCD, CMOS chip), line (like area but in line), point (single intensity value)

## CCD Sensor (Charge Coupled Device)

Sources: [Teledyne CCD vs CMOS](https://www.teledynevisionsolutions.com/learn/learning-center/imaging-fundamentals/ccd-vs-cmos/) [Baslerweb CCD](https://www.baslerweb.com/en/learning/ccd-sensors/) [Baslerweb CCD vs CMOS](https://www.baslerweb.com/en/learning/ccd-cmos/)

- interline sensor, where light-sensitive pixels and potential barriers (shift register) alternate
- full frame sensor, uses almost entire surface
- each pixel's charge (i.e. "recorded light") is transferred into the adjacent potential well which are later read out (row-by-row or column-by-column) by shifting the charges from one potential well to the next towards the output node
- there it is converted to voltage, buffered and sent off-chip as an analog signal (Teledyne)
- needs mechanical shutter during readout since charges pass light-sensitive parts during readout
![[Pasted image 20261013170324.png]]

- Blooming: occurs during exposure, limited light strips, completely overexposed
- Smear: created during readout, light strips up to edge, not completely overexposed
## CMOS Sensor (Complementary Metal Oxide Semiconductor)
- detection of photons as with CCD
- each pixel has own "converter"
	- direct control of individual pixels via transistors/address lines
	- arbitrary image regions selectable

## Comparison

| CCD                                                                                                  | CMOS                                                                                                                         |
| ---------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------- |
| charge shifted per pixel to output node                                                              | each pixel read out directly (each has charge-to-voltage conversion built in)                                                |
| pixels completely devoted to light capture, high uniformity of output (key factor for image quality) | light capture area reduced, lower uniformity but massively parallel, allowing high total bandwith for high speed             |
| inexpensive, low weight/size<br>insensitive to shocks and electromagn. fields                        | low power consumption<br>wide temperature range                                                                              |
|                                                                                                      | control/processing electronics can be directly integrated into chip<br>free and random pixel access<br>greater dynamic range |
| bottlenecked by readout speed<br>blooming, smearing                                                  | higher frame rate possible due to architecture<br>no blooming, smearing, shutter lag                                         |
| ![[Pasted image 20261013165327.png]]                                                                 | ![[Pasted image 20261013171130.png]]                                                                                         |
## Color Sensors
![[Pasted image 20261013171950.png]]
- light sensors only detect intensity of the light, so can only capture grey images
- color information needs to be collected via optical separation of light according to wavelength
	- disadvantage: complex, each pixel needs to hit exact same coordinate or has same effect as chromatic abberration via camera lense
### Color Filter Array (CFA)
![[Pasted image 20261013172201.png]]
- filter on each individual pixel
- but: loss of sensitivity due to filter
## Digital Images
- binary image: 1bit/ pixel
- gray value image: 8bit/ pixel, 10,12,16 bit/ pixel
- color image (rgb): 8bit/ color channel, 10,12,16 bit/ color channel
- volume image: combined create 3D representation of subject
- image sequence: images that sequentially (time) follow one after another
# Optical Imaging
## Basic Principle
- ideally, each homocentric beam (bundle of light rays intersecting in a single point) that diverges from G is transformed by the imaging optics into another homocentric beam converging at some point B on the sensor
- correspondence between the two points B = A{G} yields a sharp optical imaging
![[Pasted image 20261013173821.png]]

## Pinhole Camera Model
![[Pasted image 20261013174343.png]]
- an ideal pinhole camera consists of a diaphragm with an infinitesimally small hole that is parallel  to an image plane, accepting exactly one light ray of a light bundle coming from an object point
- *b* is the **image distance** between the aperture and the image plane
- *x* and *y* describe the **optical mapping of an object point to an image point**
- pinhole camera creates an inverted image
- z-axis of camera runs runs through center of pinhole and away from camera
