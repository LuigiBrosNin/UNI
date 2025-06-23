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
piano $\pi$ ha una normale $n$, un punto appartiene sse 

###
##
###