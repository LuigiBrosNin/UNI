
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
$$C(t) = \sum\limits^{n}_{i=0} P_{i}B_{i}^{n}(t),\quad P_{i},i=0,..,n, \text{d-dimentional space } \!R^{d},d=2,3,4$$
**Bernstein basis functions** -> They're basically an approximation for curves 
$$B^{n}_{i}(t)=\begin{pmatrix}n\\i\end{pmatrix}t^{i}(1-t)^{n-i}, \quad i=0,..,n$$


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
1. yeah, they work lol
2. :LiEye: :LiEye:
3. 
# 
##
#
##