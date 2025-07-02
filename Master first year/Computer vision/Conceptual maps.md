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
	- find local maxima along gradient
	- estimate direction locally (with Lerp from closest pixels)
	- Thresholds