**Computer vision** -> field for information extraction from images
## 1. Image Formation Process
From 3D scene to 2D image, we need to
- Geometric relationships, 3D point in 2D pic
- Radiometric relationships, light info
- Digitization

**Pinhole model** -> tiny hole that captures light rays
We convert 3D points in a 2D image plane following the rules of **perspective projection**

**Stereo model** -> using 2 images to recover 3D structure by triangulation (2 point distance difference, the higher, the further the points are in depth)

$$\text{depth } z=\frac{\text{baseline }b \cdot \text{focal length } f}{\text{disparity } d}$$
**Epipole** -> point in one stereo image that lines with the