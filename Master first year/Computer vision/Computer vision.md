
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
Slides seem to be good, and are very visual. There are 41 slides and i don't feel like just adding a phrase and pasting the slide, so i'll freeze notes for now, see what to do of them, studying to slides to understand might be better. Maybe notes to remember definitions, as in summaries.
Also, i'm unsure if i'll be able to study the course or if i want to, so we'll see what becomes of it

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
#TODO FINISH SLIDES 11 -> 31

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



##
##