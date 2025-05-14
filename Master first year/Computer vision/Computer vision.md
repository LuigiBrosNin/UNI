
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

# Summaries
## 0 - Intro
**Computer vision** -> deals with extraction of information from images (eg. pic of a bird -> "This is a bird!")

## 1 - Image Formation Process
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

**Pinhole cameras** have infinite depth of field but poor light gathering.
**Lenses** ->
- focus light more effectively
- limited depth of field
- follow the thin lens equation


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

**Noise** causes problems in image detection, we incorporate the smoothing process of the image when detecting edges (i take the average of a group of pixels compared to the average of another group)
==Prewitt and Sobel==
- **Prewitt operator** -> approximating partial derivatives by central differences
	![[Pasted image 20250227171204.png]]
- **Sobel operator** -> central pixel weight
	![[Pasted image 20250227171301.png]]
A good approach to detect edges consists in finding the **local maxima** of the absolute value of the derivative of the signal
![[Pasted image 20250407231227.png|300]]

==Non-Maxima Suppresion (NMS)==
We should look for the maxima along the gradient direction in images (2D signals)
![[Pasted image 20250407231818.png|600]]
- We cannot know in advance, so we estimate it locally each time
- The magnitude of the gradient has to be estimated at points outside the discrete pixel grid
- We do it by linear interpolation from the closest points belonging to the grid (we base our magnitude by theoretical points that we calculate mathematically, eg. A,B in the example)
	![[Pasted image 20250407232325.png|300]]
	
- After the NMS, we apply a threshold on the magnitude of the gradient to get rid of unwanted edges

==Canny’s Edge Detector==
Quantitative criteria to measure edge detection performance, and then apply the optimal filter for the best result
- Good detection -> extract edges even in noisy images
- Good localization -> minimize found edge and true edge distance
- One response to one edge -> one single edge pixel detected at each true edge
Canny shows that the optimal edge detection operation consists in finding local extrema of the convolution of the signal by a first order Gaussian derivative (i.e. G’(x))
- Edge **streaking** may occur when magnitude varies along object contours
- **hysteresis** thresholding -> approach relying on a higher $(T_h)$ and a lower $(T_l)$threshold.
	- Pixel taken as edge IF:
	- gradient magnitude > $T_h$ <u>OR</u>
	- gradient magnitude > $T_i$ <u>AND</u> pixel is a neighbor of an already detected edge

==Zero-crossing==
![[Pasted image 20250407234936.png|300]]
Look for the zero crossing point in the 2nd derivative (computationally significant)

==Discrete Laplacian==
We can use Laplacian as second order differential operator
**Laplacian** -> using forward and backward differences to approximate derivatives

==Laplacian of Gaussian (LOG)==
robust edge detectors should include a smoothing step to filter out noise
**LOG** conceptually:
- Gaussian smoothing
- Second order differentiation by the Laplacian  
- Extraction of the zero-crossing
- Once a sign change is found, the actual edge may be localized at the pixel where the absolute value of the LOG is smaller (best choice) or either pixel towards the positive or negative side.

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
---
Part 2
## 6 - CNN (recall) (Convolutional Neural Networks)
![[Pasted image 20250403153929.png]]
:LiArrowBigUp: good slide to make a theory summary check

==Gradient descend== ->first-order iterative algorithm for minimizing a differentiable multivariate function (**differentiable** -> a function whose derivative always exists in its domain, **multivariate** -> more than one variable) 

- We want to minimize the cost function (aka loss function or error function)
- Derivatives tell us how to change $x$ so we can improve $y$ trough $x$ .
- We can find **local minima**, and it's possible that it is not globally optimal, we're gonna take this into account when optimizing

Formula for reaching the minimum
![[Pasted image 20250403164629.png]]

==Stochastic Gradient Descent==
- approximation of gradient descent using small set of samples
- **minibatch**-> small set of examples from 1 training set, we use 1 for stochastic method
- faster as the cost function is divided by the dimension of the minibatch
	![[Pasted image 20250403165333.png]]
- One **hyperparameter** is a minibatch dimension, usually a power of 2, there are more hyperparameters
- One **epoch** -> whole training set observed one time

==Momentum optimizer==
![[Pasted image 20250403165930.png]]
Accumulates an exponentially decaying moving average of past gradients and continues to move in their direction
- The size of the step depends on how large and how aligned a sequence of gradients are
- The step size is largest when many successive gradients point in the same direction

==RMSprop optimizer==
Root Mean Square Propagation (RMSprop) uses an exponentially decaying average to discard history from the extreme past so that it can converge rapidly

==Adam optimizer==
The name “Adam” derives from “adaptive moments”, it's  combination of RMSprop and momentum

==Hyperparameters optimizer==
tuning the learning rate hyperparameter

==Convolutions and filters==
A convolutional filter has the same depth of the input volume
![[Pasted image 20250403170733.png]]

==Convolutional Layers==
the convolution operator shrinks the output, so we add **padding** to the image to preserve the image size
![[Pasted image 20250403170955.png|300]]
we consider a slide of 1 (moving the convolutional filters one pixel on the right and one pixel towards the bottom)
![[Pasted image 20250403171110.png|300]]


#TODO 30 -> FINISH SLIDES


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
    
- **Explain the concept of epipolar geometry and its importance in stereo vision.  
    **Epipolar geometry describes the geometric relationships between points observed in two images taken from different viewpoints. It constrains corresponding points to lie on corresponding epipolar lines. This constraint simplifies the search for point correspondences and is essential for stereo vision and 3D reconstruction.
    

## **Spatial Filtering**

- **What are the differences between convolution and correlation in image processing?  
    **Convolution: The kernel is flipped before sliding it over the image, defined as: o(x, y) = ∑m,n i(m, n) * h(x−m, y−n)  
    Correlation: The kernel is not flipped: o(x, y) = ∑m,n i(m, n) ° h(m−x, n−y)
    
- **Why is the Gaussian filter preferred over the mean filter for smoothing images?  
    **The Gaussian filter assigns higher weights to pixels closer to the center, making it better for preserving image structures during smoothing. The mean filter assigns equal weights to all pixels in the neighborhood, which can lead to blurring and loss of image details.
    
- **How does the bilateral filter help preserve edges while denoising an image?**  
    The bilateral filter preserves edges by considering both spatial and intensity differences. Pixels that are spatially close and have similar intensity values contribute more to the smoothing process, avoiding blurring at edges.
    

## **Edge Detection**

- **How does the Canny Edge Detector use hysteresis thresholding to prevent noisy edges?  
    **Hysteresis thresholding uses two thresholds, T1 (high) and T2 (low), to track edges. An edge is accepted if its gradient magnitude exceeds T1​ or if it exceeds T2 and is connected to a stronger edge. This approach prevents fragmented edge detection caused by noise.
    
- **What is the Laplacian of Gaussian (LoG) kernel, and how is it used in edge detection?  
    **The LoG kernel combines Gaussian smoothing with the Laplacian operator to detect edges. It smooths the image to reduce noise and then detects zero-crossings in the second derivative to identify edges.
    
- **What are the key steps in an edge detection pipeline, and why are they important?  
    **The edge detection pipeline typically includes:  
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