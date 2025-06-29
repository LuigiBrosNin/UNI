# Insights
---
The profs uses all range of the voting (from 18 throughout 30) when making students pass, unlike other prof tendencies of using 26-28-30 in magistrale.
He's exigent but doesn't push you during the oral exam, giving you time to explain and thinking about the question.
The theory is a lot of stuff for 6 CFU if that wasn't obvious enough.
As far as i know the presentation can be done in english or italian alike.
The prof can ask some questions during the presentation of the project, and since 99% of projects and papers are about machine learning, after the presentation the theory question will travel towards the general part (part 1 in my notes).
This means you could selectively study the 2nd part from everything around your project in depth theory-wise and then focus on the 1st part of the course, a little easier imo.
Your call, i already studied everything anyway and i'm prepared for whatever will come my way.

# Summaries
---
**Computer vision** -> field for information extraction from images
## 1. Image Formation Process
From 3D scene to 2D image, we need to
- Geometric relationships, 3D point in 2D pic
- Radiometric relationships, light info
- Digitization

**Pinhole model** -> tiny hole that captures light rays
We convert 3D points in a 2D image plane following the rules of **perspective projection**

### Stereo model
**Stereo model** -> using 2 images to recover 3D structure by triangulation (2 point distance difference, the higher, the further the points are in depth)

$$\text{depth } z=\frac{\text{baseline }b \cdot \text{focal length } f}{\text{disparity } d}$$
**Epipole** -> point in one stereo image that lines with the point where the 1st photo was taken E
**Epipolar line** -> corresponding points lie on the same epipolar lines in both images
### Digitalization
**Sensors** convert light to electrical signals
Key processes:
- **Sampling** -> space, colour discretization in pixels, hue
- **Quantization** -> light discretization in brightness

Sensor characteristics
- Signal-to-noise ratio