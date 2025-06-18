
> Notes taken by Luizo ( [@LuigiBrosNin](https://t.me/LuigiBrosNin) on Telegram)


- Exam
	- Assignments: 45%
	- 4 over 6 programming assignments (individually)
		- 0: Warm up 2D and 3D
		- 1: trajectories in 2D
		- 2: gaming/animation 2D
		- 3: interaction and 3D scene (mesh display)
		- 4: modelling in Blender -> 3D scanning/VR/3D printing 
		- 5: rendering and Ray Tracing contest in Blender
		- 6: 3D scene texturing and special effects
	- alternatively: individual project or seminar presentation
	- Final Exam: 50% –> oral
	- participation 5%

# Summaries
## 1 - Intro
###  1.1 - Graphic Systems
Different kind of graphic systems:
- Semi-immersive VR
- Fully-immersive VR
- Augmented reality (AR)
- Head-mounted displays
- Extended reality (XR)
	![[Pasted image 20250617181242.png]]

Graphic system = Hardware devices (resources) + graphics software (management of resources) to produce images

DirectX, OpenGL, Wulkan, WebGL are graphics libraries (APIs)

**RASTER devices** -> device with a rectangular matrix of samples or pixels (basically screens, printers, digital cameras)

**Colour model** -> math model describing how colour is represented as tuples of numbers (RGB, CMY)

**Colour space** -> HSI (hue, saturation. intensity)

**RASTER** img -> pixel grid based, bitmap file contains pixel values
**VECTOR** img -> vector based, vec img file contains instructions on this data
![[Pasted image 20250617182452.png|300]]

**Scalable Vector Graphics (SVG)** -> Open standard in XML text file that defines vectors

Display systems contain
1. Graphics card (that contains GPU (yes, GPU refers to the chip inside the Graphics card and not the whole component))
2. Display
3. Device driver

Graphics cards contain
1. GPU
2. video memory (frame buffer)
3.  PCB
4. Power connectors
5. cooling fans
6. may contain more stuff

**Refresh rate or Vertical frequency** -> Hertz (Hz) measured, frames displayed per seconds
**Frame rate** -> number of new video frames that the graphic card sent to a display each second

**Frame buffer (FB)** -> RAM for storing images before visualizing them 
- Different planes can be saved, more planes = more colours (N bits per pixel)
- True color model has 32 bit per pixel (RGBA)

Real-time graphics goal -> highest photorealism above a minimum rendering speed of 24 frames/sec

==Rendering pipeline==
![[Pasted image 20250617185901.png]]
![[Pasted image 20250617185940.png]]
1. ModelView Transform -> GPU transforms all objects into a common coordinate system
2. Lighting -> compute colour based on lights
3. Perspective transform -> each 3D triangle is projected onto the virtual view plane
4. Fragment generation -> triangles visible on screens are mapped to pixels (Rasterization)
	![[Pasted image 20250617190238.png]]
5. Fragment processing -> apply computed colours to fragments, add geometry from textures for illusion of detail
6. Z-Buffer visibility test -> depth buffer that stores the distance form each pixel to the viewer, as objects can obscure other objects

Graphics cards evolved from hardwired implementation of the pipeline to a programmable substrate that can support it.
![[Pasted image 20250617190957.png]]
**Shading language** -> graphics programming language (GLSL for OpenGL)

**General Purpose GPU (GPGPU)** -> GPUs can be used for things othe than graphics by abstracting their components
- pixels and colours -> grid with 4-component vector at each cell
- frames -> time-steps
- rendering equations -> any computation we want
Basically what NVIDIA CUDA (Compute Unified Device Architecture) does. 

**Unified shaders** ->  freely allocate resources to vertex shader and pixel shader based on what is required from moment to moment

5th gen GPUs have multi-core architecture, highly specialized cores, handling large amounts of parallel data

**DLSS (Deep Learning Super Sampling)** -> take a low res render and upscale it with deep learning 

## 2 - Modelling
### 2.1 - Geometry for CG
Objects are represented with linear primitives
- points
- lines, segments
- planes, polygons
We need to handle operations on objects (transform, scale, rotate etc.)

<u>the Z axis is perpendicular to the screen</u>

Scalar -> Magnitude (quantity/length)
Point -> Location in space
Vector -> magnitude and direction, no location

#### Linear space
In linear space, we have vectors and scalars, vector operations work as expected (eg. sum of vectors)
We work in a 3 vector space, Euclidean vectors (1,0,0) (0,1,0) and (0,0,1) define a coordinate system.

**2-norm or Euclidean norm** $||a||_{2}$ ->  notion of length preserved by rotations/translations/reflections of space. Basically the calculation that make a vector's "bigness" consistent across dimensions

Magnitude (length) of a vector
$$||a||_{2}= \sqrt{a_{x}^{2}+a_{y}^{2}+a_{z}^{2}}$$
**Unit vector** -> Length 1.0 vector
if we normalize a vector we can make it a unit vector (versor) $a \over {||a||_2}$

![[Pasted image 20250617224122.png]]
Dot products between vectors tells us info regarding vector relationship

**Cross product $a\times b$** -> results in a vector perpendicular to both $a$ and $b$, with magnitude dot product
![[Pasted image 20250617225208.png]]
![[Pasted image 20250617225419.png]]
#### Affine space
Affine space -> extension of a linear space which includes the <u>point</u>

New operations:
- point+vector = new point
- point-point = vector
	![[Pasted image 20250617231120.png|200]]

**Affine combination** of a point P -> linear combination of points with coefficients (called barycentric coordinates of P) that sum up to 1

coefficients $\in [0,1]$ -> convex combinations

Convex object <=> for any two points in the object all points on the line segment between these points are also in the object
![[Pasted image 20250617231744.png|300]]

Convex hull -> set of all P points that can be represented as a convex combinations

Barycentric coordinates -> define a point's position relative to 3 fixed points, with
$$P=\alpha A+ \beta B+\gamma C$$
$\alpha, \beta,\gamma$ are the barycentric coordinates of P with respect to A,B,C
![[Pasted image 20250617234727.png|200]]
P inside triangle -> $\alpha+\beta+\gamma = 1$
![[Pasted image 20250617234837.png|300]]

Used in warping
![[Pasted image 20250617234940.png]]

Slides go over 
- Distance between 2 points
- Parametric equation of a line
- Implicit equation of a line in 2D (Ax+By+C=0)
- Distance between point and line
- Line-segment intersection
That i skipped cuz it's math we really don't need imo

**Plane in 3D space $\pi$** -> has a normal $n$ and a point in the plane $P_{0}$, a point belongs <=> $<Q-P_{0},n>=0$

Implicit representation of planes in 3D -> (Ax+By+Cz+D=0), xyz point on the plane, ABC coordinates of a normal vector to the plane

**Coordinate frame** (Sistemi di riferimento) -> quadruple $F=(P_{0},v_{1},v_{2},v_{3})$ where $P_0$ is an origin point and $v_{1..3}$ is a vector basis

**Homogeneous coordinates** -> coord system which allows unique representation for points and vectors
Vector $w= a_{1}v_{1}+ a_{2}v_{2}+a_{3}v_{3}$ 
Point $P = P_{0} +a_{1}v_{1}+ a_{2}v_{2}+a_{3}v_{3}$
defined by 4 coordinates: $[a_1,a_2,a_{3}, 0\ or \ 1]$ 0 -> vector, 1 -> point

![[Pasted image 20250618000320.png]]
#### Geometric Transformations
Transfrom coords in order to modify position, orientation and size
Modify geometry but not topology

1. 2D Translation
	$$x'=x+d_{x} \quad y' = y+d_{y}$$
2. 2D Rotation
	- use rotation matrix
	$$ \begin{pmatrix}x' \\ y'\end{pmatrix}= \begin{pmatrix}\cos \theta &-\sin \theta \\ \sin \theta &\cos \theta\end{pmatrix} \begin{pmatrix}x \\ y\end{pmatrix}$$
3. 2D Scale
	$$ \begin{pmatrix}x' \\ y'\end{pmatrix}= \begin{pmatrix}sx &0 \\ 0 &sy\end{pmatrix} \begin{pmatrix}x \\ y\end{pmatrix}$$
4. 2D Shear
	$$ \begin{bmatrix}x' \\ y'\end{bmatrix}= \begin{bmatrix}1 &s \\ 0 &1\end{bmatrix} \begin{bmatrix}x \\ y\end{bmatrix} \text { horizontal}
	\quad \begin{bmatrix}x' \\ y'\end{bmatrix}= \begin{bmatrix}1 &0 \\ s &1\end{bmatrix} \begin{bmatrix}x \\ y\end{bmatrix} \text { vertical}$$
Generalization, invertible linear transformation
![[Pasted image 20250618001729.png]]

Affine transformations have
![[Pasted image 20250618001759.png|300]]
![[Pasted image 20250618001916.png]]

some transformations can be combined, but some are non commutative

Trasformations using a pivot point that is not the origin
![[Pasted image 20250618002140.png]]

3D has the same operation with a 4x4 matrix
![[Pasted image 20250618002249.png]]
### 2.2 - Intro to Geometric Modeling
Dimensions $D$:
0. Point
1. Line/curve
2. Mesh/Surface
3. Volume 

Implicit or explicit (parametric) representation
**Implicit** -> a function, eg. $\phi = x^{2}+y^{2} =1$ (circle), the shape is where  $\phi = 0$
**Explicit** -> $(\cos \theta , \sin \theta)$, curve $C(t) = (x(t),y(t))$
**Discrete** -> Graphic representation

### Curves and surfaces
**Function form** of curves only works when each x has one y
$$y=f(x)$$
**Parametric Form** of curves works for more complex shapes (like circles).
$$x(t), y(t)$$
**Implicit Surface**: $\phi(x, y, z) = 0$ defines the surface.
**Parametric Surface**: $S(u, v) = (x(u,v), y(u,v), z(u,v))$
You can calculate **tangent planes** and **normals** (used in lighting).

## Mesh
**Polygonal mesh** -> Set of edges, vertices and faces connected in such a way that:  
- each edge is shared by at most two adjacent faces,  
- one side connects two vertices,  
- the faces are sequences of closed sides,  
- a vertex is shared by at least two sides. 
![[Pasted image 20250618160454 1.png|200]]
#TODO

### 2.3 - Bézier Curves
**Interpolation** -> Curve must pass trough control points
**Approximation** -> curve is influenced by control points

==Bézier curve==
$C(t)$ -> curve which interpolates endpoints $= at^{2}+bt+c$ , $t\in [0,1]$ and $a,b,c$ = coefficient vectors
![[Pasted image 20250310194326.png]]

**Bézier curve** of degree $n$ (in parametric form) -> defined as
$$C(t) = \sum\limits^{n}_{i=0} P_{i}B_{i}^{n}(t),\quad P_{i}\ ,\ i=0,..,n,\quad \text{d-dimentional space } \!R^{d},d=2,3,4$$
**Bernstein basis functions** -> They're basically an approximation for curves 
$$B^{n}_{i}(t)=\begin{pmatrix}n\\i\end{pmatrix}t^{i}(1-t)^{n-i}, \quad i=0,..,n$$

Several ways to represent mathematically a Bézier curve:  
- By Bernstein Polynomial basis
	- I hope we don't get asked to know how to write the monster i'm seeing in the slides right now, better gather info about the theory required in the oral exam
- Matrix Form  
- de Casteljau Algorithm (linear interpolation)

 ==Bernstein Polynomial basis properties==
1. They take on positive values in the interval `[0,1]`
2. They are a partition of unity (the sum of $B_{i}^{n}(t)$ is 1 given $t\in [0,1]$ for all $n$)
	- if `2.` , then $f(t)=P_{0}B_{0}^{n}(t)+..+P_{n}B_{n}^{n}(t)$ is an **affine combination** of the set of points
	- $t \in [0,1] \implies 1\ge B^{n}_{i}(t)\ge 0$
- If `1.` holds, $f(t)$ is a **convex combination** of the points

==Conversion to the power basis==
$$f(t)=\sum\limits^{n}_{i=0}c_{i}B^{n}_{i}=\sum\limits^{n}_{i=0}a_{i}t^{i}$$
Using whatever monstrosity i just typed above, we write a polynomial in **Matrix form**
$$f(t)=\begin{bmatrix}1&t&t^{2}&...&t^n\end{bmatrix}\begin{bmatrix}b_{00}&0&...&0\\b_{10}&b_{11}&...&0\\...&...&...&0\\b_{n0}&b_{n1}&...&b_{nn}\end{bmatrix}\begin{bmatrix}c_{0}\\c_{1}\\...\\c_n\end{bmatrix}$$

Tangents -> The control polygon of C(t) is tangent to the curve at the beginning and end of the curve

==Properties of a Bézier curve==
1. **Shape Control** -> Moving a control point modifies the shape of the curve.
2. The curve interpolates only its first and last control points.
3. It’s **variation diminishing** (without undesired oscillations) it has no more intersections with a line than its control polygon.
4. **It’s invariant under an affine transformation** (translation, rotation, scaling, or shear) -> apply an affine transformation to the control points and then evaluate the curve represented by these transformed control points at ti, is the same as apply an affine transformation to the point $C(t_{i})$.
5. The curve is **smooth** with smooth derivatives.
6. The curve is **tangent at the first and last control points**, to the first and last line segments of the control polygon.
7. The curve is contained into the **convex hull** of the control points, that is inside the smallest polygon formed by its control points.
8. **Linear Precision** -> when all the control points lie on a line, then the Bézier curve is the segment line interpolating the points. (from convex hull property)

==De Casteljau’s Algorithm==
- Given a parameter value $t$, evaluate the poly value $f(t)$ by geometric construction  
- Apply the algorithm to each curve component
- Plot the curve by means of a sequence of recursive linear interpolations

==Linear Interpolation (Lerp)== -> compute a value inbetween two values
We *Lerp* repeatetly and a Bézier Curve will form
![[Pasted image 20250310233613.png|250]]

Repeating $N$ times the process defines the curve 
![[Pasted image 20250310233654.png]]

**Curve Subdivision** -> process of splitting a single Bézier curve of degree $n$ into two subcurves of the degree $n$

==Drawing Bézier Curves==
- **Uniform method** -> Discretize the parametric interval into $N$ equidistant points, then plot the polygonal joining corresponding evaluated points on the curve.
- **Adaptive Subdivision method** -> Break a curve into smaller and smaller subcurves until each subcurve is sufficiently close to being a straight line (according to the flat test), so that rendering the subcurves as straight lines gives adequate results.

==Connecting Bézier curves==
1. **Piecewise Bézier curves** -> Piecewise polynomial
	- No continuity built in
	- Achieve $C^1$ (continuity) using collinear control points
2. **Polynomial Spline** -> Piecewise polynomial 
	- with given regularity
	- conditions $C^1$ or more at the joints

$C^0$ -> Continuity: Curve that can be drawn without lifting the pen off the paper sheet
$C^1$ -> The derived curve components are continuous
$G^1$ -> Geometry Continuity: If the direction tangent to a parametric curve varies in a continuous manner (Its magnitude can also have discontinuous jumps)

![[Pasted image 20250311000536.png]]

### Interpolation for curves
**Interpolation** -> Curve must pass trough control points

==Polynomial Interpolation Theorem==
![[Pasted image 20250618165650.png]]

#### Piecewise polynomial INTERPOLATION
Jumping ball keyframing
![[Pasted image 20250618165937.png]]
![[Pasted image 20250618170004.png]]
We can control this curve with constraints (in the form of vectors)
![[Pasted image 20250618170110.png]]

#### Interpolant C1 with piecewise Cubic Bézier curves
![[Pasted image 20250618170711.png]]
Where
- P -> the keypoints
- t -> parameter values
- m -> slope vectors

#### Catmull-Rom spline
![[Pasted image 20250618171120.png]]
Where
- P -> the keypoints
- t -> parameter values
- m -> slope vectors
basically defines 2 extra points for each P (P- and P+) and builds the curve from there, so that the curve always passes in the original points

The points are found by approximating the derivative $m_i$
$$m_{i}=\frac {P_{i+1}-P_{i-1}}{2}$$
And then define the unknown control points
$$p_{i}^{+}=p_{i}+\frac{1}{3} m_{i}\quad p_{i}^{-}=p_{i}-\frac{1}{3} m_{i}$$
#### TensionContinuityBias (TCB-spline)


## 3 - Rendering
### 3.1 Rendering Pipeline
#TODO

### 3.2 Lighting and shading
When we look at a point on an object, the color that we see is determined by multiple interactions between light sources and reflective surfaces.
==Real light==
![[Pasted image 20250411183344.png]]
![[Pasted image 20250411183417.png]]
opaque objects -> the majority of incident light is either the  
reflected or absorbed

Translucent -> significant light transmission

==Lighting models==
- **Physically-based** -> model physics, use a rendering equation that describes how light interacts with materials
- **Empirical** -> simple approximation, we follow rays of lights that reach the viewer directly and by reflection from surfaces

We determine colour of a point with
1. light sources
2. reflection proprieties of the surface (material)
3. illumination model that describes the interaction

==Local model==
![[Pasted image 20250418101725.png]]
used cuz it's simpler and faster to render

==Global model==
![[Pasted image 20250418103050.png]]
not fully compatible with a rendering pipeline

==Light-material interactions==
1. Specular
2. Gloss
3. Diffuse
![[Pasted image 20250418103404.png]]

==Material properties==
$$K_{a,d,s,e}\in [0,1]$$
- $k_a$ -> ambient
- $k_d$ -> diffuse reflection coefficient
- $k_S$ -> specular reflection coefficient
- $k_e$ -> emissive (self emission of light)
$n_s$ -> specular reflection exponent

==Light==
1. ambient -> fixed source, hits everything equally
2. point
3. directional
4. spot
![[Pasted image 20250418122111.png]]

The way a particular material reflects light is referred to as a **reflection model**

==Phong’s local illumination model==
![[Pasted image 20250418125606.png]]
$$I_{\lambda}=k_{e}+I_{a}k_{a}+I_{d}k_{d}+I_{S}k_{S}$$
- $I_a$ -> ambient intensity
- $I_d$ -> diffusion intensity, $I_{l} \max(0,l*n)$ where $I_l=$Source light intensity, $l$ and $n$ from Lambert's cosine law
- $I_S$ -> reflection intensity

==Lambert’s cosine law==
![[Pasted image 20250418142445.png]]
- $l$ -> light direction
- $n$ -> surface orientation 
- $\theta$ -> angle between norma light and direction

==Attenuation term==
we account for attenuation of the intensity light based on $s$ distance traveled
Decrease intensity with distance from light

==Blinn-Phong Lighting Model==
instead of recalculating the dot product like in Phong shading ($v\cdot r$) we use the halfway vector $h$
specular term in Phong's model is
![[Pasted image 20250418152356.png]]

==Shading==
**Shading** (per fragment) -> assigning pixel colour. (How the lighting is used to color the pixels)
We approximate shading
**Flat shading** -> computing the average of the three vertices per polygon

Improvements for flat shading
- Evaluate phong at each pixel of the polygon
- Vertex normals at each vertex to approximate better the real surface they represent, vertex normals can be provided by different methods 

==Gouraud Shading==
![[Pasted image 20250418174505.png]]
- Normals computed at the vertices
- Color at each vertex decided with normal and phong lighting
- In rasterization stage, the color intensity is calculated by barycentric interpolation of the intensities at the vertices
Artifacts (shortcomings) can get generated, eg. 
- MISSING HIGHLIGHT and SPOTLIGHT effects
- Mach banding EFFECT (discontinuity in colour range causes a mistake in colouring)

==Phong shading==
![[Pasted image 20250418175649.png]]
not into OpenGL
- **Normals** computed for each vertex
- **In rasterization stage** -> normal vectors are then interpolated across the face.
- **Pixel color** -> apply Phong’s light model at every pixel inside face using interpolated normal vector
computationally expensive, lighting after perspective projection

Recap
![[Pasted image 20250418175820.png]]


### 3.3 Shadows & Transparency
==Soft and hard shadow==
![[Pasted image 20250418180944.png]]
To simulate penumbra we blur shadows in image space (cheap but inaccurate)

==Fake/Generated Shadows==
1. shadow on planar surfaces
	- Draw the object primitives a second time, projected into the ground plane
		![[Pasted image 20250425221831.png]]
2. Shadow Map Algorithm
	- Shadow computation similar to view computation (hidden surface removal)
		![[Pasted image 20250425222713.png]]
	- STEP 1: compute shadow map (depth from light source) first render the scene using the light source as view reference point; store the result in the shadow z-buffer (Depth image of visible polygons from light source)
	- STEP 2: Render final image Next, the scene is rendered as usual, but with an extra test to see it the current fragment is in the shadow (by checking shadow z-buffer map to see if points are in shadow)
	-  **Shadow Depth Maps**
		- Shadow mapping uses textures called shadow maps.
		- The depth values as seen from the light source are stored in a shadow map, and are then used in a second pass to generate shadows on the objects
			![[Pasted image 20250425223031.png]]
	- **LightMaps** -> generate shadow texture by capturing silhouettes of objects as seen from the light source. Project texture onto scene. must recalculate for moving lights
3. Shadow volumes
	- represent the volume of space in shadow
	- Shoot a ray from the eye to the visible point, Increment/decrement a counter each time we intersect a shadow volume polygon  
	- If the counter is not 0, the point is in shadow
		![[Pasted image 20250425223848.png]]
		![[Pasted image 20250425223916.png]]
		

==**Ambient Occlusion (AO)**== -> simulation of the shadowing caused by objects blocking the ambient light.
![[Pasted image 20250425224109.png]]
1. **Ray casting** -> Rays are cast from every direction from a surface point. Uninterrupted rays  increase the brightness of the surface, while rays that intercept another object do not add any illumination.
	![[Pasted image 20250425224619.png]]
2. **Screen Space Ambient Occlusion (SSAO)** -> For every pixel, the fragment shader samples the depth values around the current pixel and tries to compute the amount of occlusion from each of the sampled points.
==Transparency Rendering==
Alpha channel material colour, defines opacity of an object (0 -> invisible 1 -> full opacity)
==Rendering with transparency==
We need to render transparent surfaces in a back to front (far to near) order  
This is required because the transparent surface will modify the color already stored at the pixel (normally order doesn't matter)
<u>We should render all opaque surfaces in a scene before rendering the transparent surfaces.</u>

**Order-Independent Transparency OIT** -> per-pixel sorting done in fragment shader (so that the programmer doesn't need any sorting of objects before rendering)
Idea
- Keep a list of colors for each pixel, 
- sort them by depth, 
- blend them together in the fragment shader.
Algorithm
1. Render Opaque object  
2. Render Transparent object  
	- All fragments are stored using per-pixel linked lists.  
	- Store fragments: Color+alpha+depth (only the first K)  
3. Resolve Transparent  
	- each pixel in fragment shader sorts associated linked list.  
	- blending fragments in sorted order with background.  
	- output final fragments.
###

###
##
###
##
###
##
# Labs 
!!! Lingua inconsistente !!!
per ogni lab prepara una piccola relazione (una pagina o meno) che descrive cos'hai fatto, da consegnare giorni prima dell'esame via mail alla professoressa.

## Install dependencies on Linux and make them work
Ubuntu-based (uso `apt` :)

installa GLFW3
```bash
sudo apt-get install libglfw3
sudo apt-get install libglfw3-dev
```

scarica lo zip GLAD come visto nel pdf guida
(gl v3.3, add all extensions)

`src/glad.c` -> spostalo nella cartella del progetto a cui vuoi lavorare

`include` -> sposta le due cartelle `glad` e `KHR` in `usr/local/include` (estraile prima, io le ho messe in una cartella chiamata `dependencies_GL_GLFW` nella home)

```bash
sudo cp -r ~/dependencies_GL_GLFW/include/glad/ /usr/local/include
sudo cp -r ~/dependencies_GL_GLFW/include/KHR/ /usr/local/include

# date i permessi per accedere ai file nelle cartelle
sudo chmod 755 /usr/local/include/glad
sudo chmod 755 /usr/local/include/KHR

```

nella cartella del progetto, dato `example1.cpp`, bisogna compilarlo...
vi passo il mio Make

```bash
g++ -pthread -o example1 example1.cpp glad/glad.c -lglfw -lGLU -lGL -lXrandr -lXxf86vm -lXi -lXinerama -lX11 -lrt -ldl
```
Assicuratevi il path a `glad.c` corrisponda, io l'ho messo in una cartella apposta per ordine

tutto fatto :)
potete avviare l'output con
```bash
./example1
```


## OpenGL part I (ENG)
Vertex Buffer Object (VBO) -> stores data regarding vertexes (generic attributes for the stuff we need)
![[Pasted image 20250308002001.png]]

#TODO this section would absolutely benefit for a summary of those 93 or so slides
## LAB_0
### Make the project work in Linux
My new makefile for generic CP projects
```Makefile syntax
# Compiler and Flags
CXX = g++
CXXFLAGS = -std=c++11 -Wall -g -pthread
LDFLAGS = -lglfw -lGLU -lGL -lXrandr -lXxf86vm -lXi -lXinerama -lX11 -lrt -ldl
SOURCES = $(filter-out LAB_0_2D.cpp, $(wildcard *.cpp)) glad.c # Automatically finds all .cpp files
OBJECTS = $(SOURCES:.cpp=.o)
EXEC = LAB_0_2D

# Default target (build the project)
all: $(EXEC)

# Linking object files to create the final executable
$(EXEC): $(OBJECTS)
	$(CXX) $(OBJECTS) -o $(EXEC) $(LDFLAGS)

# Compiling source files into object files
%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Clean up build artifacts
clean:
	rm -f $(OBJECTS) $(EXEC)

# Add phony target for "clean" to avoid conflicts with file names
.PHONY: all clean
```

Inoltre, per 2h ho avuto l'errore al caricamento delle shader
```
ERROR::SHADER::VERTEX::COMPILATION_FAILED

ERROR::SHADER::FRAGMENT::COMPILATION_FAILED

```
mi sono impazzito per cercare di fixare il problema, credendo fosse qualche dipendenza oscura di OpenGL o simili, invece e' solo che su `LAB_0_2D.cpp ` vengono chiamati i file con il nome sbagliato (case sensitive su Linux, quindi su Windows non c'e' problema)
```c++
char* vertexShader = (char*)"vertexShaderC.glsl";
char* fragmentShader = (char*)"fragmentShaderC.glsl";
```
(vaffanculo aggiungerei)

per compilare, basta il comando `make`
per runnare, chiama l'eseguibile generato dal make
### LAB_0_2D_heart
We mainly removed the unnecessary 2d shapes (i don't need to explain it, it's very easy) and updated 1 function:

```c++
void drawScene(void)
{
glClearColor(r, g, b, 1.0f);
glClear(GL_COLOR_BUFFER_BIT);

// GLFW function to get current time
float currentTime = glfwGetTime();
raggiox = sin(currentTime * 2.0f + PI) * 0.25f + 0.75;

// INIT HEART function, initiates geometry at position cx, cy, with radius raggiox
INIT_HEART(cx, cy, 0.05 * raggiox, 0.05 * raggiox, &heart);

// buffer updates, updates the VBO with the new vertices
// bind the VBO buffer to the VAO buffer
glBindBuffer(GL_ARRAY_BUFFER, heart.VBO_vertices);

// modifies the VBO buffer with the new vertices without reallocating memory
glBufferSubData(GL_ARRAY_BUFFER, 0, heart.vertices.size() * sizeof(vec3), heart.vertices.data());

// set colour again
glClearColor(r, g, b, 1.0f);
glClear(GL_COLOR_BUFFER_BIT);

//Rende attivo il VAO del cuore e lo disegna
glBindVertexArray(heart.VAO);
glDrawArrays(heart.render, 0, heart.nv);

// Unbind the VAO buffer
heart.vertices.clear();
heart.colors.clear();
}
```
And that's about it.
### LAB_0_3D_cube
-  Disegnare un solo cubo
```c++
void drawScene()
{
int i, n_cubi = 1; // fino a 10 cubi
```

- Cambiare il colore del cubo da colori ai vertici a colori alle facce
```c++ 
void polygon(int a, int b, int c, int d, int cl)
{ // aggiunto l'argomento cl come colore, ogni faccia ne ha uno solo 
vColors[Index] = colors[cl]; vPositions[Index] = positions[a]; Index++;
vColors[Index] = colors[cl]; vPositions[Index] = positions[b]; Index++;
vColors[Index] = colors[cl]; vPositions[Index] = positions[c]; Index++;
vColors[Index] = colors[cl]; vPositions[Index] = positions[a]; Index++;
vColors[Index] = colors[cl]; vPositions[Index] = positions[c]; Index++;
vColors[Index] = colors[cl]; vPositions[Index] = positions[d]; Index++;
}

void colorcube()
{ // ho chiamato i colori uno dopo l'altro, a parte il 2 che da giallo si confonde con lo sfondo
polygon(0, 3, 2, 1, 0);
polygon(2, 3, 7, 6, 1);
polygon(0, 4, 7, 3, 6);
polygon(1, 2, 6, 5, 3);
polygon(4, 5, 6, 7, 4);
polygon(0, 1, 5, 4, 5);
}

```

- callback mouse
sembrava il piu' impegnativo, ma abbiamo gia' il callback al mouse e lo scaling fatto, va solo applicato
```c++
for (i = 0; i < n_cubi; i++)
{
Model = mat4(1.0);
Model = translate(Model, cubePositions[i]);
Model = rotate(Model, radians(rotateX), glm::vec3(1.0f, 0.0f, 0.0f));
Model = rotate(Model, radians(rotateY), glm::vec3(0.0f, 1.0f, 0.0f));
Model = rotate(Model, radians(rotateZ), glm::vec3(0.0f, 0.0f, 1.0f));
// sc e' un vec3 che aggiorniamo tramite il callback, basta passarlo a scale() per far applicare il ridimensionamento
Model = scale(Model, sc);

// Passo al Vertex Shader il puntatore alla matrice Model,
glUniformMatrix4fv(MatModel, 1, GL_FALSE, value_ptr(Model));
glBindVertexArray(vao);
//glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
glDrawArrays(GL_TRIANGLES, 0, NumVertices);
}
```

that's it
## LAB_1
### 1. yeah, they work lol
### 2. :LiEye: :LiEye:
### 3. Draw the curve
```c++
// draw the bezier curve
// with castejau algorithm
void drawCurve(int segments = 50)
{   
    // there's no need for this to be global,
    // but prof defined it this way so I'm keeping it
    NumPoints = 0;

    // Calculate points for multiple t values
    // for loop > recursion for performance
    for (float t = 0.0f; t <= 1.0f; t += 1.0f/segments) {
        // Make a copy of control points for this iteration
        float temp[MaxNumPts][2];
        memcpy(temp, vPositions_CP, sizeof(vPositions_CP));

        // de Casteljau's algorithm
        // every iteration computes a single segment
        // that we later add to the curve (vPositions_C)
        for (int i = 1; i < NumPts; i++) {
            for (int j = 0; j < NumPts - i; j++) {
                // linear interpolation
                temp[j][0] = (1 - t) * temp[j][0] + t * temp[j + 1][0];
                temp[j][1] = (1 - t) * temp[j][1] + t * temp[j + 1][1];
            }
        }

        // Store the point on the curve
        vPositions_C[NumPoints][0] = temp[0][0];
        vPositions_C[NumPoints][1] = temp[0][1];
        NumPoints++;
    }

    // Add final point
    vPositions_C[NumPoints][0] = vPositions_CP[NumPts-1][0];
    vPositions_C[NumPoints][1] = vPositions_CP[NumPts-1][1];
    NumPoints++;

    // Draw the curve
    glBindVertexArray(vao_2);
    glBindBuffer(GL_ARRAY_BUFFER, vposition_Curve_ID);
    glBufferData(GL_ARRAY_BUFFER, NumPoints * 2 * sizeof(float), vPositions_C, GL_STREAM_DRAW);
    glVertexAttribPointer(0, 2, GL_FLOAT, GL_FALSE, 2 * sizeof(float), (void*)0);
    glEnableVertexAttribArray(0);
    
    glLineWidth(2.0);
    glDrawArrays(GL_LINE_STRIP, 0, NumPoints);
    glBindVertexArray(0);
}
```
i also added colour to the line, but i had to modify the fragment and vertex Shaders and fix the invisible points and segments since everything needs to be specified colours, so i'm not sharing that part of the code lol, it's useless, just pretty :>
### 4. Drag
My implementation might be different from what the prof wanted, here's how i modified the callbacks / what i added
- In `gestioneCallback.cpp`
```c++
extern float   vPositions_CP[MaxNumPts][2];
extern int      NumPts;
extern int      PointBeingModified;

#define DELTA_DIFFERENCE_TRESHOLD 0.1

// [...]

// glfw: whenever the mouse moves, this callback is called
void cursor_position_callback(GLFWwindow* window, double x, double y) {
    // (x,y) viewport(0,width)x(0,height)   -->   (xPos,yPos) window(-1,1)x(-1,1)
    float xPos = -1.0f + ((float)x) * 2 / ((float)(width));
    float yPos = -1.0f + ((float)(height - y)) * 2 / ((float)(height));

    // if the button is being held, move the point
    if (glfwGetMouseButton(window, GLFW_MOUSE_BUTTON_LEFT) == GLFW_PRESS && PointBeingModified != -1) {
        // if the mouse is near a point, modify it instead of adding a new one
        modifySpecificPoint(xPos, yPos, PointBeingModified);
    }

}

// glfw: whenever the mouse button is pressed or released
void mouse_button_callback(GLFWwindow* window, int button, int action, int mods)
{
    
    if (button == GLFW_MOUSE_BUTTON_LEFT && action == GLFW_PRESS) {
        // (x,y) viewport(0,width)x(0,height)   -->   (xPos,yPos) window(-1,1)x(-1,1)
        double x, y;
        //getting cursor position
        glfwGetCursorPos(window, &x, &y); 
        float xPos = -1.0f + ((float)x) * 2 / ((float)(width));
        float yPos = -1.0f + ((float)(height - y)) * 2 / ((float)(height));

        // if the mouse is near a point, modify it instead of adding a new one
        
        for (int i = 0; i < NumPts; i++) {
            if (abs(vPositions_CP[i][0] - xPos) < DELTA_DIFFERENCE_TRESHOLD && abs(vPositions_CP[i][1] - yPos) < DELTA_DIFFERENCE_TRESHOLD) {
                PointBeingModified = i;
                return;
            }
        }
        
        addNewPoint(xPos, yPos);
        PointBeingModified = NumPts - 1;
    }
    else {
        // Reset the point being modified
        PointBeingModified = -1;
    }
 }
```
- In `LAB_1.cpp`
```c++
void modifySpecificPoint(float xPos, float yPos, int index) {

if (index >= 0 && index < NumPts) {

vPositions_CP[index][0] = xPos;

vPositions_CP[index][1] = yPos;

}

}
```
### 5. Catmull-Rom spline
I dunno we had to use the Hermite basis functions but i thank Copilot for warning me about them.
Also, segments get so high they cause segfaults, hence why i added the check to adjust segments.
```c++
// draw the curve
// with Catmull-Rom algorithm
void drawCurveCatmull(int segments = 10)
{

    NumPoints = 0;

    // Calculate maximum number of points that will be generated
    // prevents segfaults
    int maxPointsToGenerate = (NumPts - 3) * segments;
    if (maxPointsToGenerate >= MaxNumPts) {
        // Adjust segments to fit within MaxNumPts
        segments = (MaxNumPts / (NumPts - 3)) - 1;
        if (segments < 1) segments = 1;
    }

    // Handle first point
    vPositions_C[NumPoints][0] = vPositions_CP[0][0];
    vPositions_C[NumPoints][1] = vPositions_CP[0][1];
    NumPoints++;

    for (int i = 0; i < NumPts-1; i++) {
        // Get control points
        float p0x = vPositions_CP[std::max(i-1, 0)][0];
        float p0y = vPositions_CP[std::max(i-1, 0)][1];
        float p1x = vPositions_CP[i][0];
        float p1y = vPositions_CP[i][1];
        float p2x = vPositions_CP[std::min(i+1, NumPts-1)][0];
        float p2y = vPositions_CP[std::min(i+1, NumPts-1)][1];
        float p3x = vPositions_CP[std::min(i+2, NumPts-1)][0];
        float p3y = vPositions_CP[std::min(i+2, NumPts-1)][1];

        // Generate points along segment
        for (float t = 0.0f; t <= 1.0f; t += 1.0f / segments) {
            if (NumPoints >= MaxNumPts) break;

            // Calculate tangents
            float m0x = (p2x - p0x) / 2.0f;
            float m0y = (p2y - p0y) / 2.0f;
            float m1x = (p3x - p1x) / 2.0f;
            float m1y = (p3y - p1y) / 2.0f;

            // Hermite basis functions
            float h00 = (1 + 2*t) * (1 - t) * (1 - t);
            float h10 = t * (1 - t) * (1 - t);
            float h01 = t * t * (3 - 2*t);
            float h11 = t * t * (t - 1);

            // Calculate point
            float x = h00 * p1x + h10 * m0x + h01 * p2x + h11 * m1x;
            float y = h00 * p1y + h10 * m0y + h01 * p2y + h11 * m1y;

            vPositions_C[NumPoints][0] = x;
            vPositions_C[NumPoints][1] = y;
            NumPoints++;
        }
    }
       
    // Handle last point if we haven't exceeded MaxNumPts
    if (NumPoints < MaxNumPts) {
        vPositions_C[NumPoints][0] = vPositions_CP[NumPts-1][0];
        vPositions_C[NumPoints][1] = vPositions_CP[NumPts-1][1];
        NumPoints++;
    }
    
    // Draw the curve
    glBindVertexArray(vao_2);
    glBindBuffer(GL_ARRAY_BUFFER, vposition_Curve_ID);
    glBufferData(GL_ARRAY_BUFFER, NumPoints * 2 * sizeof(float), vPositions_C, GL_STREAM_DRAW);
    glVertexAttribPointer(0, 2, GL_FLOAT, GL_FALSE, 2 * sizeof(float), (void*)0);
    glEnableVertexAttribArray(0);

}
```
## LAB_2
We need to make a 2d simple game
keypoints:
- has to be pretty
- physical simulations and animations
- gameplay
- particle animations
Here's my pitch for the videogame:
![[Pasted image 20250324184142.png]]
Touhou lol

I want to make a simple bullet hell game
- has to be pretty
	- i don't think we can import external media into the scene, so the scene has to be coded and in some way textured all in C with OpenGL shaders
	- thinking of making an arcade artstyle with bumpers in the game screen
- physical simulations and animations
	- projectile bounces in the window borders and bounces off bumpers (gains speed that goes back to )
- gameplay
	- u move the character with the mouse (dragging ezpz)
	- player has to dodge all projectile instances
	- time survived => score
	- being near projectiles => extra score (touhou gazing)
- particle animations
	- touhou gazing indicator is perfect to implement for this
	- idk i guess death explosion lol
I made a very barebones 2d game with an ufo dodging meteors. there's nothing fancy about it, but it's about everything the keypoints asked, minus animation perhaps? there's nothing except the gaze particle effect. No score cuz i'm lazy and amounts to nothing
i also cut the bumpers objects, made the meteors bump into each other

###
###
## LAB_3
### Make it work on Linux
(i have an ubuntu-based OS)
this created a bunch of problems, i updated my makefile and changed a few things:
```bash
sudo apt-get install libassimp-dev
```
i got the library from apt instead of the zip, as it simplified some stuff.
Grab the other library (ImGui) and put it in the dependencies folder you made in LAB_0 ig

modify these files

Gui.cpp & Lab_03.cpp (i made the makefile handle the paths of these files)
```c++
#include "imgui.h"
#include "imgui_impl_glfw.h"
#include "imgui_impl_opengl3.h"
```
Change every broken include with proper paths to the folder with the imgui whenever there's c:/windows etc. in the files (they're only a few)

Change the shader import, the case is broken as always as we've seen every time...

Change the `Lib.h` and `Strutture.h` includes in a couple of files, as they use a different case than the one they actually are for some reason.

Updated makefile
```makefile
# Compiler and Flags

CXX = g++

CXXFLAGS = -std=c++11 -Wall -g -pthread \

#! CHANGE THIS PATH TO THE ONE U HAVE FOR ImGui
-I/home/[USER]/dependencies_GL_GLFW/ImGui \

-I/usr/include

# Add library paths and link flags

LDFLAGS = -lglfw -lGLU -lGL -lXrandr -lXxf86vm -lXi -lXinerama -lX11 -lrt -ldl -lassimp

  
  

# Source files

IMGUI_DIR = /home/luizo/dependencies_GL_GLFW/ImGui

IMGUI_SOURCES = $(IMGUI_DIR)/imgui.cpp \

$(IMGUI_DIR)/imgui_demo.cpp \

$(IMGUI_DIR)/imgui_draw.cpp \

$(IMGUI_DIR)/imgui_tables.cpp \

$(IMGUI_DIR)/imgui_widgets.cpp \

$(IMGUI_DIR)/imgui_impl_glfw.cpp \

$(IMGUI_DIR)/imgui_impl_opengl3.cpp

  

LOCAL_SOURCES = $(wildcard *.cpp)

SOURCES = $(LOCAL_SOURCES) glad.c $(IMGUI_SOURCES)

OBJECTS = $(LOCAL_SOURCES:.cpp=.o) glad.o $(IMGUI_SOURCES:.cpp=.o)

EXEC = LAB_3

  

# Default target (build the project)

all: $(EXEC)

  

# Linking object files to create the final executable

$(EXEC): $(OBJECTS)

$(CXX) $(OBJECTS) -o $(EXEC) $(LDFLAGS)

  

# Compiling source files into object files

%.o: %.cpp

$(CXX) $(CXXFLAGS) -c $< -o $@

  

# Clean up build artifacts

clean:

rm -f $(OBJECTS) $(EXEC)

  

# Add phony target for "clean" to avoid conflicts with file names

.PHONY: all clean
```

put the Meshes in the lab folder and compile / execute. Should go smoothly. Hopefully.

as a bonus, in the gestione_callback.cpp, you want to change this (line 45)
```c++
// on linux this is not necessary, only inverts the y axis controls
//ypos = height - ypos;
```
unless you want the freaky camera it comes with.

I do not like the controls of this program but i guess we'll have to work with that.
### The hell we need to do?
#### 1 - Insert object
i inserted a tree :>
i also added the grass material and used that one for the base plane.
#### 2 - extend shaders to handle PHONG shaders
ezpz
```c++
// VertexShader
    else if (sceltaShader == 3) // PHONG_SHADING
    {
        // Pass the vertex position and normal to fragment shader
        vcsPosition = (View * Model * vec4(aPos, 1.0)).xyz;
        vcsN = normalize(transpose(inverse(mat3(View * Model))) * aNormal);
        vcsLightPosition = (View * vec4(light.position, 1.0)).xyz;
        
        ourColor = aColor;
        gl_Position = Projection * View * Model * vec4(aPos, 1.0);
    }
// FragmentShader
    else if (sceltaShader == 3) // PHONG_SHADING
    {
        // Normalize all vectors
        vec3 N = normalize(vcsN);
        vec3 V = normalize(-vcsPosition);
        vec3 L = normalize(vcsLightPosition - vcsPosition);
        vec3 R = reflect(-L, N);

        // Calculate lighting components with light power and color
        vec3 ambient = strength * light.power * light.color * material.ambient;

        float diff = max(dot(L, N), 0.0);
        vec3 diffuse = light.power * light.color * diff * material.diffuse;

        float spec = pow(max(dot(V, R), 0.0), material.shininess);
        vec3 specular = light.power * light.color * spec * material.specular;

        // Combine all components
        vec3 result = ambient + diffuse + specular;
        
        // Final color
        FragColor = vec4(result, 1.0);
    }
```

#### 3- extend shaders for Waves
santo GPT che calcola le derivate
```c++
    else if (sceltaShader == 5) // WAVE
    {
        float a = 0.5;
        float omega = 10.0;

        // Wave displacement
        float phaseX = omega * time + 10.0 * aPos.x;
        float phaseZ = omega * time + 10.0 * aPos.z;
        float vy = a * sin(phaseX) * sin(phaseZ);
        vec3 wavedPos = vec3(aPos.x, aPos.y + vy, aPos.z);

        // --- Compute normal from partial derivatives ---
        // Partial derivatives of vy with respect to x and z
        float dvy_dx = a * 10.0 * cos(phaseX) * sin(phaseZ);
        float dvy_dz = a * 10.0 * sin(phaseX) * cos(phaseZ);

        // The normal is the cross product of the tangent vectors
        vec3 normal = normalize(vec3(-dvy_dx, 1.0, -dvy_dz));

        vcsPosition = (View * Model * vec4(wavedPos, 1.0)).xyz;
        vcsN = normalize(transpose(inverse(mat3(View * Model))) * normal);
        vcsLightPosition = (View * vec4(light.position, 1.0)).xyz;

        ourColor = aColor;
        gl_Position = Projection * View * Model * vec4(wavedPos, 1.0);
    }
```
#### 4 - picking objects
- added anchor to imported objects in `add_obj()`
```c++
		// Add anchor point at the origin (or use the centroid if you prefer)
		Model3D[i].vertices.push_back(vec3(0.0f, 0.0f, 0.0f));
		Model3D[i].colors.push_back(vec4(1.0f, 0.0f, 0.0f, 1.0f)); // Red anchor
		Model3D[i].ancora_obj = vec4(0.0f, 0.0f, 0.0f, 1.0f);

		// Optionally, add an index for the anchor (for visualization)
		Model3D[i].indices.push_back(Model3D[i].vertices.size() - 1);
```
- added check in `draw_scene()` to render anchors when the UI requests it
```c++
            // Aggiorno l'ancora dell'oggetto
            update_ancora(&ScenaObj[i][k]);
            updateBB(&ScenaObj[i][k]);
            // --- Highlight anchor if flagAncora is set ---
            if (flagAncora)
            {
                glPointSize(15.0);
                int ind = ScenaObj[i][k].indices.size() - 1;
                glDrawElements(GL_POINTS, 1, GL_UNSIGNED_INT, BUFFER_OFFSET(ind * sizeof(GLuint)));
            }
```
- added `selected_complex_obj` int in `LAB_3D` and imported in `gestione_callback` to find the object we're looking for
```c++
            // search in ScenaObj for the closest intersection
            for (int i = 0; i < ScenaObj.size(); i++)
            {
                for (int j = 0; j < ScenaObj[i].size(); j++)
                {
                    float t_dist = 0.0f;
                    if (ray_sphere(SetupTelecamera.position, ray_wor, ScenaObj[i][j].ancora_world, raggio_sfera, &t_dist))
                    {
                        if (selected_complex_obj == -1 || t_dist < closest_intersection)
                        {
                            selected_complex_obj = i;
                            closest_intersection = t_dist;
                        }
                    }
                }
            }

            // solve conflict between selected_obj and selected_complex_obj
            if (selected_complex_obj > -1 && selected_obj > -1)
            {
                    selected_obj = -1; // deselect simple object
            }
```
- added UI handling for SceneObj selected in `my_interface`
```c++
    else if (selected_complex_obj >= 0 && selected_complex_obj < ScenaObj.size()) {
        ImGui::TextColored(ImVec4(1.0f, 0.0f, 0.0f, 1.0f), "Oggetto Selezionato:");
        ImGui::SameLine();
        ImGui::TextColored(ImVec4(1.0f, 0.0f, 0.0f, 1.0f), "%s", ScenaObj[selected_complex_obj][0].nome.c_str());
        ImGui::TextColored(ImVec4(1.0f, 0.0f, 0.0f, 1.0f), "Operazione:");
        ImGui::SameLine();
        ImGui::TextColored(ImVec4(0.0f, 0.0f, 1.0f, 1.0f), "%s", Operazione.c_str());
        ImGui::SameLine();
        ImGui::TextColored(ImVec4(0.0f, 0.0f, 1.0f, 1.0f), "%s", stringa_asse.c_str());
    }
    else {
        ImGui::Text("Nessun oggetto selezionato");
    }
```


#### 5 - complex obj movement
made this for loop in `modifyModelMatrix`
and that's about it lmao
```c++
    // Handle complex objects (ScenaObj)
	// same operations but in a for loop
    if (selected_complex_obj >= 0) {
        for (int k = 0; k < ScenaObj[selected_complex_obj].size(); ++k) {
            vec3 traslModel;
            mat4 aa = ScenaObj[selected_complex_obj][k].Model;

            traslModel = glm::vec3(aa[3][0], aa[3][1], aa[3][2]);
            mat4 traslation = glm::translate(glm::mat4(1), translation_vector);

            mat4 scala = glm::translate(glm::mat4(1), traslModel);
            scala = scale(scala, glm::vec3(scale_factor, scale_factor, scale_factor));
            scala = translate(scala, -traslModel);

            mat4 rotation = glm::translate(glm::mat4(1), traslModel);
            rotation = glm::rotate(rotation, angle, rotation_vector);
            rotation = glm::translate(rotation, -traslModel);

            ScenaObj[selected_complex_obj][k].Model = traslation * rotation * scala * ScenaObj[selected_complex_obj][k].Model;
        }
    }
```

#### 6 - Toon shading (my favourite)
in VertexShader
```c++
    else if (sceltaShader == 6) // TOON shading
    {
        gl_Position = Projection * View * Model * vec4(aPos, 1.0);

        // Transform vertex position into VCS coordinates
        vec4 vcsPosition = View * Model * vec4(aPos, 1.0);
        // Transform Light  position into VCS coordinates
        vec4 vcsLightPos = View * vec4(light.position, 1.0);

        // Compute vectors N,V,L,R in VCS
        vec3 N = normalize(transpose(inverse(mat3(View * Model))) * aNormal);
        vec3 V = normalize(ViewPos - vcsPosition.xyz);
        vec3 L = normalize((vcsLightPos - vcsPosition).xyz);
        vec3 R = reflect(-L, N);  // Costruisce la direzione riflessa di L rispesso alla normale
        // Ambient
        vec3 ambient = strength * light.power * material.ambient;

        // Specular
        float spec = pow(max(dot(V, R), 0), material.shininess);
        // Toon shading effect

        // Toon banding for diffuse
        float cos_angolo_theta = max(dot(L, N), 0.0);
        float toonDiffuse;
        if (cos_angolo_theta > 0.75)
            toonDiffuse = 1.0;      // highlight
        else if (cos_angolo_theta > 0.4)
            toonDiffuse = 0.7;      // midtone
        else if (cos_angolo_theta > 0.1)
            toonDiffuse = 0.4;      // shadow
        else
            toonDiffuse = 0.15;     // deep shadow

        vec3 diffuse = light.power * light.color * toonDiffuse * material.diffuse;

        // quantize specular as well for a "toon highlight"
        float toonSpec = step(0.5, spec) * 1.0; // Only show highlight if spec > 0.5
        vec3 specular = light.power * light.color * toonSpec * material.specular;

        // Combine colors
        ourColor = vec4(ambient + diffuse + specular, 1.0);
    }
```
i also added outlines using the Model scaling technique, faulty with torus and some complex objects.
```c++

        if (Scena[i].sceltaShader == 6) { // TOON shading
            // 1. Draw outline
            glEnable(GL_CULL_FACE);
            glCullFace(GL_FRONT);
            glEnable(GL_POLYGON_OFFSET_FILL);
            glPolygonOffset(4.0f, 4.0f);
            glUniform1i(uniform.loc_outlinePass, 1);

            glm::mat4 outlineModel = glm::scale(Scena[i].Model, glm::vec3(1.05f));
            glUniformMatrix4fv(uniform.MatModel, 1, GL_FALSE, glm::value_ptr(outlineModel));
            glDrawElements(GL_TRIANGLES, Scena[i].indices.size(), GL_UNSIGNED_INT, 0);

            glDisable(GL_POLYGON_OFFSET_FILL);
            glDisable(GL_CULL_FACE);

            // 2. Draw normal toon-shaded object
            glUniform1i(uniform.loc_outlinePass, 0);
            glUniformMatrix4fv(uniform.MatModel, 1, GL_FALSE, glm::value_ptr(Scena[i].Model));
            glDrawElements(GL_TRIANGLES, Scena[i].indices.size(), GL_UNSIGNED_INT, 0);
        } else {
            glUniform1f(uniform.loc_outlineThickness, 0.0f);
            glUniform1i(uniform.loc_outlinePass, 0);
            glDrawElements(GL_TRIANGLES, (Scena[i].indices.size()), GL_UNSIGNED_INT, 0);
        }
```
In addition to this snipped of code, add `loc_outlinePass` to the Uniform data structure as it's needed in the snippet.
I did the same operation in the complex objects drawing loop
#### 7 - Bezier curve
this was painful
pulsante in gestione callback
```c++
    case GLFW_KEY_B:
        if (mods & GLFW_MOD_SHIFT) {
            cameraPath.clear(); //Pulisce il percorso della telecamera
            SetupTelecamera.position = vec3(0.0, 0.5, 30.0); //Reset della posizione della telecamera
            SetupTelecamera.target = vec3(0.0, 0.5, 0.0); //Reset del target della telecamera

        }
        // make the camera move in a generated bezier curve direction
        else if (cameraPath.empty()) {
            genCameraBezier(); //Genera una curva di Bezier con 10 punti
        }
        break;
```
funzioni in gestione camera:
```c++
void genCameraBezier(int segments = 50){
	// randomly generate a bezier curve with num_points points
	
	// generate 4 points in the plane
	vector<vec3> control_points;
	control_points.clear();
	// push first point at the current camera position
	control_points.push_back(SetupTelecamera.position);

	srand(time(NULL));
	for(int i = 0; i < 4; i++) {
		float x = -10.0f + static_cast<float>(rand()) / (static_cast<float>(RAND_MAX / 20.0f));
		float y = -10.0f + static_cast<float>(rand()) / (static_cast<float>(RAND_MAX / 20.0f));
		float z = -10.0f + static_cast<float>(rand()) / (static_cast<float>(RAND_MAX / 20.0f));
		control_points.push_back(vec3(x, y, z));
	}

	cout << "Control Points: " << endl;
	 for (const auto& point : control_points) {
  cout << "Point: (" << point.x << ", " << point.y << ", " << point.z << ")" << endl;
 }

	// generate the curve
	vector<vec3> bezier_curve;
 	generateCurve(segments, control_points, bezier_curve);
	// add the curve to the cameraPath
	cameraPath.clear();
	for (const auto& point : bezier_curve) {
	cameraPath.push_back(point);
	}
	 // set the camera position to the first point of the curve
	SetupTelecamera.position = cameraPath[0];
	SetupTelecamera.target = cameraPath[1]; // set the target to the second point of the curve
	SetupTelecamera.direction = SetupTelecamera.target - SetupTelecamera.position; // update the direction
}

void followCameraPath(float deltaTime) { // NOTA: ho implementato il deltatime nel LAB_3.cpp, dove chiamo questa funzione ogni frame se cameraPath non e' vuoto
	// move the camera along the bezier curve
	static size_t currentPointIndex = 0;
	static float t = 0.0f; // interpolation parameter
	float speed = 0.5f;

	if (currentPointIndex < cameraPath.size() - 1) {
		vec3 start = cameraPath[currentPointIndex];
		vec3 end = cameraPath[currentPointIndex + 1];

		t += deltaTime * speed;
		if (t > 1.0f) {
			t = 0.0f;
			currentPointIndex++;
		}

		SetupTelecamera.position = mix(start, end, t);

		// Look a bit ahead along the path for a smooth target
		if (currentPointIndex < cameraPath.size() - 2) {
			vec3 next = cameraPath[currentPointIndex + 1];
			vec3 next2 = cameraPath[currentPointIndex + 2];
			SetupTelecamera.target = mix(next, next2, t);
		} else if (currentPointIndex < cameraPath.size() - 1) {
			SetupTelecamera.target = end;
		} else {
			SetupTelecamera.target = start;
		}

		SetupTelecamera.direction = SetupTelecamera.target - SetupTelecamera.position;
	}
}
```
funzioni in utilities
```c++
vec3 bezierPoint(float t, const vector<vec3>& controlPoints)
{
	// De Casteljau's algorithm for Bezier curves
	int n = controlPoints.size();
	vector<vec3> points = controlPoints;

	for (int r = 1; r < n; r++) {
		for (int i = 0; i < n - r; i++) {
			points[i] = (1 - t) * points[i] + t * points[i + 1];
		}
	}
	return points[0]; // The first point is the result
}

// draw the bezier curve
// with castejau algorithm
void generateCurve(int segments, vector<vec3>& controlPoints, vector<vec3>& curvePoints)
{
	// there's no need for this to be global,
	// but prof defined it this way so I'm keeping it
	int NumPoints = 0;

	// Calculate points for multiple t values
	for (int i = 0; i < segments; i++) {
		float t = static_cast<float>(i) / (segments - 1);
		vec3 point = bezierPoint(t, controlPoints);
		curvePoints.push_back(point);
		NumPoints++;
	}
}
vec3 bezierPoint(float t, const vector<vec3>& controlPoints)
{
	// De Casteljau's algorithm for Bezier curves
	int n = controlPoints.size();
	vector<vec3> points = controlPoints;

	for (int r = 1; r < n; r++) {
		for (int i = 0; i < n - r; i++) {
			points[i] = (1 - t) * points[i] + t * points[i + 1];
		}
	}
	return points[0]; // The first point is the result
}

// draw the bezier curve
// with castejau algorithm
void generateCurve(int segments, vector<vec3>& controlPoints, vector<vec3>& curvePoints)
{
	// there's no need for this to be global,
	// but prof defined it this way so I'm keeping it
	int NumPoints = 0;

	// Calculate points for multiple t values
	for (int i = 0; i < segments; i++) {
		float t = static_cast<float>(i) / (segments - 1);
		vec3 point = bezierPoint(t, controlPoints);
		curvePoints.push_back(point);
		NumPoints++;
	}
}
```
#### 8 - OPTIONAL - normali ai vertici per i modelli obj
facile (ho usato gpt)
```c++
		//! --- Compute normals ---
        mymesh[nm].normals.resize(mesh->mNumVertices, glm::vec3(0.0f));
        bool hasNormals = mesh->HasNormals();
        if (hasNormals) {
            for (unsigned int i = 0; i < mesh->mNumVertices; i++) {
                aiVector3D n = mesh->mNormals[i];
                mymesh[nm].normals[i] = glm::vec3(n.x, n.y, n.z);
            }
        } else {
            // Compute per-vertex normals by averaging face normals
            std::vector<glm::vec3> normalSum(mesh->mNumVertices, glm::vec3(0.0f));
            std::vector<int> normalCount(mesh->mNumVertices, 0);

            for (unsigned int i = 0; i < mesh->mNumFaces; i++) {
                const aiFace& face = mesh->mFaces[i];
                unsigned int idx0 = face.mIndices[0];
                unsigned int idx1 = face.mIndices[1];
                unsigned int idx2 = face.mIndices[2];

                glm::vec3 v0 = mymesh[nm].vertices[idx0];
                glm::vec3 v1 = mymesh[nm].vertices[idx1];
                glm::vec3 v2 = mymesh[nm].vertices[idx2];

                glm::vec3 faceNormal = glm::normalize(glm::cross(v1 - v0, v2 - v0));
                normalSum[idx0] += faceNormal;
                normalSum[idx1] += faceNormal;
                normalSum[idx2] += faceNormal;
                normalCount[idx0]++;
                normalCount[idx1]++;
                normalCount[idx2]++;
            }
            for (unsigned int i = 0; i < mesh->mNumVertices; i++) {
                if (normalCount[i] > 0)
                    mymesh[nm].normals[i] = glm::normalize(normalSum[i] / float(normalCount[i]));
                else
                    mymesh[nm].normals[i] = glm::vec3(0.0f, 1.0f, 0.0f); // fallback
            }
        }
	}
```
La parte migliore e' che cosi' puoi imparare bene e te lo puoi anche far spiegare :)
## LAB_4
Ho creato la scena del mercato fatta a lezione, e ci ho aggiunto qualcosa che avrei voluto fare dalle superiori:

![[image.png]]
LUIZOOOOOOOOOOOOOOOOOOOO

![[image-1.png]]

![[image-2.png]]

![[image-3.png]]

Ho usato questi due tutorial
- [Tutorial: Blender Modelling for Absolute Beginners - Simple Human](https://youtu.be/9xAumJRKV6A?si=hGrUQUdxmsqw4UAa)
- [Character Modeling for Beginners - Blender](https://youtu.be/O6HQhs-gk50?si=YkUY1O2fK3MCq3kp)