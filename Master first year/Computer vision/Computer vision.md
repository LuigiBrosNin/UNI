
> Notes taken by Luizo ( [@LuigiBrosNin](https://t.me/LuigiBrosNin) on Telegram)


- Exam
	- An exam consisting of two parts:
	- First part (project):
	- Send prof a list of three articles you are interested in, preferably with the available code. The choice should be based on articles published in the conferences or journals listed in the next slide.
	- you will need to thoroughly study the prof selected article and its related code to replicate at least one experiment presented in the article or conduct a test of your interest by modifying the technique you have studied.
	- If the code is not available, the student should try to re-implement the relative model and replicate one experiment 
	- Prepare a 20-minute presentation that describes the technique proposed in the chosen article and the experiment you conducted.
	- During or at the end of the presentation, I will ask you questions about the work you have done.
	- Second part
	- you will answer general questions on the theory presented in the course.


# Theory
Slides seem to be good, and are very visual. I don't feel like just adding a phrase and pasting the slide, so i'll freeze notes for now, see what to do of them, studying to slides to understand might be better. Maybe notes to remember definitions, as in summaries.

## 0 
## 1 - Image Formation Process
 how images get captured by tools
==**Pinhole camera model**== ->
![[Pasted image 20250220151912.png]]

**Perspective Projection** -> The geometric model of image formation in a pinhole camera
![[Pasted image 20250220152517.png]]
we want to find a relationship between 3d and 2d points:
![[Pasted image 20250220152859.png]]
The above formulas are true because of triangular similarity
![[Pasted image 20250220153320.png]]
![[Pasted image 20250220153936.png]]

Slides seem to be good, and are very visual. There are 41 slides and i don't feel like just adding a phrase and pasting the slide, so i'll freeze notes for now, see what to do of them, studying to slides to understand might be better. Maybe notes to remember definitions, as in summaries.
## 


## 

# Summaries
## 0 - Intro
**Computer vision** -> deals with extraction of information from images (eg. pic of a bird -> "This is a bird!")

## 1 - Image Formation Process
#TODO
## 2 - Spacial Filtering
==Denoising==
We can denoise an image by taking a mean across time (multiple images)
With a single image, we can compute a mean across neighbouring pixels (mean across space)

==**Image Filters**== -> Image processing operators that compute the new intensity (colour) of a pixel, $p$, based on the intensities (colours) of the support (neighbourhood) of $p$. They accomplish useful stuff such as denoising/sharpening.
- **Linear and Translation-Equivariant (LTE)** filter subclass operators, used as feature extractors in CNNs (Convolutional Neural Networks)
**Signal theory** -> their application in image processing consist in a <u>2D convolution</u> between the input image and the <u>impulse response function</u> (point spread function or kernel) of the LTE operator.

**Linear operator** $T\{\cdot\}:o(x,y)$ -> Given an input 2D signal $i(x,y)$ and a 2D linear operator 
$$T\{i(x,y)\} \text{ is Linear} \iff T\{\alpha i_{1}(x,y) + \beta i_{2}(x,y)\} = \alpha o_{1}(x,y) + \beta o_{2}(x,y)$$
$$\text{with }\quad o_{1}=T\{i_{1}\} \land o_{2}=T\{i_{2}\} $$
$\alpha \beta$ -> constants

**Translation-equivariant operator** ->
$$T\{i(x,y)\} \text{ is Translation-equivariant } \iff T\{i(x-x_{0}, y-y_{0})=o(x-x_{0},y-y_{0}\}$$

 if we have an LTE operator ->  output signal is given by the <u>convolution</u> (mathematical operation on two functions that produces a third function) between the **input signal** and the **impulse response** (point spread function) $h(x,y)=T\{\delta (x,y)\}$ of the operator ($\delta$ -> Unit impulse)
 
 ==Convolution proprieties==
 - Associative property
 - Commutative property
 - Distributive property with the sum
 - Convolution Commutes with Differentiation

==Correlation==
![[Pasted image 20250305192216.png]]
🐰? tbh i'm having trouble understanding what's all this for, and what this means

if $h$ is an even function ($h(x,y) = h(-x,-y)$) -> $i*h=h*i=h\circ i$ (where * is convolution, $\circ$ is correlation) 

**Discrete convolution** -> consists in summing the product of the two signals where one has been reflected about the origin and translated.
![[Pasted image 20250305194345.png]]
In a practical implementation, we cycle trough the kernel from $-k$ to $+k$ instead of the infinities (duh)
To solve the border issue, we either CROP or PAD the image

**==Mean Filter==** -> replace pixel intensity with the average intensity of neighbourhood 
Fastest way to denoise an image

**==Gaussian Filter==** -> LTE operator whose impulse response is a 2D Gaussian function (aka having gaussian distribution)(with zero mean and constant diagonal covariance matrix)

$\sigma$ param -> amount of smoothing by the filter (higher -> more blurry)

🐰for practical implementation, i genuinely didn't understand a thing.

Size of the filter given $\sigma$ -> with interval $[-3\sigma,3\sigma]$, captures 99% of the area (“energy”)
of the Gaussian function, we take $(2k+1)\times(2k+1)$ kernel with $k=[3\sigma]$

Deploying the separability property speeds up the filtering operation ( one 2D gaussian split into two 1D convolutions)

==Median Filter== -> Non linear filter, each pixel intensity is replaced by the median over a given neighbourhood, the median being the value falling half-way in the sorted set of intensities.
![[Pasted image 20250305195940.png|200]]
⚠ Gaussian-like noise, such as sensor noise, cannot be dealt with by the Median, as this would require computing new noiseless intensities.

==Bilateral Filter== -> Advanced non-linear filter to accomplish denoising of Gaussian-like noise without blurring the image (aka edge preserving smoothing).

==Non-local Means Filter== -> non-linear edge preserving smoothing filter. The key idea is that the similarity among patches spread over the image can be deployed to achieve denoising.
## 3 - Edge Detection
(Everything is in grayscale)
**Eges** -> seen as sharp changes of a 1D signal
- We use **derivatives** to detect edges with thresholds for detection
- We use **partial derivatives** to detect edges in 2d to detect the direction of the edge
- We can approximate the gradient with difference 
	- Backward differences -> $(i) - (i-1)$
	- Forward Differences -> $(i+1)-(i)$
	- Central differences -> $(i+1) - (i-1)$
	- Correlation kernels -> $\begin{bmatrix}-1&0&1\end{bmatrix}\ \begin{bmatrix}-1\\0\\1\end{bmatrix}$
- We can estimate magnitude using different approximations, best one is the max of $|I_{x}|,|I_{y}|$
	- $I$ -> Image, $\Delta I$ -> Gradient at every position
	- $|\Delta I|_{\max} = \max(|I_{x}|,|I_{y}|)$

Noise cause problems in image detection, we incorporate the smoothing process of the image when detecting edges (i take the average of a group of pixels compared to the average of another group)
==Prewitt and Sobel==
- **Prewitt operator** -> approximating partial derivatives by central differences
	![[Pasted image 20250227171204.png]]
- **Sobel operator** -> central pixel weight
	![[Pasted image 20250227171301.png]]
#TODO FINISH 12 -> 28
## 4 - Local Features
We want to find **Corresponding Points** between 2+ images of a scene
![[Pasted image 20250320153021.png|500]]
**Correspondences** -> image points which are the projection of the same 3D point in different views of the scene

3 successive steps for defining correspondences:  
- **Detection** of salient points (aka keypoints, interest points, feature points...)  
- **Description** -> computation of a suitable descriptor based on pixels in the keypoint neighbourhood  
- **Matching** descriptors between images  

==Detectors/Descriptors good properties==
- Detector
	- **Repeatability** -> find the same keypoints in different views  
	- **Saliency** -> find keypoints surrounded by informative patterns 
- Descriptor  
	- **Distinctiveness vs. Robustness Trade-off** -> capture the salient information around a keypoint, disregard changes due to nuisances (e.g. light changes) and noise  
	- **Compactness** -> description as concise as possible
- Desirable **speed** for both

==Moravec Interest Point Detector==
Look at patches in the image and compute cornerness
![[Pasted image 20250320154429.png|150]]

==**Harris Corner Detector**== -> to find corresponding points, we rely on a continuous formulation of the Moravec's error function, based on the weighted sum of derivatives around the point of interest (aka, i look at points around the interested one to figure out if it's somewhat the same one, eg:)
![[Pasted image 20250306152512.png|400]]
1. Compute C at each pixel
2. Select all pixels where C is higher than a chosen positive threshold (T)
3. Within the previous set, detect as corners only those pixels that are local maxima of C (NMS)

==Invariance properties==
**Rotation invariance** -> eigenvalues of M (M encodes the local img structure around the considered pixel) are invariant to a rotation of the image axes, thus so is Harris cornerness function

**No invariance to an affine intensity change** ->
- Yes, for additive bias ($I' = I+b$) due to the use of derivatives
- No, to multiplication by a gain factor ($I'=a\cdot I$) => derivatives gets multiplied by the same factor

**No scale invariance property** -> Harris is not scale invariant
- An image contains features at different scales -> Detecting all features requires to analyze the image across the range of scales “deemed as relevant”
	![[Pasted image 20250306153923.png|400]]
- We detect features in order to match their **descriptors**
- To compute and match descriptors we need to smooth out the details that do not appear across the range of scales

==Scale-space==
**Key finding** -> apply a <u>fixed-size detection</u> tool on increasingly <u>down-sampled</u> and <u>smoothed</u> versions of the input image
![[Pasted image 20250306154726.png|400]]

==Gaussian Scale-Space==
**Scale-Space** -> a one-parameter family of images created from the original one so that the structures at smaller scales are successively suppressed by smoothing operations.
It must be realized by <u>Gaussian Smoothing</u>.

criterion to select their characteristic scale -> finding their **extrema**

Scale-normalized Laplacian of Gaussian (LOG)
![[Pasted image 20250306162610.png]]

==Multi-Scale Feature Detection==
Features (Blob-like) and scales detected as extrema of the scale-normalized LOG
![[Pasted image 20250306162700.png]]

==Difference of Gaussian (DoG)== -> very close approximation of Lindeberg's scale-normalized LOG
- Detect keypoints by seeking for the extrema of the DoG (Difference of Gaussian) function across the $(x,y,\sigma)$ domain (different adjacents in the scale)
	![[Pasted image 20250306163056.png]]

==Keypoint Detection and Tuning==
**Extrema detection** -> a point is detected as a keypoint $\iff$ its DoG is higher (lower) than that of the 26 neighbours (in 3D)
![[Pasted image 20250306164454.png]]
We can prune weak responses to receive a better result, as DoG extrema is scarcely repeatable

Trough this method we can find the best scale since we're defining the point to a specific scale (it's hard to understand, just know that DoG helps us find the optimal scale for each detail we want to "classify")
![[Pasted image 20250306165051.png]]

==Scale and Rotation Invariance Description==
Defining scale and rotation invariant description -> same $\sigma$ = same scale, but rotation descriptors are not invariant, so it's not trivial

==Exemplar DoG keypoints==
We take pixel coordinates in the local reference frame to identify a direction inherent to the patch, called **canonical orientation**, and we define it as a **local reference frame**
![[Pasted image 20250306170348.png]]

**Rotation invariance** -> a canonical (aka characteristic) patch orientation is computed, so that the descriptor can then be computed on a **canonically-oriented** patch

![[Pasted image 20250306170554.png|250]]

==Canonical Orientation==
Given the keypoint, the **magnitude** and **orientation** of the gradient are <u>computed at each pixel of the associated Gaussian-smoothed image</u>, L:
![[Pasted image 20250306170924.png]]
The characteristic orientation of the keypoint is given by <u>the highest peak of the orientation histogram</u>
![[Pasted image 20250306171013.png]]

==SIFT Descriptor==
The SIFT (Scale Invariant Feature Transform) descriptor is computed as follows
![[Pasted image 20250306171107.png]]
-  A 16x16 <u>oriented</u> pixel grid around each keypoint is considered  
-  This is further divided into 4x4 regions (each of size 4x4 pixels)  
-  A gradient orientation histogram is created for each region  
-  Each histogram has 8 bins (i.e. bin size 45°)  
-  Each pixel in the region contributes to its designated bin according to  
	-  Gradient magnitude  
	-  Gaussian weighting function centred at the keypoint (with σ equal to half the grid size)
🐰 I did not understand the point of this yet
This is used to generate descriptors to match, and the Feature vector is the output

==Matching process==
**Nearest Neighbour (NN) Search problem** -> Given a set $S$ of points, $p_i$, in a metric space $M$ and a query point $q \in M$, find the $p_i$ closest to $q$.

==Validating Matches==
Enforce criteria to judge matches found by the NN search process, usually a threshold

==Efficient NN-Search==
indexing techniques are exploited to speed up the otherswise slow NN-search process
- k-d tree
- Best Bin First (BBF)




## 5 - Camera Calibration
**Perspective projection** model -> Given a point in the 3D space, $M=[x,y,z]^T$ , with coordinates given in the Camera Reference Frame (CRF).
![[Pasted image 20250320170447.png|250]]

coordinates as a function of teh 3D coordinates in the CRF
$$
\begin{cases}u=\frac{f}{z}x\\ v=\frac{f}{z}y \end{cases}
$$

#TODO 4 -> 41


##
##
##

# Exam experiment
## Topic Ideas
lightweight
2d image to 3d polygon
OCR
