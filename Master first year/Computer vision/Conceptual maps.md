🐰 i cannot fathom to remember anything about theory, i can't explain theoretical concepts no matter how much i try to understand them, they slip my mind. I'll try making conceptual maps to train me more to remember
## 1. Image Formation Process
Getting a 3D scene into a 2D image
1. Geometric information
	1. Perspective projection
	2. Stereo vision
2. Digitization
	1. Sensors for sampling (space/colour) and quantization (light)
## 2. Spacial Filtering
Reduce noise in images
1. Concept of denoising
2. Filters, compute new RGB value for each pixel
3. Linear and Translation-Equivariant type of filter
4. Convolution properties
5. Discrete convolution -> sum product of the 2 signals with 1 being reflected
6. Filters
	1. Linear
		1. Mean filter
		2. Gaussian filter -> further pixels are less important
	2. Non-Linear
		1. Median filter -> middle value
		2. Bilateral filter -> further or different pixels are less important
		3. Non-local Means filter -> find similar patches
## 3. Edge Detection
1. 1D step edge -> 1st derivative
2. 2D Gradient -> compute partial derivatives to get direction and strength
3. Discrete approximation -> differences in pixels
4. Noise
	1. Prewitt and Sobel operators -> decide weights of current pixel based on brightness difference of surroundings
5. Non-Maxima Suppression (NMS)
	- Find local maxima along gradient
	- Estimate direction locally (with Lerp from closest pixels)
	- Thresholds
6. Canny's criteria
	1. Good detection
	2. Good localization
	3. One response, one edge
7. Canny's edge detector PIPELINE
	1. Gaussian smoothing
	2. Gradient computation
	3. Non-maxima suppression
	4. **Hysteresis** thresholding
8. 2nd order derivative methods
	1. zero crossing
	2. Laplacian operator (sum of 2nd order derivatives) approximation
9. Laplacian of Gaussian (LoG) PIPELINE
	1. Gaussian smoothing
	2. Apply Laplacian operator
	3. Find zero-crossings
	4. localize edge at sign change
10. Summary
	- ![[Pasted image 20250519164759.png]]
## 4. Local Features
find **Local invariant features** (corresponding points) in images
1. Three-stage pipeline
	1. Detection
	2. Description
	3. Matching
2. Properties
	- Detector
		- Repeatability  
		- Saliency
	- Descriptor
		- Distinctiveness vs. Robustness Trade-off -> get invariant info
		- Compactness
	- Desirable **speed** for both
3. Corner detectors
	1. **Moravec detector** -> look at patches and compute cornerness (high variation)
	2. **Harris corner detector** 
		1. Compute gradients around point of interest, create matrix with results
		2. Compute corner score with matrix
		3. Threshold & NMS to pick the best corners
	3. Invariance properties of harry's detector
		1. Rotation invariance
		2. Partial illumination invariance (only uniform shift)
4. Scale space -> concept of same img at different scales
5. Linderberg (multi-scale detection)
	1. Use scale normalized derivatives
	2. Normalize filter responses
	3. Search extrema in 3D
6. LoG -> second order derivative that detects **blobs** (circular structures)
##