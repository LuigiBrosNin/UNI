
> Notes taken by Luizo ( [@LuigiBrosNin](https://t.me/LuigiBrosNin) on Telegram)


- Exam
	- An exam consisting of two parts:
	- First part (project):
	- Send prof a list of three articles you are interested in, preferably with the available code. The choice should be based on articles published in the conferences or journals listed in the slides.
	- you will need to thoroughly study the prof selected article and its related code to replicate at least one experiment presented in the article or conduct a test of your interest by modifying the technique you have studied.
	- If the code is not available, the student should try to re-implement the relative model and replicate one experiment 
	- Prepare a 20-minute presentation that describes the technique proposed in the chosen article and the experiment you conducted.
	- During or at the end of the presentation, I will ask you questions about the work you have done.
	- Second part
	- you will answer general questions on the theory presented in the course.


# Theory
Slides are terrible, what is important is mostly what the prof talks about, which is not in the slides as he explains.

## 

# Notes
I can't make miracles, the slides are hard to follow and lack pedagogical cohesion to understand, if you want to study there you're in for some challenge.
I hope Lisanti changes the slides next year, meanwhile i'll try my best to make these notes to study and most importantly understand this 60 cfu curse.
##
---
Part 1
## 0. Intro
**Computer vision** -> deals with extraction of information from images (eg. pic of a bird -> "This is a bird!")
## 1. Image Formation Process
Getting a 3d scene into a 2d image: **Key Processes**:
- **Geometric relationships** (scene point to image point)
- **Radiometric relationships** (light to brightness)
- **Digitization** (sampling and quantization)

**Pinhole model** -> capture light rays passing trough a tiny hole
**Perspective projection** -> 3d scene points are converted into a 2d image plane, coordinates scale inversely with depth

**Stereo vision** -> to solve the depth info loss, we use 2 images (stereo) to recover 3d structure by triangulation (distance between 2 points is used for depth measurement)
- optical axes must be parallel
- equal focal length
$$\text{depth } z = \frac{b\cdot f} d$$
$b$ -> baseline
$f$ -> focal length
$d$ -> disparity

**Epipolar geometry** -> **geometric relationship** between two cameras viewing the same 3D scene from different angles.
![[Pasted image 20250514173811.png]]
![[Pasted image 20250514173644.png]]


**Pinhole cameras** have infinite depth of field but poor light gathering.
**Lenses** ->
- focus light more effectively
- limited depth of field
- follow the **thin lens equation** for focusing on light 
$$\frac {1}{d_{s}}+\frac 1{d_{i}} = \frac 1{f_{L}}$$
- $d_S$​: distance from the **scene point** to the lens (object distance, coords on the 3d world)
- $d_I$​: distance from the **image point** to the lens (image distance, coordinates on the 2d photo)
- $f_L$​: **focal length** of the lens (a fixed property of the lens)
**DOF** can be manipulated using the diaphragm

==Digitization==
- **Sensors** (CCD/CMOS) convert light to electrical signals.
- Two key processes:
    - **Sampling** (discretizing space → pixels, hue)
    - **Quantization** (discretizing intensity → levels of brightness)

==Sensor characteristics==
- **SNR (Signal-to-Noise Ratio)**
    - Measures true signal vs. noise.
    - Higher SNR = clearer images.
- **Dynamic Range (DR)**
    - Range of detectable light levels.
    - Higher DR = better detail in both bright and dark regions.
**Colour sensor** -> color filter arrays/optical filters are placed in front of the photo-detectors, each pixel is sensitive to a specific range of wavelengths to detect RGB channels (basically filters that recognize colour)
![[Pasted image 20250514172204.png]]
## 2. Spacial Filtering
We want to reduce "noise" in images trough the spatial domain ( aka pixel neighborhood).

==Denoising==
We can denoise an image by taking a mean across time (multiple images)
With a single image, we can compute a mean across neighbouring pixels (mean across space)

==**Image Filters**== -> compute a new (RGB) value for each pixel based on its neighbors. Used for **denoising, sharpening and edge detection**

**filter kernel** -> a small matrix used for some calculations we'll see

**Linear and Translation-Equivariant (LTE)** -> filter type, used as feature extractors in CNNs (Convolutional Neural Networks) Implemented via **2D convolution** between the image and a **kernel** (impulse response).

**Translation-equivariant operator** -> If you shift the input, the output shifts the same way.

 if we have an LTE operator -> sliding the kernel over every pixel, flipping it (that's the convolution), and taking a weighted sum of the neighborhood.
 
 ==Convolution proprieties==
 - Associative property
 - Commutative property
 - Distributive property with the sum
 - Convolution Commutes with Differentiation
These properties mean we can rearrange operations, simplify pipelines, and apply filters in any order without worrying about the result changing unexpectedly.

==Correlation== -> looks the same as convolution, but:
- **Convolution flips** the kernel.
- **Correlation does not**.
In image processing, this matters **only if your kernel isn’t symmetric**.

**Discrete convolution** -> consists in summing the product of the two signals where one has been reflected about the origin and translated. We're simplifying the  
![[Pasted image 20250305194345.png]]
In a practical implementation, we cycle trough the kernel from $-k$ to $+k$ instead of the infinities (duh)

- Practical implementation of a filter in a nutshell
	- Let’s say you’re applying a 3×3 kernel. You’ll:
	1. Slide it over every pixel
	2. Multiply corresponding kernel & pixel values
	3. Sum them
	4. Replace the center pixel with that sum

To solve the border issue (neighbourhood of bordering pixels incomplete), we either CROP or PAD the image

**==Mean Filter==** -> replace pixel intensity with the average intensity of neighbourhood 
Fastest way to denoise an image

**==Gaussian Filter==** -> LTE operator whose impulse response is a 2D Gaussian function (aka having Gaussian distribution)(with zero mean and constant diagonal covariance matrix)

$\sigma$ standard deviation param -> amount of smoothing by the filter (higher -> more blur)

Size of the (kernel) filter given $\sigma$ -> with interval $[-3\sigma,3\sigma]$, captures 99% of the area (“energy”)
of the Gaussian function, we take $(2k+1)\times(2k+1)$ kernel with $k=[3\sigma]$

Deploying the separability property speeds up the filtering operation ( one 2D gaussian split into two 1D convolutions)

==Median Filter== -> Non linear filter, each pixel intensity is replaced by the median over a given neighbourhood, the median being the middle value in the sorted neighbourhood.
![[Pasted image 20250305195940.png|200]]
⚠ Gaussian-like noise, such as sensor noise, cannot be dealt with by the Median, as this would require computing new noiseless intensities.

==Bilateral Filter== -> Advanced non-linear filter to accomplish denoising of Gaussian-like noise without blurring the image (aka edge preserving smoothing, blurs only if pixels are similar in position and intensity value).

==Non-local Means Filter== -> non-linear edge preserving smoothing filter. Finds patches across the image **that look similar** and averages their center pixels

![[Pasted image 20250516230626.png]]

## 3. Edge Detection
**Eges** (object boundaries) -> seen as sharp brightness changes of a 1D signal

Detection of edges in important for **Segmentation**, **object recognition** and **measurement tools**.
![[Pasted image 20250519152935.png]]

### ==1D step edge==
- We use **the 1st derivative** to detect edges with thresholds for detection
	![[Pasted image 20250407231227.png|300]]
### ==2D Gradient==
**Gradient** -> vector of **partial derivatives** (change rates) used to detect the direction of the edge in 2D
$$\nabla I(x,y)=(\frac{\partial x}{\partial I}​,\frac{\partial y}{\partial I})$$
- **Magnitude** of gradient -> strength of edge
- **Direction** -> which way the intensity is increasing the most
![[Pasted image 20250519153740.png|500]]
### ==Discrete approximations==
To compute the gradient we use approximations, estimating derivatives:
We can approximate the gradient with:
- Differences -> how much the pixel changes from:
	- Forward Differences -> $(i+1)-(i)$
	- Backward differences -> $(i) - (i-1)$
	- Central differences -> $(i+1) - (i-1) \over 2$
- Kernels -> Convolution Masks
	- Correlation kernels -> $\begin{bmatrix}-1&0&1\end{bmatrix}\ \begin{bmatrix}-1\\0\\1\end{bmatrix}$
### ==Noise==
**Noise** causes problems in edge detection, we incorporate the smoothing process of the image when detecting edges (take the average of a group of pixels compared to the average of another group)

==Prewitt and Sobel== -> operators for calculating weights
- **Prewitt operator** -> approximating partial derivatives by central differences
	![[Pasted image 20250227171204.png]]
- **Sobel operator** -> central pixel weight
	![[Pasted image 20250227171301.png]]
### ==Non-Maxima Suppression (NMS)==
A good approach to detect edges consists in finding the **local maxima** of the absolute value of the derivative of the signal
![[Pasted image 20250407231227.png|300]]

We should look for the maxima along the gradient direction in images (2D signals)
![[Pasted image 20250407231818.png|600]]
- We cannot know in advance, so we estimate it locally each time
- The magnitude of the gradient has to be estimated at points outside the discrete pixel grid
- We do it by <u>linear interpolation</u> from the closest points belonging to the grid (we base our magnitude by theoretical points that we calculate mathematically, eg. A,B in the example)
	![[Pasted image 20250407232325.png|300]]
- After the NMS, we apply a **threshold** on the magnitude of the gradient to get rid of unwanted edges (noise as edges)
### ==The standard: Canny’s Edge Detector==
Quantitative criteria to measure edge detection performance, and then apply the optimal filter for the best result

==Principled criteria:==
1. Good detection -> extract edges even in noisy images
2. Good localization -> minimize found edge and true edge distance
3. One response to one edge -> one single edge pixel detected at each true edge

Canny shows that the optimal edge detection operation consists in a pipeline of
1. Gaussian smoothing
2. Gradient computation
3. Non-maxima suppression
4. **Hysteresis** thresholding -> approach relying on a higher $(T_h)$ and a lower $(T_l)$threshold.
	- Pixel taken as edge IF:
	- gradient magnitude > $T_h$ <u>OR</u>
	- gradient magnitude > $T_i$ <u>AND</u> pixel is a neighbor of an already detected edge
### ==Second-Order Derivative Methods==
**Zero-crossing** -> Method where we look for the zero crossing point in the 2nd derivative (computationally significant) instead of looking for the maximum value in the derivative
![[Pasted image 20250407234936.png|300]]
Use the **Laplacian** operator (sum of second-order derivatives) to approximate derivatives
$$\nabla^2 I=\frac{\partial^2 I}{\partial x^{2}​}+\frac{\partial^2 I}{\partial y^{2}}​$$

### ==Laplacian of Gaussian (LOG)==
robust edge detectors should include a smoothing step to filter out noise
**LOG** conceptually:
1. Gaussian smoothing
2. Apply Laplacian 
3. Find zero-crossings
4. Once a sign change is found, the actual edge may be localized at the pixel where the absolute value of the LOG is smaller (best choice) or either pixel towards the positive or negative side.

**The Parameter $\sigma$ (sigma)** of the Gaussian controls ->
- The **degree of smoothing** (larger $\sigma$  for more noise).
- The **scale** at which you detect features (larger $\sigma$  for broader edges).
### Summary
![[Pasted image 20250519164759.png]]
## 4. Local Features
We want to find **Corresponding Points** (Local invariant features) between 2+ images of a scene
![[Pasted image 20250320153021.png|500]]
**Correspondences** -> image points which are the projection of the same 3D point in different views of the scene
**Invariance** -> a method continues to work **even when the image changes** in certain ways (rotation, scale, illumination)
### Three-Stage Pipeline for Local Features
3 successive steps for defining correspondences:  
1. **Detection** of salient points (aka keypoints, interest points, feature points...)  
2. **Description** -> computation of a suitable descriptor based on pixels in the keypoint neighbourhood  
3. **Matching** descriptors between images  

==Detectors/Descriptors good properties==
- Detector
	- **Repeatability** -> find the same keypoints in different views  
	- **Saliency** -> find keypoints surrounded by informative patterns
- Descriptor
	- **Distinctiveness vs. Robustness Trade-off** -> capture the salient information around a keypoint, disregard changes due to nuisances (e.g. light changes) and noise
	- **Compactness** -> description as concise as possible for low memory and fast matching
- Desirable **speed** for both

### Classic corner detectors
We use corners for identification, as they're easily identifiable (strong change in intensity in all directions)

==Moravec Interest Point Detector== -> Look at patches in the image and compute cornerness (8 neighboring patches, look for high variation)
![[Pasted image 20250320154429.png|200]]

==**Harris Corner Detector**==
kindergarten level explanation:
1. Compute image gradients (how intensity changes)
2. Build the matrix $M$
3. Compute the corner response $C=\det⁡(M)−k\cdot \text{trace}(M)^2$
4. Threshold & NMS to pick the best corners
---
elementary level explanation:
1. compute image gradients -> based on <u>the weighted sum of derivatives around the point of interest</u> (aka, i look at points around the interested one to figure out if it's somewhat the same one)
	![[Pasted image 20250306152512.png|400]]
2. Form the structure tensor (matrix M for each pixel) using the squared gradients and their product
3. Compute "Cornerness" score $C=\det⁡(M)−k\cdot \text{trace}(M)^2$
4. Select all pixels where $C$ is higher than a chosen positive threshold (T) given by a sensitivity constant $k$
5. Within the previous set, detect as corners only those pixels that are local maxima of $C$ (NMS)
### Invariance properties of harry's detector
✅**Rotation invariance** -> You’ll detect the same corners even if the image is rotated.
- eigenvalues (aka, the values used to decide if an area is a corner) of $M$ are invariant to a rotation of the image axes, thus so is Harris cornerness function

🟨**Partial illumination invariance** -> Harris <u>works if brightness shifts uniformly</u>, but not if the image contrast changes.
- Yes, for additive bias ($I' = I+b$) due to the use of derivatives
- No, to multiplication by a gain factor ($I'=a\cdot I$) => derivatives gets multiplied by the same factor
	![[Pasted image 20250519175948.png| 400]]

❌**Scale invariance property** -> Harris is not scale invariant
- An image contains features at different scales -> Detecting all features requires to analyze the image across the range of scales “deemed as relevant”
	![[Pasted image 20250306153923.png|400]]
- We detect features in order to match their **descriptors**
- To compute and match descriptors we need to smooth out the details that do not appear across the range of scales (more explained next)

### Scale-Space, LoG, DoG
==Scale-space==
**Key finding** -> apply a <u>fixed-size detection</u> tool on increasingly <u>down-sampled</u> and <u>smoothed</u> versions of the input image (trough Laplacian of Gaussian or Difference of Gaussian, its approximation) (LoG, DoG)
![[Pasted image 20250306154726.png|400]]
**Scale-space** -> group of the same image at different computed smoothed scales
$$L(x,y,\sigma )=G(x,y,\sigma )∗I(x,y)$$
Where:
- G is the Gaussian kernel
- $\sigma$ controls the scale (blur amount)
- $*$ is convolution


==Multi-Scale Feature Detection (Lindeberg)==
Scale-space gives us images at various levels, but we don’t yet know **which features** to extract, or **at what scale**.

Lindeberg method:
- Use **scale-normalized derivatives** to detect features at their "natural" scale.
- Normalize the filter responses (multiply by $\sigma$)
- Search for **extrema** (maxima or minima) in **x, y, and $\sigma$**  i.e., in 3D.

LoG -> second order derivative that detects **blobs** (circular structures)
$$F(x, y, \sigma) = \sigma^2 \cdot \nabla^2 L(x, y, \sigma)$$
![[Pasted image 20250306162700.png]]

==Difference of Gaussian (DoG)==
very close approximation of Lindeberg's scale-normalized LoG:
$$DoG=L(x,y,k\sigma)−L(x,y,\sigma)$$
We build a pyramid of images blurred with different $\sigma$ and we compute the difference to find the extrema in 3D across (x,y, scale)
![[Pasted image 20250306165051.png]]

==Keypoint detection and Tuning==
To tune the found extrema, we
- Reject low contrast responses
- Prune the keypoints on edges using the **hessian matrix**
![[Pasted image 20250306164454.png]]
DoG helps us find the optimal scale for each detail we want to "classify"

### Invariance properties of DoG
 ✅ **Scale Invariance**
- Use the image L(x,y,σ)L(x, y, \sigma)L(x,y,σ) at the **same scale** where the keypoint was detected.
 ✅ **Rotation Invariance**
- Compute gradients around the keypoint.
- Build a **histogram of gradient orientations** (e.g., 36 bins)
- Find the **dominant direction**  this becomes the **canonical orientation**
- Rotate the descriptor patch accordingly.
![[Pasted image 20250306170348.png]]
🐰basically, when something rotates, the recognition process tries to match a different orientation for a point to see if they're the same

![[Pasted image 20250306170554.png|250]]

### SIFT Descriptor
The SIFT (Scale Invariant Feature Transform) descriptor is computed as follows
![[Pasted image 20250306171107.png]]
1. Take  A 16x16 <u>oriented</u> pixel grid around a keypoint is considered  
2. Divide into **4×4 subregions**
3. In each, compute an **8-bin histogram** (45°) of gradient orientations.
-  Each pixel in the region contributes to its designated bin according to  
	-  Gradient magnitude  
	-  Gaussian weighting function centered at the keypoint (with $\sigma$  equal to half the grid size)
This is used to generate descriptors to match, and the Feature vector is the output
This vector is compact, robust to lighting changes and distinctive for matching
### Matching process
**Nearest Neighbour (NN) Search problem** -> Match SIFT descriptors between images by comparing Euclidean distances.
Using a **ratio test** we eliminate 90% of false matches
$$\frac{d_1}{d_2} < 0.8$$
- $d_1$ = distance to best match
- $d_2$​ = second-best
- If this ratio is small, it's a **confident match**

==Efficient NN-Search==
indexing techniques are exploited to speed up the otherswise slow NN-search process
- k-d tree
- Best Bin First (BBF)
## 5. Camera Calibration
**Camera calibration** -> the process of determining a camera's **internal parameters** (like focal length and lens distortion) and **external parameters** (like the position and orientation of the camera in space). This allows us to accurately measure 3D information from 2D images.
### Perspective projection
**Perspective projection** model -> Given a point in the 3D space, $M=[x,y,z]^T$ , project it into a 2D image point $m=[u,v]^{T}$ .
![[Pasted image 20250320170447.png|250]]
coordinates as a function of the 3D coordinates in the CRF (Camera Reference Frame)
$$
\begin{cases}u=\frac{f}{z}x\\ v=\frac{f}{z}y \end{cases}
$$
where:
$f$ -> focal length
$z$ -> depth (distance from the camera)
This projection is **non-linear** (objects appear smaller with distance)
### Projective Space
Euclidean 3D space can't handle some geometric operations (eg. parallel lines don't intersect, points at infinity can't be represented)
![[Pasted image 20250522174414.png|400]]

**Projective space** ($P^{3}$) -> 4th coordinate for each point in 3D, $[x,y,z,w]$ 
-  $[x,y,z,w]\equiv [kx,ky,kz,kw]$ 
- $w =0$ -> point is at infinity
- Express **perspective projection** linearly using **matrix multiplication**:
$$\tilde m = P\cdot \tilde M$$
- $\tilde{M}$: 3D point in homogeneous coordinates $[x, y, z, 1]$
- $\tilde{m}$: projected 2D image point $[u, v, 1]$
- $P$: **Perspective Projection Matrix (PPM)**
Canonical PPM (assuming $f=1$)
$$P = \begin{bmatrix} 1 & 0 & 0 & 0 \\ 0 & 1 & 0 & 0 \\ 0 & 0 & 1 & 0 \\ \end{bmatrix}$$
### Image Digitization
We need to adapt our calculations accounting for pixels instead of continuous measurements, pixel size, image origin.
![[Pasted image 20250522171452.png]]
(R and T matrices are explained a lil below)

To do so, we:
- Scale by pixel dimensions $\Delta u, \Delta v$
- Shift the image center to pixel coordinates $(u_0,v_0)$

**Intrinsic Parameter Matrix** $A$ -> captures internal characteristics of the camera
$$A = \begin{bmatrix} f_x & s & u_0 \\ 0 & f_y & v_0 \\ 0 & 0 & 1 \end{bmatrix}$$
Where:
- $f_x = f \cdot k_u$ ->: focal length in horizontal pixels
- $f_y = f \cdot k_v$ -> focal length in vertical pixels
- $s$ -> skew (typically 0 for most modern cameras)
- $(u_0, v_0)$ -> image center

The **relation** between <u>camera</u> and <u>world</u> is defined as
$$M_{CRF}=R\cdot M_{WRF}+T$$
Where:
- $R$ -> rotation matrix 3x3, to rotate world coordinates into camera orientation
- T -> Translation vector 3x1, to shift coords into camera position
- CRF -> camera reference frame
- WRF -> world reference frame

in Homogeneous coordinates:
$$M_{CRF} = \begin{bmatrix} R & T \\ 0 & 1 \end{bmatrix} M_{WRF}$$
the **full PPM** becomes
$$P=A⋅[R∣T]$$
This gives us a powerful, complete model of how a 3D point becomes a 2D pixel.

### Homography $H$
if the scene is flat, aka all 3D points lie on a plane, the projection simplifies to a **homography**
$$\tilde m = H\cdot \tilde M$$
Where:
- $H$ -> 3x3 matrix representing the **homography**
- $\tilde{M}$ -> 2D coordinates in the plane + 1 in homogeneous coordinates

**Homographies** let you map points between:
- Two images of the same plane
- One image to a planar object (like a billboard or chessboard)
This simplifies calibration when using **planar targets**.
![[Pasted image 20250522172653.png|400]]
Our goal is to use homographies from multiple images of a flat pattern to estimate the camera's internal matrix $A$, as the homographies contain indirect info about the intrinsic parameters of the camera.
### Lens distortion
Real lenses distort the image:
- **Barrel distortion**: straight lines bow outward
- **Pincushion distortion**: lines bend inward
![[Pasted image 20250522173605.png]]
These need to be modeled using **non-linear functions** to "correct" the image.
### What is calibration
Calibration estimates:
- **Intrinsic parameters** $A$
- **Extrinsic parameters** $R, T$
- **Lens distortion coefficients**
How?
- Capture multiple images of a **known pattern** (e.g., chessboard)
- Find **2D-3D correspondences** (image corner ↔ real-world corner)
- Solve the projection equations to recover the unknowns
### Zhang's method
A Practical way to calibrate a real camera using images of a flat pattern
1. use a flat target (all $z = 0$ )
2. form $m \leftrightarrow M$ pairs, get homographies $H_{i}$
3. Each homography relates image coordinates to pattern coordinates
We need at least 4.5 points per image to compute $H_{i}$, we use more for robustness
### Refine / summary
#### Main Pipeline:
1. **Acquire n images** of a planar pattern
2. **Estimate homographies** $H_i$
3. Use $H_i$​ to compute **intrinsic matrix $A$
4. Use $A$ and $H_i$​ to compute $R_i, T_i$ for each image
5. Estimate **lens distortion coefficients**
6. Use **non-linear optimization** to refine all parameters by minimizing **reprojection error**
#### Summary
| Concept        | What It Represents                                                      |
| -------------- | ----------------------------------------------------------------------- |
| $A$            | Intrinsic matrix (focal lengths, image center, skew)                    |
| $R,T$          | Camera pose (extrinsics)                                                |
| Homography $H$ | 2D projective mapping for planar scenes                                 |
| Distortion     | Lens imperfections modeled with parameters                              |
| Zhang’s Method | Practical way to calibrate a real camera using images of a flat pattern |
## 
---
Part 2
## 6. CNN recap (Convolutional Neural Networks)
### Representation learning
**Representation learning** -> using deep learning to learn automatically from raw data the designing features (edges, shapes etc) we saw in the 1st part

In a **CNN**:
- Input image → passes through layers → abstract features are learned.
- The goal is to learn transformations that improve performance (classification, detection, etc.).

### CNN components explained for dummies -> 🐰
1. **Convolutional layers**
	- They <u>extract features</u> (edges, textures, patterns) <u>from the input image</u> by sliding kernels across
	- Each filter detects a specific type of feature, the result is a **feature map**
	- This is <u>how CNNs "see" shapes and patterns</u> in images
2. **Activation functions**
	- functions that <u>introduce non-linearity into the network to learn complex functions</u>
	- ReLU (Rectified Linear Unit), most common function, turns negative values to 0
	- Matters because a model that is a linear equation is not able to capture complex patterns
3. **Pooling layers**
	- <u>Reduce the spatial size of the feature maps</u> while keeping the most important information
	- Types: Max pooling, Average pooling (keep largest/average value in a region)
	- Reduces computation
	- Adds robustness to translations and distortions
4. **Fully connected layers**
	- <u>Connect every neuron between current/prev layers</u>
	- used for decision-making
	- This is where **classification or regression** happens, based on the features extracted earlier
5. **Loss functions**
	- <u>Measure how wrong the model's predictions are</u> compared to the actual labels.
	- Cross-entropy and mean squared error are examples of loss functions
	- Tells the network how to get better by minimizing "loss", aka being wrong
6. **Optimizers**
	- <u>Update the network’s weights to minimize the loss function</u>, it's a guide on how to learn effectively
	- Examples: SGD, Adam, RMSProp
7. **Normalization**
	- <u>Keeps the network stable</u> by standardizing the inputs to each layer
	- Speeds up training and helps prevent exploding/vanishing gradients
8. **Regularization**
	- <u>Prevents overfitting</u>, aka when the model memorizes the training data but performs poorly on new data.
	- Helps the model generalize better to unseen data.
### Gradient descent
**Gradient descend** (Optimizer) -> How the model learns, tells the model "which way" to minimize the loss function 

We want to <u>minimize</u> the cost function $J(w,b)$ (weights, biases) (aka <u>loss function</u> or error function)

Steps:
1. compute the loss $J$
2. Calculate the gradients (derivatives of the loss with respect to each parameter)
3. update parameters using the following formula
![[Pasted image 20250403164629.png]]
Where:
- $\alpha$ -> learning rate
- $\frac{\partial J}{\partial w}​,\frac{\partial J}{\partial b}$​ -> gradient of the loss
Repeat process while keeping on minimizing loss ("learning").

loss functions are full of local minima, saddle points, flat regions
![[Pasted image 20250522194656.png|500]]

==Stochastic Gradient Descent==
Gradient descent uses the entire dataset at each step, it's slow
Solution: approximation of gradient descent using small set of samples (mini-batches)
- **minibatch**-> small set of examples from 1 training set, we use 1 for stochastic method
- faster as the cost function is divided by the dimension of the minibatch
	![[Pasted image 20250403165333.png]]
- Introduces noise that prevents overfitting
- One **epoch** -> whole training set observed one time
- **Batch size** -> how many samples per update
### Optimizers
Neural networks improve using **smart optimizers** that go beyond basic gradient descent.
#### ==Momentum==
![[Pasted image 20250403165930.png]]
Accumulates a moving average of past gradients and continues to move in their direction
- The size of the step depends on how large and how aligned a sequence of gradients are
- The step size is largest when many successive gradients point in the same direction
#### ==RMSprop==
Root Mean Square Propagation (RMSprop) uses Uses a **moving average of squared gradients**
#### ==Adam==
The name “Adam” derives from “adaptive moments”, it's  combination of RMSprop and momentum

#### Hyperparameters
All optimizers require **hyperparameters** like learning rate, decay rates, etc.

### Convolutional layers
Basics
Images -> 3D tensors (height, width, channels)
Filters (kernels) -> slide over the image and extract patterns

A convolutional filter has the same depth of the input volume
![[Pasted image 20250403170733.png]]
Each filter creates an **activation map** (feature map).

Why we use **Padding** -> The convolution operator shrinks the output, so we add **padding** to the image to preserve the image size
![[Pasted image 20250403170955.png|300]]

How **Stride** works -> controls how far the filter moves (eg. stride 2 skips every other pixel, reduces output size)
![[Pasted image 20250403171110.png|300]]
### Deep CNNs, Pooling, Receptive fields
Deep CNNs are made by stacking
1. Convolution + ReLU
2. Pooling (max)
Repeated several times
Flatten -> fully connected layer(s) -> Output
![[Pasted image 20250522224917.png]]

**Pooling** -> Reduces resolution, keeps dominant features.
- **Max pooling** (most common): picks the max value in a patch.
- **Average pooling**: averages values (less common in modern CNNs).

**Receptive field** of a neuron -> the **area of the input image** it “sees”.
- Deeper layers have bigger receptive fields (from local details -> global patterns)
- large context -> we need deeper networks or bigger filters.
![[Pasted image 20250522225135.png]]
### Batch normalization
We need to stabilize networks: Activations change across laters and gradients vanish or explode
**BatchNorm** normalizes layer outputs and it's the standard in modern CNNs
Given:
- A mini-batch of activations $\{z^{(1)}, \dots, z^{(m)}\}$
- $m$ -> batch size
We do the following:
1. Compute the **batch mean** $\mu$:
	$$\mu = \frac{1}{m} \sum_{i=1}^m z^{(i)}$$
2. Compute the **batch variance** $\sigma$:
	$$\sigma^2 = \frac{1}{m} \sum_{i=1}^m (z^{(i)} - \mu)^2$$
3. **Normalize** each activation:
	$$\hat{z}^{(i)} = \frac{z^{(i)} - \mu}{\sqrt{\sigma^2 + \epsilon}}$$
	 $\epsilon$ is a small constant (e.g., $10^{-5}$) added to prevent division by zero
4. **Scale and shift** (learnable parameters):
	$$z'^{(i)} = \gamma \cdot \hat{z}^{(i)} + \beta$$
	- $\gamma$: controls the **scale** (stretching/compressing the normalized values)
	- $\beta$: controls the **shift** (moving the normalized values up/down)
### Regularization
Regularization is about **preventing overfitting**
**Dropout** -> During training, randomly remove ("drop") some neurons so the network doesn't rely on any one path too much.
**Early Stopping** ->Stop training **before** the model starts to overfit.


## 7 - Transformers
==Recurrent Neural Network (RNN)==
**RNN** -> family of neural networks for processing sequential data (sequence $x^{[t]}$ with timestep index $t$)
The parameter sharing used in recurrent networks relies on the assumption that the same parameters can be used for different time steps…

Unfolding process or RNNs advantages:  
- Same input size for each learned model
- we can use the same transition function $f$ with the same parameters at every time step

The gradient computation involves performing a forward propagation pass moving left to right through the unrolled graph, followed by a backward propagation pass moving right to left through the graph

==Encoder-Decoder==
- An **encoder** processes the input sequence. The encoder emits the context C, usually as a function of its final hidden state  
- A **decoder** is conditioned on that fixed-length vector to generate the output sequence

==Attention mechanism== -> dynamic weight adjustment function based on an attention function
The function encodes a subset of the input vectors adaptively when decoding the translation
![[Pasted image 20250410153057.png]]
**Attention scores** (purple dots) -> dot product between (in the image) each blue vector and green transposed vector (results in a number = a single purple dot), the purple score vector we get as a result is used to predict the output of the decoder.

Then we concatenate or sum the purple vector with the green one, used for the output layer computation (which is our prediction)

==Transformer== -> first model relying entirely on self-attention  
(and cross-attention) to compute representations of its input and output without using RNNs or convolution
At each step the model is auto-regressive, consuming the previously  
generated symbols as additional input when generating the next

==Transformer Encoder==
It's composed of a stack of N identical layers
each layer has:
- a (multi)head self-attention mechanism
- a feed-forward network

==Transformer Decoder==
It always takes the last layer of the encoder, they have the same number of layers
![[Pasted image 20250410163254.png]]
each step it shows you only previously predicted tokens, while hiding future ones

**Self-attention** -> learns representations of the input sequence, trough queries, keys and values $(Q, K, V)$ vectors, mappings of the same token
$$Attention(Q,K,V)=softmax(\frac{QK^T}{\sqrt d_k})V$$
$dmodel$ -> dimension of the heap
$L$ -> length of the sequence
dimensionality of the vectors -> $L \times dmodel$ 

the output maintains this dimensionality
![[Pasted image 20250410165655.png]]

**Multi-Head Attention** -> linearly project the queries, keys and values h times with different, learned linear projections
![[Pasted image 20250410170920.png]]
Multi-head attention allows the model to jointly attend to information from different representation subspaces at different positions

TODO: look for a video tutorial that explains self attention for transformers, slides are terrible 

##

# Exam experiment
## Topic Ideas
has to be lightweight for the few resources we have
- OCR
	1. Efficient OCR
		- https://arxiv.org/html/2304.02737v2
		- https://github.com/dell-research-harvard/efficient_ocr
- 2D to 3D
	1. 2DGuidedLight3D
		- https://arxiv.org/pdf/2212.08334
		- https://github.com/OPradelle/2DGuidedLight3D
	2. Improving 2D Feature Representations by 3D-Aware Fine-Tuning
		- https://arxiv.org/abs/2407.20229
		- https://github.com/ywyue/FiT3D
## Improving 2D Feature Representations by 3D-Aware Fine-Tuning

### **Abstract**

The paper proposes a two-stage approach to enhance 2D visual foundation models (e.g., DINOv2) by integrating 3D awareness. It lifts 2D features into a 3D Gaussian representation, enabling multi-view rendering, and then fine-tunes the original 2D model using these 3D-aware features. This improves performance on downstream tasks like semantic segmentation and depth estimation.

---

### **1. Introduction**

- **Problem**: Current vision models trained on 2D images lack true 3D scene understanding.
    
- **Motivation**: Human vision uses 3D structure cues for better understanding. Models should do the same.
    
- **Proposal**: A two-stage pipeline:
    
    1. Lift 2D features to a 3D Gaussian representation.
        
    2. Use the rendered 3D-aware features to fine-tune 2D models.
        

---

### **2. Related Work**

- **2.1 2D Representation Learning**: Overview of self-supervised learning (e.g., DINO, CLIP), but all trained only on 2D data.
    
- **2.2 Distilled Feature Fusion Fields**: Past works distill 2D features into 3D, e.g., NeRFs. This paper goes further by transferring them back into 2D models.
    
- **2.3 Injecting 3D Priors to 2D**: Most methods fuse 2D into 3D but don’t enhance 2D models with 3D awareness — this paper addresses that gap.
    

---

### **3. Method**

- **3.1 Lifting Features to 3D**:
    - Multi-view 2D features are encoded into 3D Gaussians.
    - ==3D Gaussian Splats== are used for this (a method that models 3D scenes as a collection of transparent, view-dependent blobs (Gaussians))
	    - $\mu$ -> position
	    - Scale, Rotation $s, R$ -> shape and orientation
	    - Opacity $\alpha$
	    - color parameters (SH) -> view dependent RGB info using spherical harmonics
	    - feature vector (f) -> this is the key! Each Gaussian carries a _semantic feature vector_ distilled from 2D features.
        
    - Each Gaussian stores color and a low-dimensional feature vector.
        
    - A CNN decoder up-projects the low-dim feature map after rendering.
    - This two-step projection is crucial due to memory constraints. Storing full 384-dim features per Gaussian would be too heavy.
    - Feature vectors are optimized to fit these 3d gaussians, minimizing a combined loss (`L_total = L_color (RGB image error) + L_feat (feature reconstruction error)`)
        
- **3.2 3D-Aware Fine-Tuning**:
    - Fine-tune the original 2D feature extractor using 3D-rendered features.
    1. **Pre-load** all the 3D Gaussians + CNN decoders for all scenes (to save time).
	2. **For each step**:
	    - Sample an image `Ii` and its camera pose `Pi`.
	    - Use the associated Gaussian `G` to render the high-dim feature map `Fhigh`.
	    - Compare this to the current model’s prediction `ε2D(Ii)` using an L1 loss.
	    - Update the model weights via backprop.
	- Efficient: only 1 epoch required, low memory/computation overhead.
        
- **3.3 Linear Probing for Downstream Tasks**:
	- Once the 2D model is fine-tuned:
	- Keep it frozen.
	- Train a **linear head** (single layer neural network, basically acting to give us the output) on the output features for:
	    - **Semantic segmentation** (per-patch class prediction).
	    - **Depth estimation** (bin classification from patch features + \[CLS\] token).
	- Optionally, **concatenate original features with fine-tuned ones** to retain generalization while gaining 3D awareness.

Linear head analogy -> If the pre-trained model is like a **language**, the linear head is a **simple translator**. If the language is expressive and consistent (good features), the translator can do a good job with minimal effort. If the features are weak, even a smart translator won’t help much.


- **Why use Gaussians?** Fast optimization + real-time rendering + flexibility.
- **Why not train end-to-end?** Memory and time constraints, plus they show you can get strong gains with this two-step approach.
- **Why it works**: Multi-view lifting forces 2D features into geometrically consistent representations, which then teach the 2D model implicit 3D structure.

---

### **4. Experiments**

- **4.1 Datasets**: Use ScanNet++ for training and various indoor/outdoor datasets for evaluation.
    
- **4.2 Implementation Details**:
    
    - DINOv2 is fine-tuned for 1 epoch.
        
    - Feature Gaussians trained using multi-view images.
        
- **4.3 Within-domain Evaluation**:
    
    - Significant improvements in segmentation and depth tasks on ScanNet++, NYUv2, and ScanNet.
        
- **4.4 Out-of-domain Evaluation**:
    
    - Gains are generalizable to ADE20K, Pascal VOC, and KITTI datasets.
        
- **4.5 Generalization to Other Vision Models**:
    
    - Method improves other models like CLIP, MAE, DeiT-III, showing versatility.
        
- **4.6 Ablation Studies and Analysis**:
    
    - **Feature dimension**: 64 is a sweet spot between performance and memory.
        
    - **Assembly strategy**: Feature concatenation works best.
        
    - **Epochs**: 1 epoch sufficient; more can reduce generalization.
        
    - **Adapter vs. fine-tuning**: Fine-tuning is simpler and just as effective.
        

---

### **5. Conclusion**

- The proposed 3D-aware fine-tuning significantly improves the performance of 2D vision models.
    
- Demonstrates transferability and generalization.
    
- Future work could expand on more diverse 3D datasets.
    

---

### **Appendices**

- **A**: ViT variant results — works for ViT-B as well as ViT-S.
    
- **B**: Performance on classification tasks and with more complex heads (e.g., DPT).
    
- **C**: Experiments confirm that gains are due to 3D-aware features, not just increased feature dimensions.
    
- **D**: Visual analysis (PCA, clustering) shows cleaner, more detailed feature maps after fine-tuning.
    

---

##

# Theory questions
## **Image Formation Process**

- **What is the role of the pinhole camera model in understanding the image formation process?**  
    The pinhole camera model provides a simplified mathematical framework to describe the projection of a 3D scene onto a 2D image plane. It models the camera as having an infinitesimal aperture (no lens) and relates 3D coordinates to 2D image coordinates through simple geometric relationships.
- **How does the perspective projection model relate 3D scene points to their 2D image projections?**  
    This model relates the coordinates of a point in 3D space (x1, x2, x3) to its corresponding 2D image coordinates (y1, y2). This mapping results in a loss of depth information, making it challenging to infer the 3D structure from a single 2D image.
- **What is the correspondence problem in stereo vision, and how is it solved?**  
    The correspondence problem involves finding matching points in two stereo images that correspond to the same 3D scene point. It is solved using techniques like disparity computation and triangulation, which estimate the depth of scene points based on the relative positions of corresponding points in the two images.
    
- **Explain the concept of epipolar geometry and its importance in stereo vision.**
    Epipolar geometry describes the geometric relationships between points observed in two images taken from different viewpoints. It constrains corresponding points to lie on corresponding epipolar lines. This constraint simplifies the search for point correspondences and is essential for stereo vision and 3D reconstruction.
    

## **Spatial Filtering**

- **What are the differences between convolution and correlation in image processing?**
    Convolution: The kernel is flipped before sliding it over the image, defined as: $o(x, y) = \sum_{m,n}^{i}(m, n) * h(x−m, y−n)$
    Correlation: The kernel is not flipped: $o(x, y) = \sum_{m,n}^{i}(m, n) ° h(m−x, n−y)$
    
- **Why is the Gaussian filter preferred over the mean filter for smoothing images?**
    The Gaussian filter assigns higher weights to pixels closer to the center, making it better for preserving image structures during smoothing. The mean filter assigns equal weights to all pixels in the neighborhood, which can lead to blurring and loss of image details.
    
- **How does the bilateral filter help preserve edges while denoising an image?**  
    The bilateral filter preserves edges by considering both spatial and intensity differences. Pixels that are spatially close and have similar intensity values contribute more to the smoothing process, avoiding blurring at edges.

## **Edge Detection**

- **How does the Canny Edge Detector use hysteresis thresholding to prevent noisy edges?**
    Hysteresis thresholding uses two thresholds, T1 (high) and T2 (low), to track edges. An edge is accepted if its gradient magnitude exceeds T1​ or if it exceeds T2 and is connected to a stronger edge. This approach prevents fragmented edge detection caused by noise.
    
- **What is the Laplacian of Gaussian (LoG) kernel, and how is it used in edge detection?**
	The LoG kernel combines Gaussian smoothing with the Laplacian operator to detect edges. It smooths the image to reduce noise and then detects zero-crossings in the second derivative to identify edges.
    
- **What are the key steps in an edge detection pipeline, and why are they important?**
	The edge detection pipeline typically includes:  
    Noise Reduction: Smooth the image using a filter like the Gaussian filter to reduce noise, which otherwise could lead to false edge detection.  
    Gradient Computation: Compute the gradients of the image in the x and y directions to identify areas with rapid intensity changes.  
    Non-Maxima Suppression (NMS): Thin the detected edges by keeping only local maxima in the gradient magnitude along the direction perpendicular to the gradient vector.  
    Hysteresis Thresholding: Use two thresholds: a high threshold to confirm strong edges and a low threshold to extend weak edges connected to strong ones.  
    Edge Linking: Connect remaining edge points to form continuous edge contours.
## **Local Features**

- **Why are corners better features than edges for object matching in images?  
    **Corners provide distinctive features that are repeatable across different images, whereas edges are locally ambiguous and hard to match reliably. Corners exhibit significant variation in intensity in all directions, making them robust keypoints.
    
- **How does the Harris corner detector improve upon the Moravec corner detector?  
    **The Harris corner detector uses a continuous formulation and a Gaussian weighting function, making it more robust to rotation and illumination changes compared to the Moravec detector.
    
- **What are the main invariance properties desirable for feature detection?**  
    Good feature detectors should be invariant to transformations such as rotation, scale changes, and illumination variations. This ensures reliable feature matching across different views of the same scene.
    
- **What is blob detection and how does it differ from edge detection?  
    **Blob detection identifies regions in an image that differ in properties such as intensity or color compared to surrounding areas. While edge detection focuses on finding boundaries between regions, blob detection finds entire regions (blobs) that are brighter or darker than their surroundings. Blob detection is often used in applications like object tracking, feature detection, and keypoint localization.  
    Common Blob Detection Techniques:  
    - Laplacian of Gaussian (LoG): Identifies blobs as zero-crossings of the Laplacian of the image after Gaussian smoothing.  
    - Difference of Gaussians (DoG): Approximates LoG by subtracting two Gaussian-blurred versions of the image.
    

## **Convolutional Neural Networks (CNNs)**

- **What are the key layers in a CNN, and what roles do they play?  
    **Convolutional layers: Extract features by applying filters to the input image.  
    Pooling layers: Downsample feature maps to reduce computational complexity.  
    Normalization layers: Stabilize and speed up the learning process.
    
- **How does parameter sharing in convolutional layers reduce computational complexity?**  
    Parameter sharing reduces computational complexity by using the same filter weights across different spatial locations in the input image. This makes CNNs efficient and translation-invariant.
    
- **What is the purpose of the pooling layer in CNNs?**  
    Pooling layers reduce the spatial dimensions of feature maps, making the network computationally efficient and less sensitive to small translations in the input image.
    

## **Object Detection**

- **What is instance-level object detection, and how does it differ from category level detection?**  
    It identifies specific occurrences of an object in an image (e.g., detecting a specific bottle), whereas category-level detection identifies general categories regardless of appearance or pose (e.g., detecting any car). Instance-level detection often deals with limited variability, while category-level detection faces higher variability and typically requires deep learning techniques.
    
- **How does template matching work, and what are its limitations?**  
    In template matching, the model image is slid across the target image, comparing pixel intensities using metrics like Sum of Squared Differences (SSD) or Zero-Mean Normalized Cross-Correlation (ZNCC).  
    Limitations:  
    Computationally expensive for large images.  
    Not robust to scale, rotation, or intensity changes.
    
- **What is the purpose of the Hough Transform in object detection?**  
    The Hough Transform detects objects with known shapes (e.g., lines, circles) by mapping image points into a parameter space. By detecting intersections in this space, it identifies shapes even if they are partially occluded or noisy.
    
- **What is a backbone in object detection networks?**  
    A backbone is a feature extractor (usually a pre-trained CNN) used in object detection architectures to compute meaningful representations of the input image. Examples: ResNet, VGG, and EfficientNet.
    
- **Why is ResNet a popular backbone in computer vision tasks?  
    **ResNet uses skip connections (residual learning) to solve the vanishing gradient problem, enabling the training of very deep networks. It balances computational efficiency and accuracy, making it a go-to backbone for many object detection frameworks.
    
- **What are Feature Pyramid Networks (FPNs), and why are they useful?**  
    FPNs enhance object detection by leveraging features at multiple scales (pyramidal structure). They combine low-resolution, high-semantic features with high-resolution, low-semantic features, improving small object detection.
    
- **How do Region-based CNNs (R-CNNs) work?**  
    R-CNNs first generate region proposals and then classify each region using a CNN. Fast R-CNN improved efficiency by sharing CNN computation across all proposals. Faster R-CNN introduced a Region Proposal Network (RPN) for faster proposal generation instead of using Selective Search.
    
- **What is Single Shot MultiBox Detector (SSD), and how does it differ from R-CNNs?**  
    SSD directly predicts object classes and bounding boxes without the need for region proposals, making it faster than R-CNNs. SSD uses multiple feature maps at different resolutions for detecting objects of various sizes.
    

## **Segmentation**

- **What is the difference between image segmentation and instance segmentation?**  
    Image segmentation: Divides the image into meaningful regions (e.g., separating background and foreground).  
    Instance segmentation: Not only segments objects but also differentiates between multiple instances of the same category.
    
- **How does the U-Net architecture work in segmentation tasks?**  
    U-Net has a contracting path (encoder) to capture context and an expanding path (decoder) to enable precise localization. It is widely used for biomedical image segmentation.
    

## **Metric Learning**

- **What is a Siamese Network, and where is it used?**  
    A Siamese Network consists of two identical subnetworks that process two inputs and output their similarity. It is commonly used in tasks like face verification and signature matching.
    
- **How does the triplet loss function work in metric learning?**  
    Triplet loss minimizes the distance between an anchor and a positive example while maximizing the distance between the anchor and a negative example: Loss = max(d(A, P) − d(A, N) + α, 0), where α is a margin parameter.
    

## **Transformers**

- **How do Vision Transformers (ViTs) work differently from CNNs?**  
    Unlike CNNs, which rely on convolutions for feature extraction, ViTs use a self-attention mechanism to model global relationships between patches in an image. Images are divided into patches, which are linearly embedded and processed through multiple attention layers.
    
- **What is the role of positional encoding in ViTs?**  
    Since transformers do not have inherent spatial awareness, positional encoding is added to the input embeddings to retain spatial information.
    
- **Why is multi-head self-attention important in transformers?**  
    Multi-head self-attention allows the model to learn different types of relationships between patches by projecting the input into different subspaces simultaneously.