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

Scalar -> Magnitude (quantita'/lunghezza)
Point -> Location nello spazio
Vector -> Magnitude e direzione

### Linear space
Abbiamo vettori e scalari, le operazioni tra vettori funzionano come di norma

**2-norm/Euclidean norm** $||a||_{2}$ 


###
##
###