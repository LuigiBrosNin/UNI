
NOTE IN ITALIANO ? devo decidere...

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
#TODO 
## 2 - Modelling
### 2.1 - Geometry for CG
### 2.2 - Intro to Geometric Modeling
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

## 3 - Rendering

### Rendering Pipeline
###
##
###
##
###
##
# Labs

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


## OpenGL part I
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
##
##
#
##