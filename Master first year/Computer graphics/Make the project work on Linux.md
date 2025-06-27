(Lingua inconsistente!!)
La guida qui descritta' va' compensata con i passaggi richiesti nelle slide
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
per compilare, basta il comando `make`
per runnare, chiama l'eseguibile generato dal make
## LAB_1
### Makefile
```c
# Compiler and Flags
CXX = g++
CXXFLAGS = -std=c++11 -Wall -g -pthread
LDFLAGS = -lglfw -lGLU -lGL -lXrandr -lXxf86vm -lXi -lXinerama -lX11 -lrt -ldl
SOURCES = $(filter-out LAB_0_2D.cpp, $(wildcard *.cpp)) glad.c # Automatically finds all .cpp files
OBJECTS = $(SOURCES:.cpp=.o)
EXEC = LAB_1

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
⚠ Se `glad.c` e' nella stessa cartella, il clean lo cancellera', mettetela in una cartella apposita

## LAB_2
### Makefile
```c
# Compiler and Flags
CXX = g++
CXXFLAGS = -std=c++11 -Wall -g -pthread
LDFLAGS = -lglfw -lGLU -lGL -lXrandr -lXxf86vm -lXi -lXinerama -lX11 -lrt -ldl
SOURCES = $(wildcard *.cpp) glad.c # Automatically finds all .cpp files
OBJECTS = $(SOURCES:.cpp=.o)
EXEC = LAB_2_2D_BULLET_HELL

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

put the Meshes in the lab folder and compile / execute. Should go smoothly. Hopefully.

as a bonus, in the gestione_callback.cpp, you want to change this (line 45)
```c++
// on linux this is not necessary, only inverts the y axis controls
//ypos = height - ypos;
```
to fix the freaky camera it comes with.

I do not like the controls of this program but i guess we'll have to work with that.
## LAB_4
Ho usato questi due tutorial in piu' alle slide fornite su virtuale
- [Tutorial: Blender Modelling for Absolute Beginners - Simple Human](https://youtu.be/9xAumJRKV6A?si=hGrUQUdxmsqw4UAa)
- [Character Modeling for Beginners - Blender](https://youtu.be/O6HQhs-gk50?si=YkUY1O2fK3MCq3kp)