## 0 - Graphic Systems
**Graphic system** = Device Hardware (risorse) + software grafico (management delle risorse) per produrre immagini

device RASTER -> schermi, stampanti, qualsiasi cosa sia in grado di rasterizzare in pixel

Immagini definite "Raster" (in pixel) o "Vector" (in istruzioni e dati)

**Frame buffer (FB)** -> RAM per tenere un immagine prima di realizzarla, tiene un piano di colori

![[Pasted image 20250617185940.png]]
Rendering pipeline
- Geometry stage
	1. ModelView Transform -> oggetti trasformati in un sistema di coordinate comune
	2. Lighting -> processa il colore in base alla luce
	3. Perspective transform -> ogni triangolo proiettato in un piano visivo virtuale
- Rasterization stage
	1. Fragment generation (rasterization) -> triangoli visibili sono mappati in pixel 
		![[Pasted image 20250617190238.png]]
	2. Fragment processing -> colori ai frammenti e geometria dalle texture per illusione dei dettagli
	3. Z-Buffer visibility test -> depth buffer per nascondere pixel non visibili
## 1 - Modelling
### 1.1 - Geometry for CG
Tutto e' basato su primitive: punti, linee, segmenti, piani, poligoni

Scalar -> Magnitude (grandezza/lunghezza)
Point -> Location nello spazio
Vector -> Magnitude e direzione

#### Linear space
Abbiamo vettori e scalari, le operazioni tra vettori funzionano come di norma

**2-norm/Euclidean norm** $||a||_{2}$ -> come ricaviamo la lunghezza del vettore (basically 3D teorema di Pitagora)

**Unit vector** -> vettore di lunghezza 1.0, un vettore puo' essere normalizzato e diventare unit vector (o <u>versore</u>)

**Dot product** $a\cdot b=||a||||b||\cos \theta$ -> ci da' info sulla relazione dei 2 vettori (angolo tra i due)

**Cross product** -> risulta un vettore perpendicolare ai due nell'operazione, magnitude = risultato dot product

#### Affine space
Spazio lineare esteso per includere i punti (e quindi coordinate)

Operazioni nuove:
- point+vector = new point
- point-point = vector
	![[Pasted image 20250617231120.png|200]]

**Affine combination** of a point P -> combinazione lineare di punti che sommano ad 1 con i coefficienti (barycentric coordinates of P)
- Se i coefficienti $\in [0,1]$ si chiamano convex combinations
- Convex hull -> set di punti che possono essere rappresentati come convex combinations

Un oggetto e' **convesso** sse puoi tracciare una linea tra 2 punti dentro l'oggetto che passa fuori l'oggetto
![[Pasted image 20250617231744.png|300]]

Barycentric coordinates -> un punto definito relativamente a 3 punti definiti
$$P=\alpha A+ \beta B+\gamma C$$
$\alpha, \beta,\gamma$  sono le barycentric coordinates di P rispetto a A,B,C. Questo e' importante nel warping
#### Piano in spazio 3D
piano $\pi$ ha una normale $n$ ed un punto d'origine, un punto appartiene sse la normale e' perpendicolare al punto meno il punto d'origine

**Coordinate frame** (Sistemi di riferimento) -> quadrupla $F=(P_{0},v_{1},v_{2},v_{3})$ dove $P_0$ e' un punto d'origine e $v_{1..3}$ e' una base vettoriale

**Homogeneous coordinates** -> sistema di coordinate che rappresenta unicamente punti e vettori
Vector $w= a_{1}v_{1}+ a_{2}v_{2}+a_{3}v_{3}$ 
Point $P = P_{0} +a_{1}v_{1}+ a_{2}v_{2}+a_{3}v_{3}$
defined by 4 coordinates: $[a_1,a_2,a_{3}, 0\ or \ 1]$ 0 -> vector, 1 -> point
#### Geometric Transformations
**Affine transformations** -> vogliamo trasformare le coordinate per modificare la geometria ma non la topologia
- Position
- Orientation
- Size
- Shear
Un sacco di matrici. operazioni 3D sono in matrici 4x4 invece che 3x3
### 1.2 - Intro to Geometric Modeling
Un oggetto puo' essere rappresentato
- Implicitamente (come funzione)
	- facile rappresentare cose semplici
	- si gestisce facilmente matematicamente
- Esplicitamente (con un parametro) (x,y)
	- per cose piu' complesse
- Discreto (rappresentazione grafica)
#### Curves and surfaces
**Implicit Surface**: $\phi(x, y, z) = 0$ definisce la superficie
- **Function form** of curves only works when each x has one y
**Parametric Surface**: $S(u, v) = (x(u,v), y(u,v), z(u,v))$
- **Parametric Form** of curves works for more complex shapes (like circles).

Calcoliamo le tangenti e poi normali in un punto del piano per sapere qual e' la parte esterna dei piani (usata nel lighting)

#### Continuity
$C^0$ -> curve e superfici senza buchi, segmentate
$C^1$ -> con derivate continue, superfici lisce
$C^2$ -> derivate seconde continue

$G^0=C^0$ -> Position continuity
$G^1$ -> Tangent continuity
$G^2$ -> Curvature continuity
![[Pasted image 20250621175449.png]]


### 1.3 - Bézier Curves
Interpolazione -> curva che deve passare nei punti di controllo
Approssimazione -> curva influenzata dai punti di controllo

La curva di Bézier e' una curva che interpola dei punti di controllo (insieme punti di controllo = poligono di controllo)
![[Pasted image 20250310194326.png]]
il grado (degree) della curva e' uguale ai punti+1

#### Representing the curve
3 modi per rappresentare la curva
- Con la Bernstein Polynomial basis
- Con una polynomial in Matrix Form (sempre basato sul Bernstein basis)
	- ![[Pasted image 20250624214521.png]]
- De Casteljau Algorithm (usa linear interpolation, Lerp)

Proprieta' curva di Bézier
1. Muovere i punti di controllo **modifica** la curva
2. La curva **interpola** solo il primo ed ultimo punto di controllo
3. Ha **non piu' intersezioni** con una linea che con il poligono di controllo
4. E' invariante sotto le **affine transformation** (translation, rotation, scaling, shear)
5. La curva e' **smooth** con derivate smooth
6. La curva e' **tangente** al primo ed all'ultimo punto di controllo ed ai primi ed ultimi segmenti
7. La curva e' contenuta nel **convex hull** del punto di controllo (il poligono piu' piccolo formato dai punti di controllo)
8. **Precisione lineare** -> quando tutti i control point formano una linea, la curva di Bézier e' la linea di segmento che interpola tutti i punti

==Linear Interpolation (Lerp)== -> computa un valore inbetween su base $t$
![[Pasted image 20250310233613.png|250]]
L'algoritmo De Casteljau interpola $N$ volte i punti cosi' da arrivare ad una curva

Disegnare la curva
- Metodo uniforme -> discretizza l'intervallo parametrico in $N$ punti equidistanti e unisci i punti trovati
- Metodo Suddivisione Adattuva -> rompi la curva continua trovata in sottocurve abbastanza piccole e renderizza

#### Continuity
$C^0=G^0$ -> continua, un joint puo' essere sharp
- ![[Pasted image 20250624223331.png]]
$C^1$ -> la derivata di ogni punto e' continua
$G^1$ -> Geometry Continuity, le tangenti hanno la stessa direzione
$G^2$ -> tangenti hanno stessa direzione e curvatura
- ![[Pasted image 20250624223442.png]]

### 1.4 Interpolazione
Interpolazione -> curva che deve passare nei punti di controllo

**Teorema di interpolazione dei polinomi** -> esiste sempre ed e' unico un polinomio di grado n che passa per n+1 punti (soddisfa la condizione di interpolazione)

Piecewise polynomial INTERPOLATION -> controllare la continuita' della curva per manipolare l'output finale (per fare cose come la palla che rimbalza)

**Catmull-Rom spline** -> curva di bezier costruita espandendo ogni punto con due punti aggiuntivi (+ e - per far in modo che la curva passi per il punto)
- I punti vengono calcolati approssimando la derivata di ogni punto in base al punto successivo e precedente
$$m_{i}=\frac {P_{i+1}-P_{i-1}}{2}$$
- 1/3 di $m$ viene aggiunta/sottartta al punto per ricavare i punti
![[Pasted image 20250618171120.png]]
TensionContinuityBias (TCB-spline) ->Introduce altri parametri per la forma della curva
- tensione
- continuita'
- bias
Con questi parametri computa i punti Catmull-Rom ridefiniti che danno definizione alla curva

### 1.5 Mesh
#### Mesh poligonale
**Mesh poligonare** -> set di edge, vertici e facce connesse in modo che
- ogni edge e' condiviso al massimo da due facce adiacenti
- una parte connette due vertici
- le facce sono sequenze di parti chiuse
- un vertex e' condiviso da almeno due parti

**Height field** -> file che detiene l'elevazione di un piano, di solito in un'immagine monocromatica

3 modi per generare mesh
**Triangulation or tetraedralization** -> mesh dai punti
**Tessellation** -> mesh dalle superfici
**Polygonalization** -> mesh da volumi di dati

le mesh triangolari hanno una componente geometrica (coordinate vertici) e topologica (grafo vertices, edges, faces)

Le normali delle facce e dei vertici le calcoliamo con il metodo max-nelson

Una mesh puo' essere
- Strutturata (regolare) -> numero elementi intorno ai vertici costante
- Semi-regolare -> regolare tranne poche eccezioni
- Irregolare

i file `.obj` racchiudono mesh, sono formati che possono contenere
- lista vertici ordinati
- lista poligoni
- normali dei vertici
- coordinate texture
- facce
L'orientazione delle facce e' dato dall'ordine dei vertici (ordine antiorario)


#### Manifold
**n-Manifolds** -> superficie liscia che i mesh approssimano, ogni punto ha una neighbourhood che puo' creare un disco (per un 2D manifold) 

una mesh e' 2-manifold se i vertex interni sono homoeomorfici ad un disco e i vertex al limite homoeomorfici a mezzo disco

**Discrete Laplacian $L$ (matrix)** -> grafo di connettivita' delle mesh, rappresenta una mesh e contiene i pesi degli archi
Normalized discrete Laplacian -> normalizza i pesi

**Continuous/discrete Laplace-Beltrami operator** -> misura la differenza tra un vertice e l'average dei vicini
L'operatore e' usato per approssimare le mesh mantenendo la topologia

Curvature -> 
Attraverso le tangenti in un punto P di una superficie e una direzione $e_{\theta}$ dal punto P (intorno) possiamo capire la curvatura della superficie
- Possiamo calcolarci la curvatura media intorno ad un punto
- Possiamo calcolarci la curvatura gaussiana che ci dice se la curvatura e' concava o convessa

**Surface Genus** -> numero di curve semplici chiuse che possono essere disegnate da una superficie senza dividerle in due diverse parti connesse, aka "buchi" in una superficie orientata

**Euler’s formula per una mesh chiusa** -> mette in relazione il numero di faces, edges e vertices in una mesh non strutturata, chiusa e connessa
- Senza boundaries ->  $X=|V|-|E|+|T| = 2(1-g)$ (g=Genus)
- Con boundaries -> boundaries $B$  $X=|V|-|E|+|T|+|B| = 2(1-g)$
$X$ -> euler characteristic, il numero ci da' informazioni (eg. $X=2$, la figura e' un cubo (???))



#### Geometry Mesh Processing
Operazioni per creare una mesh

1. Reconstruction
2. Simplification
	- Ottimizziamo la mesh tramite decimazione vertex e decimazione incrementale per alleggerire la mesh (basandoci sull'approssimazione dell'errore)
3. Parametization / UV MApping
	- mappare la superficie ad un dominio di parametri
	- Teorema Egregium (C. F. Gauß) -> “Una superficie non puo' essere parametrizzata senza distorsione.”
	- Lo stretch che il texture mapping soffre puo' essere minimizzato
	- Atlas Texture generation -> dividiamo il modello in pezzi per texturizzarlo
4. Remeshing
	- Distribuire i punti sulla superficie
5. Smoothing/Fairing (diminuire la variazione in una curva)
	- l'equivalente di image deniosing ma per le mesh
	- Approssimazione/smoothness
6. Deformation/Editing
7. Text-to-3D
	- Genera un modello 3D da parole
8. Shape analysis
	- Detection di simmetria, corrispondenza, segmentazione etc. (features)
## 2 - Rendering
### 2.1 Rendering Pipeline
Rendering -> processo che crea immagini da scene 3D
- Pipeline-based -> per ogni pixel, per ogni oggetto
- Ray-tracing -> per ogni oggetto, per ogni pixel

**Geometry Stage** -> operazioni geometriche per ogni vertex, cose come muovere oggetti, camera, clipping, proiezione, mapping a finestra

**Rasterizer Stage** -> output geometrico diventa pixel visibili sul frame buffer (lo schermo), cose come scan conversion, interpolation, colour combining, visibility
#### Geometry Stage
Diversi sistemi di coordinate
- <u>OCS</u> - Coordinate locali di un oggetto
- <u>WCS</u> - World coordinates
- <u>VCS</u> - Coordinate telecamera
- NDC - Coordinate normalizzate per il dispositivo (Clip space)
- SCS - Screen space

##### View transformation
modello "look at" (Camera)
- C point -> viewpoint
- A point -> direzione della visione
- FOV
- Depth of field
Camera in WCS = $F(C,u,v,w)$
- C -> posizione
- w-axis -> direzione vista
- VUP -> up vector (punta in alto per la camera)
##### Projection transformation
Da vertici 3D in VCS a coordinate 2D, vertici visibili nello schermo
Questa fase definisce la prospettiva
- Projection
	- Le linee convergono al centro della proiezione
	- Oggetti lontani appaiono piu' piccoli
	- effetto forshortening
	- Angoli preservati solo in piani paralleli
	- realistico
	- Forma del volume di visione: piramide troncata
- Orthographic
	- Centro di proiezione locato ad infinito
	- Forma del volume di visione: cuboide troncato

**Canonical view volume/Clip Space**  -> coordinate 3D rispetto alla camera normalizzate da -1 a +1 per tutti e 3 gli assi
(Vengono definite matrici per convertire le proiezioni)

**Window transformation** -> lasciamo stare la coordinata z mentre mappiamo il resto all'immagine 2D

##### Clipping
la camera adatta/taglia gli oggetti che sono parzialmente fuori dal range di visione

**Cohen-Sutherland Line Clipping in 2D** -> metodo per capire se c'e' possibilmente bisogno di clippare un oggetto (9 regioni con al centro lo schermo, vedi le regioni di ogni punto e clippa usando l'intersezione)



##
###