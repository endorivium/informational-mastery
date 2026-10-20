# 3D Coord System

| Camera Coordinate System             | World Coordinate System              |
| ------------------------------------ | ------------------------------------ |
| ![[Pasted image 20261015154239.png]] | ![[Pasted image 20261015154249.png]] |
## Mapping 3D - 2D
[Article](https://medium.com/@aakhv110/understanding-3d-to-2d-camera-projection-concept-85b6e9602388)
- see [[#Calibration Matrix]] for **K**
- M is fixed
- R is rotation of the world coord system in relation to the camera coord system (based on camera coord sys, how is the world coord sys rotated away from it)
- t is translation of the camera in relation to world coord origin (how far is it from world center)
- note: world coordinate system is at optical center of camera, then the two sys overlap and R is 3x3 Identity matrix and translation is zero vector
- after calculation, needs to divide by z to get real pixel coords (which is just x/y)
![[Pasted image 20261015161641.png]]
- **Homogeneous Coordinates** come from projective geometry and include the usage of an extra dimension called W, the "projective space" ([article](https://www.tomdalling.com/blog/explaining-homogenous-coordinates-and-projective-geometry/))
- coordinates in this projective space are called homogeneous coordinates
- e.g. in 2D space, W dimension is the distance from the projector to the 2D image where **moving in that dimension scales the image**![[Pasted image 20261015154923.png]]
- doing the same in 3D, W essentially scales the coordinates; if W = 1, then the coordinates stay the same
- **De-Homogenization** happens via division by the w coordinate![[Pasted image 20261015155148.png]]

## Perspective Projection
![[Pasted image 20261015155444.png]]
- f is focal length
- to simplify, x and y axes are flipped, so that image plane is in front of the center of projection instead of behind, allowing for the minus to be dropped
- is a non-linear mapping
 ![[Pasted image 20261015155659.png]]
 - homogeneous coordinates transform it into linear mapping
# Camera Parameter
## Intrinsic
- intrinsic params that depend on the optical and geometric characteristics of the camera, do not change when camera is moved
![[Pasted image 20261015155808.png]]
- **focal length**: can think of as "zoom", related to field of view, higher focal length means "more" zoom
- **principle point**: essentially defines the (0,0) of the image plane, x/y coord system is centered on principal point but u/v coord system has origin in top left and does not allow negative coords, so principle point is used to shift x/y to u/v coord system![[Pasted image 20261015160820.png]]

### Distortions
![[Pasted image 20261015160108.png]]

| Distortion | Example                              |
| ---------- | ------------------------------------ |
| Barrel     | ![[Pasted image 20261015161220.png]] |
| Cushion    | ![[Pasted image 20261015161239.png]] |
#### Modeling Radial Distortion
![[Pasted image 20261015160420.png]]
- f is focal length, xyz are coordinates, p_u_/p_v_ is principal point to shift xyz into uv coord system
### Calibration Matrix
- collects intrinsic params![[Pasted image 20261015160310.png]]
- fx/y is focal length divided by pixel size
- pu/v is half width/height of sensor size
## Extrinsic
- change when camera is moved (e.g. position and orientation of camera (=**pose**))![[Pasted image 20261015161602.png]]
