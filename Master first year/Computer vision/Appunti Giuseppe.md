ALTRO 
nelle reti neurali piu' non linearita' abbiamo e piu' possiamo esprimere funzioni piu' complesse ma meno spiegabili

CONVOLUZIONI
una convoluzione prendi un kernel e prima fai una rotazione e poi la traslazione
normalmente noi facciamo solo la traslazione perche' prendiamo un kernel simmetrico 
e quindi non avrebbe senso fare la flip perche' rimane uguale e quindi convoluzione 
e correlazione sono identiche in questo caso
Inoltre se prendiamo dei kernel specifici e come se applicassimo delle derivate parziali 
all'immagine e quindi poi possiamo fare un edge detection grazie alle derivate

FILTER
la somma dell'applicare un filtro deve essere 1, quindi tutti i filtri se non sono 
di base normalizzati devono avere un fattore di normalizzazione

Per quanto riguarda gli abbonamenti plus e premium sono due abbonamenti staccati, non 
sono uno l'upgrade dell'altro e poi nel video tu clicchi su premium e ti apre popup 
per comprare pure l'altro abbonamento, ma se tu non hai nessun abbonamento attivo
su che componente clicchi per poter farti comparire il popup?
Anche la sezione dei miei viaggi ha qualche problema a livello logico, una persona 
puo' creare un viaggio come guidatore o passeggero e in miei viaggi in annunci creati
comparira' il viaggio e invece in riposte annunci compaiono le richieste che hai fatto 
a un viaggio.

CAMERA CALIBRATION
​Il metodo di calibrazione della fotocamera proposto da Zhengyou Zhang è una tecnica flessibile che permette di determinare 
i parametri intrinseci ed estrinseci di una fotocamera utilizzando immagini di un pattern planare, come una scacchiera, 
ripreso da diverse angolazioni, la scacchiera e' un calibration target buono perche' ha un pattern semplice e conosciamo la dimensione 
dei quadrati. 
Questo approccio è particolarmente apprezzato per la sua semplicità e l'assenza di necessità di attrezzature specializzate.

Acquisizione delle immagini:
- Si utilizza un pattern planare noto, tipicamente una scacchiera con quadrati di dimensioni conosciute.​
- Si catturano diverse immagini del pattern da varie posizioni e orientamenti, mantenendo la fotocamera fissa e spostando 
    il pattern, o viceversa. È importante avere almeno due immagini con orientamenti differenti per garantire una 
    calibrazione accurata

Per ciascuna immagine, si individuano le intersezioni degli angoli interni della scacchiera (i "corners"). 
Algoritmi come Harris Corner Detector sono comunemente utilizzati per questo scopo

poiché il pattern è planare, si può assumere che tutte le sue coordinate abbiano 
𝑍=0 nel sistema di riferimento del pattern.​
Per ogni immagine, si calcola un'omografia 
𝐻 che mappa i punti del piano del pattern ai punti nell'immagine. Questa omografia è una matrice 
3×3 con 8 gradi di libertà (considerando che è definita a meno di un fattore di scala).

Utilizzando le omografie calcolate, si possono stimare i parametri intrinseci della fotocamera
Per ogni immagine, si determinano i parametri estrinseci (rotazione 𝑅 e traslazione 𝑇) 
che descrivono la posizione e l'orientamento del pattern rispetto alla fotocamera. 
Questi parametri variano per ogni immagine acquisita.
Dopo aver ottenuto stime iniziali dei parametri intrinseci ed estrinseci, si utilizza una procedura di ottimizzazione
non lineare, come l'algoritmo di Levenberg-Marquardt, per minimizzare il reprojection error. 
Questo errore rappresenta la differenza tra le posizioni osservate dei punti nell'immagine e quelle previste dal modello

L'errore di riproiezione è una misura fondamentale nella calibrazione delle fotocamere, utilizzata per valutare 
l'accuratezza con cui il modello calibrato rappresenta la realtà. Esso quantifica la differenza tra le 
posizioni dei punti nell'immagine osservata e le posizioni previste dal modello di calibrazione.

Utilizzando il modello di calibrazione, questi punti nel mondo reale vengono proiettati nell'immagine, 
ottenendo le posizioni previste. L'errore di riproiezione per ciascun punto è la distanza tra la posizione osservata e quella prevista.


CONVOLUTION NETWORKS 
nelle reti convoluzionali il dato (l'input) viene decrementato in risoluzione in maniera quadratica (altezza e larghezza)
pero' viene aumentato il numero di channels in maniera lineare 
questo fa diminuire dal punto di vista spaziale l'immagine ma fa aumentare la semantica, piu' aumentiamo la semantica 
e' piu' possiamo separare le features e capire tipo se quell'area dell'immagine e' un albero 

i modi per diminuire la risoluzione sono lo stride e il pooling
il pooling non viene imparato e richiede dimensione e stride e viene applicato a ogni channels e cambia 
la dimensione della risoluzione senza cambiare il numero di channels, invece stride puo' cambiare il numero di channels

NORMALIZATION LAYER 
normalmente se hai un layer e poi un normalization layer l'activation function del layer viene spostata dopo il 
normalization layer
normalization layer aiuta per il vanish gradient e per arrivare al minimo ma non e' sufficiente per togliere 
il vanish gradient

BATCH NORMALIZATION
metti il layer di batch normalization dopo un layer e prima dell'attivazione, il layer di batch normalization 
prende un batch in input (che sarebbe un batch di output yi del layer su piu' immagini) e lo normalizzi 
con media 0 e varianza 1 e poi fai una roto traslazione yi'= gamma * yi_normalizzato + beta 
gamma e beta sono dei parametri allenabili
il batch normalization viene usato in reti deep e serve in fase di training per rendere la fase di training 
piu' stabile, piu' veloce e accurato e puo' aiutare per il vanish gradient e exploding gradient 
(anche se non lo risolve), ricordiamo che l'exploding gradient e' un problema che non capita quasi mai e 
generalmente e' dovuto a una fase di inizializzazione sbagliata
diversi layer di normalizzazione:
- BATCH NORM normalizza sul batch(insieme di sample)
- LAYER NORM normalizza sui canali su un sample  per i FULLY CONNECTED LAYER in cui le features sono tutte indipendenti
- INSTANCE NORM normalizza solo su H*W, su un canale e su un sample    per i LAYER CONV in cui le features dipendono
dalla posizione spaziale quindi normalizzi sullo spazio ovvero H*W
- GROUP NORM normalizza su un gruppo di canali e un batch

TECNICHE DI REGULARIZATION
sono tecniche per fare in modo che il modello generalizzi
- batch normalization, anche se serve per normalizza ha un side effect di regularizzare un poco perche' introduce 
un po' di rumore
- i dropout layer 
- dropout layer, evita che il modello dipendi troppo da alcuni neuroni
- early stopping 
- data augmentation, avendo piu' dati nel dataset generalmente generalizza meglio il modello

DROPOUT LAYER 
scegli una probabilita' e ti fa disattivare randomicamente delle connessioni di neuroni fra due layer connessi
quindi i pesi randomicamente di un layer quindi praticamente il layer di dropout e' come se ti creasse 
delle sub networks, aiuta per prevenire l'overfitting.
Differenti neuroni sono disattivati a ogni minibatch, ovviamente a test time non avviene il dropout senno' 
avresti dei valori di testing diversi a ogni testing 

EARLY STOPPING 
Ferma l’addestramento quando il modello comincia a peggiorare sul validation set, 
anche se il training set continua a migliorare.

DATA AUGMENTATION 
ogni trasformazione del dataset che preservi la label, quindi se tipo ruoti di 180 gradi un'immagine di un 6 
poi diventa 9 quindi non va bene, bisogna stare attenti sulle trasformazioni sul dataset.
Ovviamente a test time devi usare il dataset originale
a test time facciamo solo center crop senno' se facessimo il 
random a ogni test avremmo risultati diversi

ADAM 
nel momentum si usa un parametro Beta che indica quanto pesa il gradiente passato rispetto al nuovo
exponentially decaying average invece ha un parametro Sw che sarebbe la media pesata dei quadrati dei gradienti
e poi per aggiornare i pesi dividi il gradiente attuale fratto la radice di sw

Adam usa sia il momentum che exponentially decaying average, avendo parametri Beta1 per momentum e Beta2 per 
decaying average

con adam il learning rate lo metti piu' basso invece di 0.1 lo metti a tipo 0.003 senno' col momentum 
ti fa andare troppo avanti e poi ti fa tornare indietro diverse volte per beccare il minimo

DROPOUT (appunti lezione)
non vengono ormai quasi piu' usati per convolutional networks ma vengono usati nei transformers
il dropout viene messo subito prima un fully connected layer e toglie alcuni collegamenti fra i neuroni
a ogni batch killi diversi neuroni, a ogni batch e' come se trainassi una subnet diversi
dropout non vengono usati per il testing, solo per il training per risolvere l'overfitting 
poiche' se ho un'immagine di un gatto e la passo due volte alla network siccome col dropout i neuroni attivi 
cambiano sempre allora magari la prima volta la network ti puo' dire che e' un gatto e la seconda che e' un cane

pro: aiuta per non avere l'overfitting
const: fa il training slower

VANISH GRADIENT E EXPLODING GRADIENT
vanish gradient quando in forward e backward hai pesi molto piccoli e moltiplicazione di pesi piccoli fa 
risultati ancora piu' piccoli e quindi praticamente arrivi lentissimo al minimo e perdi tempo in fase 
di training, traini a vuoto
exploding quando i pesi sono molto grandi, evento molto raro dovuto a una sbagliata fase di inizializzazione
se avviene, avviene in RNN o transformers

FATTORIZZAZIONE CNN 
conv 5x5 = 3x3  seguita da 3x3

conv 3x3 = 1x3 e 3x1
fattorizzare puo' essere utile per ridurre il costo in memoria e potenza computazionale infatti hai meno 
parametri

STRUTTURE RETI 
STEM LAYER 
si mette all'inizio della rete e sono un insieme di layer convoluzioni che comprimono assai la spatial dimension 
per motivi di memoria e computational cost

ALEXNET 
all'inizio ha un STEM LAYER poi layer convoluzionali alternati da max pooling e alla fine layer densi
la rete e' costituita per ogni livello da due layer identici, AlexNet sono tipo due subnet uguali, cosi' 
e' stata trainata su due GPU

problema: il primo layer conv di 11x11 si e' visto che in fase di training presentava dei dead filters 
ovvero filtri che non si attivavano per nessuna immagine in input 

ZFNET 
come AlexNet ma risolve il problema dei dead filters riducendo la dimensione del primo layer conv da 11x11 a 7x7

VGG 
VGG rispetto a AlexNet ha introdotto il concetto di stage in cui all'interno di un singolo stage i 
layer hanno stesso numero di canali e W e H, i stage poi hanno un numero fisso di layer e ci sono di 3 tipi:
conv - conv - pool
conv - conv - conv - pool
conv - conv - conv - conv - pool
Alla fine di ogni stage, grazie la layer di pooling i canali vengono raddoppiati

e poi in VGG si sono usati i pesi di reti VGG piu' piccole come pesi di inizializzazione per VGG 
piu' grandi per creare reti un po' piu' profonde riducendo il vanish gradient ad esempio da 
VGG16 a VGG19(16 e' il numero di learnable layer 13 conv + 3 dense).
Il prof ha detto che hanni dopo che era uscita VGG lui stesso ha trainato VGG mi pare 16 e non ha dovuto fare 
il trick di usare VGG piu' piccole, dice molto probabilmente perche' a quell'epoca non si conoscevano tutte 
le tecniche per inizializzare bene una rete tipo che learning rate usare oppure normalizzare i dati
Inoltre come si puo' vedere nella foto quasi tutti i parametri della rete sono nei layer densi finali 
invece il costo computazionale(flops) sta nei layer convoluzionali e 
l'activations memory che sarebbe la memoria richiesta per storage i features maps di output 
di ogni layer sta nella prima fase, nello stem layer poiche' ancora si ha una dimensione spaziale di W e H molto 
grande e poi grazie allo stem layer si riduce aumentando il numero di canali


GOOGLENET
usa un trick per diminuire il vanish gradient in cui a meta' rete e a 3/4 e ovviamente alla fine mette i layer 
finali di classificazione (in realta' usa global average pooling che e' una novita') e poi fa un avarage 
dei 3 per ottenere il risultato finale Inoltre fra lo stem layer e il classificatore finale mette al 
centro un insieme di interception modules

L'Inception Module rappresenta un cambiamento radicale rispetto alle architetture CNN tradizionali 
come VGG, dove i layer erano organizzati in modo puramente sequenziale (un layer dopo l'altro).
La novità principale è che in un Inception Module, l'input viene elaborato simultaneamente da diversi 
tipi di layer in parallelo, i cui output vengono poi concatenati da un layer di pooling. 
Questa struttura permette alla rete di "scegliere" quale tipo di elaborazione è più efficace per diverse 
caratteristiche dell'immagine.
Il motivo principale è l'efficienza computazionale. 
l'architettura permette di aumentare la profondità (riducendo il vanish gradient) e la larghezza della rete
mantenendo costante il budget computazionale, in particolare l'efficienza computazionale deriva dai layer 
conv 1x1, che riducono il numero di canali, messi prima di layer conv costosi come 5x5 o 3x3

INTERCEPTION MODULE NAIVE 
Nella versione "naive" dell'Inception Module, l'input viene processato in parallelo da:

Convoluzione 5x5 (32 filtri)
Convoluzione 3x3 (128 filtri)
Convoluzione 1x1 (64 filtri)
Max pooling 3x3

Tutti gli output vengono poi concatenati per formare l'output finale.
Problema: Questo approccio genera un numero di canali che cresce molto rapidamente quando si impilano 
più moduli Inception, rendendo i calcoli computazionalmente proibitivi, specialmente per le convoluzioni 5x5 e 3x3.

SOLUZIONE  1x1 CONV
usi le 1x1 conv che servono a controllare il numero di canali, generalmente a comprimerlo, lasciando invariato il 
numero di H e W, quindi lavorano solo sui canali 

aggiungere convoluzioni 1x1 prima delle convoluzioni più grandi e dopo il max pooling per:

Ridurre il numero di canali in ingresso alle convoluzioni più costose (5x5, 3x3)
Controllare il numero di canali in uscita dal max pooling

Altra novita' usa un global average pooling alla fine al posto di un fully connected classifier

FULLY CONNECTED CLASSIFIER vs GLOBAL AVARAGE POOLING 
nel fully connected classifier alla fine della rete l'ultima features map viene appiattita in un vettore lungo 
(non tramite un particolare layer ma facendo un semplice reshape)
e poi viene dato a un fully connected layer che fa la classificazione, questa operazione richiede tantissimi 
parametri
nel global avarage pooling 
la features maps viene data a un layer di average pooling che lavora channels wise e riduce la dimensione spaziale 
cosi' si riducono i parametri del layer denso di classificazione, sostanzialmente in questo caso 
il fully connected layer processa un riassunto di ogni features di ogni canale

INTERCEPTION V3
rispetto a interception v1 presenta delle migliorie poiche' usa la fattorizzazione di cnn ad esempio 
una conv 7x7 la fattorizza in 1x7 seguita da 7x1 oppure una 5x5 come 3x3 seguita da 3x3 (come aveva gia' fatto VGG)

RESNET 
prende le cose migliori delle altre reti e poi sistema il vanish gradient
per risolvere il vanish gradient usa gli skip connection e quindi non si ha solo f(x) ma f(x) + x 
quindi prende l'x di layer precedenti, la connessione e' prima di un layer conv
mette pure skip connections fra stages diversi che quindi hanno dimensione diversa, per risolvere il problema 
della dimensione usa due metodi:
- mette 2 stride e zero padding (ma sta soluzione e' poco carina perche' perdi informazione con zero padding 
e anche in realta' con lo stride)
- usa una 1x1 conv per giocare sui canali e fillare il gap della dimensione dei canali(senza usare il sistema di 
zero padding) e 2 stride per sistemare H e W
usa STEM e global average pooling di GoogleNet, usa gli stages di VGG

Da ResNet50 si sono usati i Bottleneck Blocks che sono presenti dentro il blocco residuale, 
usati in reti deep per migliorare la fase di training infatti 
nei bottleneck rispetto agli standard blocks si usa piu' layers, usando pure i 1v1 conv layer che gioca su 
compressione e espansione del numero di canali, col bottleneck si hanno piu' layer ma meno parametri complessivamente
quindi e' piu' facile da trainare

RESNEXT
In ResNeXt, il blocco residuo è diviso in (G) rami paralleli (cardinalità), ciascuno dei quali applica 
una trasformazione simile ma su un sottoinsieme dei canali. Questi rami sono poi aggregati (sommati) 
per produrre l'output finale.
quindi ad esempio il primo brach di layer conv vede solo i primi 3 canali
La cardinalità (G) è un iperparametro che controlla il numero di rami.
La group normalization puo' essere usata in queste architetture, ricordiamo pero' che la group normalization 
e' stata inventata dopo resNext quindi non e' presente nel design di questa rete

SENet (Squeeze-and-Excitation Networks)
nei blocchi residuali viene usato uno schema squeeze and excitation in cui vi sono 3 fasi:
- squeeze, si usa un global average pooling che lavora channel wise e comprime ogni canale in un valore 
- excitation, questi valori vengono passati a 2 layer fully che interpretano la rilevanza dei canali 
- scale, questi nuovi pesi vengono usati per ricalibrare i canali originale 

In pratica, modula l'informazione in base alla rilevanza.

MOBILENET
non ci sono blocchi residuali fra diversi stage
usa i bottleneck residuali invertiti ovvero invece di comprimere i canali e poi espanderli (che potrebbe portare 
a perdita di informazione poiche' la 3x3 conv dopo la compressione, lavora in uno spazio compresso) 
prima espande i canali con 1x1 conv e poi alla fine li comprime con 1x1, per non esplodere
il costo computazionale la conv 3x3 presente fra 1x1 e 1x1, lavora channel wise ovvero applica filtri separati 
per ogni canale
MobileNet e' un insieme di bottleneck residual block invertiti e relu, il numero di canali cresce lentamente 
rispetto ad altre reti quindi lo stem layer non deve fare una compressione iniziale brusca

EFFICIENTNET
EfficientNet ha come baseline MobileNet e poi considera 3 parametri width, depth e resolution 
si e' visto che se si aumenta solo 1 di questi parametri non si puo' superare circa 80% di accuracy quindi bisogna 
aumentare tutti e 3 in compound
quindi EfficientNet prende in input φ che sarebbe le tue risorse che hai a disposizione e poi le distribuisce 
assegnando dei valori a width, depth e resolution in base al valore di φ scelto

NEURAL ARCHITECTURE SEARCH
sostanzialmente una net che serve a creare il design di net 
praticamente hai il controller che da in output design di reti, molto costosa la fase di training perche' 
il controller ti sputa una rete che poi devi testare e cosi' via per ogni epoca quindi generalmente si 
usano poco i neural architecture search

____________________________

TEXT RAPRESENTATION 
le parole generalmente sono rappresentante nel one hot encoding in cui hai un vettore di categorie (tipo un insieme 
di parole) e poi se hai tipo la parola hello, avrai nel vettore tutti zero tranne 1 nella categoria che rappresenta 
hello
poi questo vettore viene dato a un layer di embedding (generalmente un fully connected layer) che prende in 
input size il vocabolario e da un output di size minore (che e' l'embedding viene usato per ridurre la dimensione 
spaziale)

RNN 
lavori su dati che sono di size batch * features * time(sequence)
non lavorano per forza con testo ma in generale con sequenze 
il layer che poi verra' chiamato in maniera ricorsiva si chiama hidden layer 

h_t = f (h_t-1, x_t, θ)
praticamente l'output dell'hidden layer a tempo t dipende da una funzione f che puo' rappresentare uno o 
piu' layer lineari seguiti da una funzione di attivazione(generalmente la softmax), θ sono i pesi e bias della rete, 
h_t-1 e' l'output dell'hidden layer al tempo t-1, x_t e' l'input al tempo t
il problema e' che non ci possono essere reti RNN troppo profonde senno' arriva il problema del vanish gradient, 
si e' visto che con piu' di circa 10-20 token la rete fatica ad apprendere relazioni tra elementi della 
sequenza che sono distanti tra loro

due tipi di RNN:

- Seq2Vec (Encoder): Prende una sequenza di input variabile e la mappa a un vettore di dimensione fissa. 
        Ad ogni passo temporale dell'encoder, riceve un elemento diverso della sequenza di input.
        alla fine il decoder sputa il vettore che e' il contesto, sarebbe la mappatura della sequenza in 
        input nello spazio latente

- Vec2Seq (Decoder): Prende un vettore di input di dimensione fissa (il contesto) e genera una sequenza di output 
        variabile. 
        Il vettore di input viene principalmente utilizzato per inizializzare lo stato iniziale del decoder, 
        che poi genera la sequenza passo dopo passo. In alcune varianti, il vettore può anche influenzare 
        la generazione ad ogni passo.

bottleneck problem: cosa succede se il contesto ha una size troppo piccola per riassumere per bene sequenze     
                    lunghe? Si usa il meccanismo dell'attenzione 

ATTENTION (in RNN)
Il meccanismo dell'attenzione supera il bottleneck permettendo al decoder di "dare un'occhiata" 
direttamente alla sequenza di input ad ogni passo della generazione dell'output, anziché affidarsi 
unicamente al vettore di contesto finale dell'encoder. 
Invece di avere un unico vettore di contesto globale, l'attenzione calcola un vettore di contesto specifico 
per ogni passo di decodifica, basato su una combinazione pesata degli stati nascosti dell'encoder creando 
il concetto di rilevanza (grazie all'attention score).



l'attention score e' il dot product fra hidden state dell'encoder e lo hidden state corrente del decoder
per ottenere il token in output tu prendi tutti gli attention scores, fai la softmax per normalizzarli  
e renderli delle probabilita'
e fai una somma pesata (il peso e' la probabilita' dell'attention score con la softmax) di tutti gli hidden state 
dell'encoder e crei un vettore(viola) e il token e' dato dalla combinazione(usi o somma o concatenazione, 
originalmente era concatenazione) di questo vettore e l'hidden state del decoder corrente(che e' associato all'output precendete dello scorso hidden state) 
quindi praticamente il token in output dipende da un weighted contribution di ogni hidden state dell'encoder e poi
ovviamente combinato con l'hidden state del precedente output del decoder

TRANSFORMER 
le RNN non permettevano la parallelizzazione cosi' si sono inventati i transformers
iperparametri:
- dmodel 
- h (number of heads)
- N (number of layers)

ENCODER 
prendi in input tutta la sentence(che e' rappresentata in one hot encoding), e la embeddi (tokenizzi e fai 
diventare la sentence di dimenione dmodel x 1) e poi sommi con il positional encoding(che si puo' fare 
in diversi modi, ad esempio frequenze di seno e coseno) che rappresenta la posizione del token nella
sentence (questa info l'hai persa perche' non lavori piu' con le RNN)
L'encoder ha n layer uguali ma ognuno con pesi diversi ed ognuno di questi layer e' composto da 
due moduli il multi attention head e feed forward
il multi head processa tutti i token in parallelo invece il feed forward processa ogni token in maniera indipendente
e espande e comprime l'input alla fine di ogni modulo c'e' un layer normalization

SELF ATTENTION (ATTENTION IS ALL YOU NEED)
(diversa rispetto all'attention score di RNN) serve a trovare delle correlazioni nella sentence di input 
ogni token della sentence in input e' mappato in tre vettori:
- query vector 
- key vector 
- value vector

queste operazioni vengono fatte nel multi head attention

dk = dmodel/h


A (attention matrix) = softmax ( (combinazione di query e key_trasposto)/radice di dk ) moltiplicato per value
hanno messo radice di dk perche' senno' il gradiente era troppo grande

l'input ha size Lxdmodel
Value ha size dk = dmodel/h
la combinazione di Q e K ha dimensione LxL (L e' la length della sentence), poi fai la softmax e poi moltiplichi 
con Value e ottieni l'attention matrix che ha size (LxL moltiplicato Lxdk) = Lxdk e quindi ritorni a un ouput uguale all'input
(non e' proprio uguale all'input perche' non e' Lxdmodel ma Lxdk ma poi alla fine del multihead ridiventa Lxdmodel
perche' concatena tutte le varie attention matrix)
prima di passare l'attention matrix (QxL) alla softmax metti la mask (se sei nel decoder) mettendo 0 a tutte le 
combinazioni di token che non puoi vedere 

L'idea e' che Q e K creano dei pesi di quanto sono correlati i token e poi questi pesi li dai a value 

MULTIHEAD ATTENTION
h si chiama numero di head rappresenta tipo quante rappresentazioni vuoi imparare della sentence che poi usi 
nel multihead e pero' Q,K e V li scali usando dk invece di dmodel senno' esploderebbero i calcoli 

infatti tipo se hai h=8 ti calcoli 8 attention quindi 8 Q,V,K e poi li mandi al multi head che hai un linear 
layer per ogni vettore e poi li concatena (per ottenere come output la stessa size dell'input Lxdmodel)

il multi head attention permette di ottenere informazioni da diverse rappresentazioni della sentence (in questo 
caso 8)

l'input del multi head attention e l'output (che e' la concatenazione delle varie attention matrix) 
deve essere uguale senno' il residual connection non potrebbe esserci

FEED FORWARD 
composto da due fully connected layers
il feed forward processa in maniera indipendente ogni token della sentence(processata dal multi head attention)
come singoli value e non come un vettore come fa il multi head attention
Hai pesi condivisi nel feed forward ovvero per ogni token vengono usati gli stessi pesi nel particolare layer


DECODER
il Decoder ognuno dei layer riceve come input l'output del decoder(quindi si dice che il decoder 
e' condizionato), normalmente decoder e encoder hanno 
lo stesso numero di layer (senno' ti uscirebbero dei risultati strani)
quando traini gli dai tutta la sentence e pero' la maski questa e' la self attention e maski tutti i token 
che non hai ancora predetto (nell'encoder invece non maski nulla)
il decoder prende l'output della ground thruth poi lo fai diventare 
enbedding e lo sommi al positional encoding, poi nel masked multi head attention fai la multi head attention sull'output 
masked e poi c'e' multi head attention (che riceve pure l'output dell'encoder) e feed forward
dopo ognuno di questi tre moduli hai il layout linear normalization
Il decoder e' autoregressive quindi tipo hai la sentence il gatto e' sul tavolo e la ground thruth
the cat is on the table, e' autoregressive quindi il decoder ottiene il gatto e' sul tavolo e the(tutto il resto e' 
masked) e poi il gatto e' sul tavolo e the cat e cosi' via, e' autoregressivo quindi predicti un token alla 
volta senza vedere tutta la sentece di ground thruth senno' sarebbe cheating 
l'output del decoder riva' al decoder come input togliendo il masking nella attention matrix della riga e colonna 
associata al nuovo input (perche' l'hai predetto)

CROSS ATTENTION 
nel multi head attention del decoder, Key e Value sono prese dell'encoder e invece Q deriva dall'ultimo output 
del decoder, e' come se il decoder con la matrice Q chiede la correlazione tra quello che ha preditto con l'output 
dell'encoder la size dell'outpout del cross attention e' L' * dk dove L' e' la lunghezza dell'output precedente del 
decoder quindi esso non dipende dalla size presa dall'encoder quindi sostanzialmente con la cross attention puoi 
ottenere informazione da qualsiasi architettura basta che sia qualcosa x dmodel
quindi praticamente puoi collegare un encoder a una CNN in cui ogni layer della CNN e' collegato un piccolo 
modulo di cross attention(chiamato pure tipo mini transformer), pero' per ogni layer della CNN ci sara' 
un diverso modulo di cross attention perche' ogni layer ha una size diversa quindi tipo al primo layer 
hai CxWxH che flatti in L' e poi al secondo layer hai 2CxW/2xH/2 che flatti in L'' e lo dai a un 
secondo modulo di cross attention 

VISION TRANSFORMER (ViT)
prendi un'immagine e la dividi in non overlapping patches e le embeddi in vettori della dimensione del transformer,
il dmodel, e poi injecti il positional encoding(che rispetto ai normali transformer nei quali venivano usate 
delle funzioni di seno e coseno qui invece sono parametri learnable) a ogni patch
inoltre all'inizio della sequenza aggiungi un class token 
esso e' un vettore di embedding learnable (i cui valori vengono appresi durante l'addestramento, 
partendo da valori casuali), della stessa dimensione d_model degli embedding delle patch. 
Non corrisponde a nessuna patch specifica dell'immagine.
Il Transformer Encoder elabora l'intera sequenza (class token + patch embeddings). L'idea è che, attraverso 
i meccanismi di self-attention all'interno del Transformer Encoder, questo token iniziale interagisca 
con tutti gli embedding delle patch e aggreghi le informazioni globali rilevanti dell'intera immagine. 
Lo stato finale di questo class token, all'uscita dell'Encoder, viene considerato come la rappresentazione 
vettoriale dell'intera immagine.

L'unica differenza dell'encoder nei vision trasformer e' che l'output del multi head attention 
prima viene mandato al layer norm e poi sommato al residual value (si e' visto che sta roba funzionava 
meglio per le immagini)

alla fine dell'encoder prendiamo solo l'output associato al class token che, dopo tutto il processo contiene 
le informazioni semantiche dell'immagine, e lo diamo in pasto a una rete semplice come una MLP (multi layers 
perceptrons) che mappa la rappresentazione vettoriale del class token allo spazio delle classi desiderate 
(es. "Cane", "Gatto", "Auto")


All'inizio provando questa architettura faceva schifo e hanno scoperto perche' le CNN sono invarianti alle 
traslazioni (se ad esempio il numero 3 e' in alto a sx dell'immagine o in basso a dx alle CNN non cambia 
niente, classificheranno sempre come 3) invece i transformer non sono invarianti alle traslazioni 
Per risolvere questo problema hanno trainato i ViT con miliardi di immagini in cui magari il numero 3 e' in tutte 
le possibili posizioni nell'immagine e quindi il modello ha imparato tutte le traslazioni
si e' visto che con grandi dataset i ViT performano molto meglio delle CNN (come e' successo nel passaggio 
dal machine learning al deep learning), quindi i ViT riescono a sfruttare meglio grandi dataset 


OBJECT DETECTION 
VIOLA JONES
molto veloce infatti usato in sistemi real time, e' stato creato per detection di face ad esempio nei telefoni
per la camera
ha tre caratteristiche:
- adaboost 
- integral images 
- cascade

BOOSTING 
Definiamo come Weak classifier un classificatore ad esempio binario che e' leggermente meglio di un classificatore 
randomico e quindi ha una accuracy leggermente superiore al 50%
il bosting consiste nel trainare tot weak classifier in maniera sequenziale uno dopo l'altro, una volta 
trainato un weak classifier si analizzano gli esempi in cui ha sbagliato e il prossimo weak classifier 
si concentrera' su correggere questi errori 
un Strong classifier sarebbe una somma pesata dei weak classifier addrestrati 
generalmente il peso associato a un weak classifier e' basato sulla sua accuracy ottenuta 
La previsione di uno Strong Classifier e' la somma pesata delle previsioni dei weak classifier 

ADABOOST 
nel contesto di Viola Jones i weak classifier sono dei filtri rettangolari di lunghezza fissa che 
ritornano 1 o -1 in base se e' presente un volto in quei pixel dell'immagine
praticamente tu vedi il segno(lo vedi che alcune volte nelle slide mette + 1 o -1 nei filtri)
e poi sommi o sottrai tutti i pixel in base al segno in quell'aerea, la somma totale delle aree dell'intero 
filtro se supera una soglia allora e' un volto e ritorna il weak classifier 1

il problema e' che i possibili weak classifier sono tantissimi e cosi' adaBoost serve a scegliere solamente 
i filtri migliori per detectare volti e poi a combinarli assieme per fare il strong classifier
in particolare in fase di training adaboost cerca di imparare i 200 filtri semanticamente migliori 

per velocizzare i calcoli dei weak classifier si usano le integral images 

INTEGRAL IMAGES 
praticamente e' una matrice in cui il valore (i,j)  è la somma di tutti i pixel nell'immagine originale I 
che si trovano nel rettangolo che va dall'angolo in alto a sinistra (0,0) fino alla posizione (i,j) inclusa.
che poi in realta' per calcolare il valore (i,j) della integral images non devi sommare tutti i valori 
precedenti dell'immagine originale ma basta fare la somma di (i,j-1) + (i-1,j) + (i-1,j-1) della integral 
images sommato al valore di (i,j) nell'immagine originale 

Il problema delle integral images e' che con immagini grandi i numeri diventano enormi e si va in overflow

uso degli integral images per adaboost 

| +1   |
|_____A|  hai queste due regioni +1 e -1 invece di fare la somma di tutti i pixel nell'area +1 e  
|  -1  |  poi sottrarlo alla somma nei pixel in -1 con le integral images basta che fai 
|     B|  I(coordinate di A) - I(coordinate di B) dove I e' l'integral images 
quindi basta ottenere i valori degli angoli della integral images delle zone 


torniamo a Viole Jones, come abbiamo detto si usano patch di dimensione fissa 24*24, in realta' pero' un 
volto puo' essere piu' grande e quindi si scalano le patch con dimensioni piu' grandi tanto hai le integral 
images che velocizzano i calcoli, problema comunque hai tantissime patch da considerare e quindi e' difficile 
che rimane real time il sistema

CASCADE 
si e' visto che in una immagine pochi pixel sono volti, generalmente e' quasi tutto sfondo quindi 
bisogna distinguere background patches e face patches, normalemente si spreca tantissima computazione 
per calcolare features (i weak classifier rappresentati dai filtri rettangolari) su background patches 
allora crei una cascata di classificatori che partono con poche features (e quindi sono molto veloci) e che 
rigettano i background patches e via via aumenti le features dei classificatori (tanto hai meno patches 
e quindi comunque rimane veloce il calcolo) fino ad arrivare al classificatore con le 200 features che pero' 
lavorera' su poche patches

INTERSECTION OVER UNION  IoU
per capire di quanto due bounding box overlappano si fa Intersezione/Unione 

TESTING VIOLE JONES 
tornando a Viole Jones in fase di testing otterremo tante detection e quindi bounding box associate 
a una specifica faccia e quindi facciamo la non maxima suppression delle box
considerando che ogni box ha associato uno score che sarebbe la confidence del detector nel detectare quella box
con la NMS teniamo solo le box con lo score piu' alto e togliamo le box che overlappano superiori a una treeshold
quindi togliamo le box che hanno IoU > treeshold

Inoltre la IoU si usa per definire le box True Positive che sarebbero le box che hanno IoU > treeshold
confrontandole con la box di ground truth ovviamente False Positive IoU < treeshold
quindi sostanzialmente la treeshold rappresenta la correctness del detector e poi determina i TP e FP

_______________________________________________________________________________________

TRANSFER LEARNING
prendi una rete pretrainata e o lasci i pesi uguali di tutti i layer e traini solo il classificatore 
oppure continui il training pure degli altri layer, generalmente nel fine tuning viene usato un learning 
rate molto basso per non sminchiare troppo i pesi della rete pretrainata


OBJECT DETECTION in DEEP LEARNING 
se abbiamo solo un oggetto da detectare nell'immagine allora e' facile perche' diventa un problema 
di object localizzation ovvero identificare le posizioni dell'unico box nell'immagine e la classe di appartenza 
quindi prendi una rete gia' addrestrata e togli il classificatore e metti due Fully connected layer in parallelo
di cui uno precide le 4 info del box (width, height e x e y del centro del box) e l'altro predice la classe

DETECTION di MULTI OBJECTS
in questo caso non sappiamo a priori quanti oggetti ha l'immagine quindi un'idea sarebbe usare una CNN 
con una sliding window per detectare il numero di oggetti (con un approccio molto simile a Viole Jones)
aggiungendo una classe per il background, pero' ci sarebbero troppe windows da considerare quindi si usa il 
metodo delle region proposals(regioni in cui e' piu' probabile che ci sia un oggetto), 
algoritmi come Selective Search che all'inizio nell'immagine vengono identificate delle piccole regioni 
e quindi l'immagine risulta molto frammentata e poi via via a ogni iterazione vengono aggregate regioni vicine 
in base a colore, texture e altre caratteristiche finche alla fine del processo si avra' solo un'unica regione 
e l'algoritmo si ferma non potendo piu' aggregare.
E' importante notare che le region proposals e' l'insieme di tutte le regioni proposte a ogni iterazione (non solamente
dell'ultima iterazione che in realta' ha poco significato)

R-CNN (region based CNN)


si usa Selective Search per ottenere circa 2000 proposte e poi ogni proposta viene prima warpata (viene ingrandita
la regione di spazio della proposta, si e' visto che cosi' le CNN estraggono piu' features se l'immagine in 
input e' piu' grande) e si warpa pure per matchare l'input size di AlexNet ovviamente
poi viene mandata ad AlexNet fine tunato cambiando l'ultimo layer di classificazione 
con due layer FC in parallelo come dicevo prima che uno precide la classe e l'altro le info della box 
Il problema e' che le proposte di selective Search non sono dei parametri learnable
per risolvere il problema la network raffina le proposte della selective Search facendo una box correction 
(in fase di training la network impara a fare la box correction confrontando la box della proposta con quella 
della box della ground truth che overlappa di piu' e cercando di imparare a diminuire questa differenza)

problema di R-CNN: e' lenta

FAST R-CNN 
prima la cosa che era lenta e' che ogni devi in input ad AlexNet una regione e poi la processavi e andavi a quella 
dopo quindi AlexNet doveva processare 2000 proposte
ora invece intanto invece di usare tutto alexNet viene usato fino alla conv5 ma poi tu a conv5 invece di dargli 
ogni volta una proposta diversa gli dai solo una volta l'intera immagine e poi l'output di conv5 che e' una 
feature map le coordinate delle proposte vengono mappate nella feature map(poiche' normalmente la feature map 
ha dimensioni ridotte rispetto all'immagine originale) ovvero nelle RoI (region of Interest) e poi per ogni 
RoI viene fatto un max pooling per arrivare alle piccole dimensioni fisse che poi vengono date a FC6 poi 
c'e' FC7 e poi i classifici due classificatori per le info del box e le classi 
questo metodo viene chiamato RoI Pooling ed e' la principale novita' di FAST R-CNN 

il problema rimane comunque che le proposte non sono learnable e che la selective search ci mette 2 secondi 
quindi puoi ottimizzare e velocizzare quanto vuoi quello dopo ma comunque come minimo ci metti 2 secondi che 
e' troppo per un uso real time 

FASTER R-CNN
si toglie selective search e' le proposte vengono generate da una mini rete chiamata RPN (region proposal Network)
il cui input viene dall'output di conv5 di AlexNet quindi RPN prende in input la features map 
poi ha una window piccola 3*3 e la fa scorrere nella feature map,
il problema iniziale e' che a RPN stiamo chiedendo troppo, chiediamo di darci la posizione dei bounding box, 
la giusta scale o aspect ratio e cosi' aggiungiamo degli anchors ovvero ad ogni posizione della finestra vengono 
considerati delle box anchor a diverse scale e a diverse aspect ratio (tipo rettangolo, quadrato, rettangolo con un 
lato piu' lungo) tutte centrate al centro della window(ovviamente di dimensioni
minori rispetto all'intera windows), il numero di anchor e' fisso ad esempio k=9, per ogni anchor 
il RPN predice un objectness score che sarebbe quanto quell'anchor individua un oggetto o il background
per ottenere le proposte finali: 
- Si prendono gli anchor box che hanno ottenuto un "objectness score" elevato (sopra una certa soglia).
- Si applicano le correzioni(le box correction) a questi anchor box per ottenere le coordinate finali delle proposte di regione.
- Spesso si applica anche qui una forma di Non-Max Suppression per ridurre il numero di proposte sovrapposte.

FASE DI TRAINING RPN 
etichettiamo anchor positivi quelli che hanno IoU > 0.7 con un box ground truth di un oggetto 
anchor negativi il contrario 
per creare il minibatch prendiamo tutti gli anchor positivi di un oggetto e poi i rimanenti posti tutti anchor negativi 
facciamo la anchor correction (basandoci sul box ground truth corrispondente) solo per gli anchor positivi
gli anchor negativi li sortiamo in base all'objectness e filtriamo via quelli che hanno l'objectness basso 
quindi teniamo solo gli hard negatives (ovvero anchor non positivi che pero' e' piu' difficile da dire che non 
sono quell'oggetto, teniamo questi perche' cosi' la net impara meglio)

LIMITAZIONI FASTER C-NN  
Faster C-NN, in particolare RPN lavora sulla feature map che e' piu' piccola rispetto all'immagine originale, 
e' piu' semantica quindi e' meglio per detectare oggetti pero' potrebbe non detectare oggetti che sono gia' piccoli 
nell'immagine originale

MULTI SCALE 
per risolvere questa limitazione di FASTER C-NN si considerano diverse scale come abbiamo fatto in DoG 
in particolare consideriamo 3 scale a tre depth diverse della rete quindi con 3 feature maps diverse che 
poi vengono date in pasto a 3 RPN che producono bad proposal (feature map a inizio rete), average proposal 
e good proposal (il vecchio singolo output della rete senza il multi scale) 
ovviamente la feature map a inizio rete non essendo stata processata e' una bad proposal, per farle 
diventare tutte good proposal si usa FPN 
ovviamente multi scale e anche FPN rendono la rete piu' lenta ma piu' precisa e infatti per risolvere un 
po' sto problema per ogni scale quindi per ogni feature map vengono considerati meno anchor

FPN (FEATURE PYRAMID NET)
invece di dare direttamente le varie feature map a RPN con FPN vengono processate sommandole pure con le feature map 
piu' profonde nella rete per ottenere semantica e avere quindi solo good proposal 

abbiamo le 3 feature map, iniziale, media, finale, i 3 output sono:
- la feature map finale viene data a RPN e da una good proposal 
- la finale viene fatto un upsampling per fixare la risoluzione e viene sommata a la media alla quale 
e' stata fatta una conv1D per fixare i canali e poi la risultante viene data a una conv3d(si e' visto che 
dopo un upsampling conviene una conv3d per smoothare il risultato) ed esso viene dato a RPN formando una good proposal

( (MEDIA -> CONV1D) + (FINALE -> UPSAMPLING) ) -> CONV3D -> RPN -> good proposal

- ( ( ( (MEDIA -> CONV1D) + (FINALE -> UPSAMPLING) ) -> UPSAMPLING ) + (INIZIALE -> CONV1D) ) -> CONV3D -> RPN -> good proposal 

sostanzialmente tranne la finale che ha gia' il giusto numero di canali, le altre feature maps si processano all'inizio 
con conv1d poi si sommano con tutte le feature avanti (tipo iniziale viene sommata sia con media che finale) che 
pero' quelle avanti sono state upsamplate per fixare la risoluzione e poi prima di dare in pasto il tutto a RPN 
si usa conv3d per smoothare


ONE STAGE VS TWO STAGES 
il problema dei vari tipo FASTER CNN che hanno una prima stage che va una sola volta e poi una seconda parte 
la two stage che gira per ogni proposal (si perde molto tempo e non rende il sistema real time)
e come se nella 2 stage ci fosse un for loop per ogni proposal e quindi si e' cercato di trasformare il tutto 
in una sola stage che gira solo una volta

Two Stages:
Lo Stadio 1 (la RPN): Prende le feature map e, per ogni anchor, produce:
- Un punteggio di oggettività (objectness score): Indica la probabilità che quell'anchor contenga un qualsiasi 
oggetto (vs sfondo).
- Una stima iniziale della posizione/correzione del bounding box: Offset per aggiustare l'anchor.

Lo Stadio 2 (Detector Head): Prende le proposte filtrate dallo Stadio 1 e, per ciascuna proposta, produce:
- Le probabilità per le classi finali (C classi + sfondo).
- Una correzione finale del bounding box.

Idea Generale One Stage:
Il detector ti continua a dare l'objectness score che puo' servire per sortare i risultati e fare NMS pero' 
da pure le correzioni degli anchor e anche le classi degli anchor e poi l'output puo' essere visto come 
un unico tensore che contiene tutte queste informazioni

SSD Single shoot Multibox detector 
Vengono usati piccoli rilevatori (convoluzioni 3x3) applicati a diverse feature maps estratte a vari livelli della rete principale 
ovvere VGG, ogni rilevatore e' responsabile per rilevare oggetti a quella particolare scala/risoluzione 
l'output di ogni rilevatore contiene le probabilita' delle classi e le correzioni per i bounding box
le rilevazioni con bassa confidenza vengono scartate

YOLO v3
in yolo v2 sono stati introdotti i learned anchors (non fissi anchor come in faster R-CNN) e poi in 
yolo v3 ha introdotto una specie di FPN con il classico conv 3x3 dopo un upsampling 
yolo v3 e' basato come backbone su Dark-net (rispetto a SSD che usava VGG)
La sua strategia multi-scala è simile a quella di FPN (Feature Pyramid Network): combina feature map 
da livelli diversi sempre con lo stesso principio uguale di FPN con i vari upsampling e conv3x3. 
Tuttavia, invece di sommare le feature (come fa FPN), YOLOv3 le concatena (piu' veloce e si e' visto che aveva 
performance uguali a sommare).
I learned anchor funzionano che invece tu programmatore staticamente dire la dimensione degli anchor, essi vengono 
appresi da un dataset, si usa l'algoritmo k-means clustering su un dataset per apprendere la forma dei bounding 
box di ground truth e poi quindi generare anchor piu' vicini possibili a una buona soluzione

RETINANET 
ha come backbone Resnet e poi usa sempre uno stile FPN con conv3x3 ma le teste di classificazione(classificare le classi)
e di regressione (dire dove sono i bounding box) hanno pesi non condivisi perche' devono risolvere task che richiedono 
rappresentazioni delle feature diverse
pero' la principale innovazione e' la Focal Loss ma ci arriviamo 

CLASS IMBALANCE 
Il task dell'object detection spesso ha un class imbalance nei dati, ovvero se da un'immagine devi classificare 
una penna su un tavolo ci saranno magari pochi box positivi relativi alla penna e tanti box easy negative ad esempio 
di un libro sul tavolo e se si traina un modello con nel batch tanti easy negative il modello impara poco
i modelli a 2 stages risolvevano questo problema perche' nel batch di training sortavano i box negativi in 
base all'objectness score e quindi mettevano come primi i hard negative, invece in 1 stage se metti nel batch 
randomicamente dei sample negativi quasi sicuramente saranno tutti easy negative e cosi' RetinaNet per risolvere 
questo problema modifica la loss

consideriamo una Binary Cross Entropy oggetto vs sfondo 
pt = {                   dove p e' la probabilita' assegnata dal modello che l'anchor appartenga all'oggetto
        p    se y = 1     e' l'oggetto
        1-p  else         e' sfondo
}
BCE(pt) = -ln pt
quindi pt rappresenta la probabilita' che il modello faccia corretto e assegni la classe 
della ground truth, quindi se la ground truth e' l'oggetto allora la probabilita' corretta per l'anchor e' 
p, se la ground truth e' sfondo, allora la probabilita' corretta e' 1-p

EASY NEGATIVE e HARD NEGATIVE
gli easy negative sono anchor che corrispondono a sfondo (y != 1) e che il modello classifica 
come sfondo con alta confidenza ovvero p (predizione che e' oggetto) e' molto bassa e quindi 
pt e' molto alta
invece gli hard negative hanno pt molto bassa

il problema della binary cross entropy e' che il contributo della loss per gli esempi classificati corretti (p>0.5)
e' bassa (perche' e' il log di pt) ma non trascurabile e siccome ci sono tanti easy negative allora la somma dei loro contributi 
sovrasta gli hard negative e quindi il modello impara a classificare meglio gli easy negative e quindi il training 
non e' ottimale (magari passa un easy negative da 0.8 a 0.9 ma a non ci interessano di piu' gli hard negative)

BINARY FOCAL LOSS 
BFL(pt) = -(1-pt)^γ ln pt
dove γ e' un iperparametro, generalmente 2

come funziona: 
se un esempio e' classificato male(pt e' piccolo) allora 1-pt e' vicino a 1 e quindi la Focal Loss e' simile alla Cross Entropy 
se un esempio e' classificato bene(pt vicino a 1) allora 1-pt e' vicino a zero e grazie a γ diventa ancora piu' vicino a zero 
e quindi la loss diventa bassissima 

esempio: 
con γ = 2 e pt = 0.9 (easy negative) la loss viene ridotta di 100 volte rispetto alla BCE

WEIGHTED BINARY FOCAL LOSS 
WBFL(pt) = -αt(1-pt)^γ ln pt

αt = {                   
        α    se y = 1     
        1-α  else         
}

α serve in dataset sbilanciati per bilanciare il contributo nella loss per la classe positiva (α)
e per la classe negativa (1-α) e quindi garantisce che gli errori sulla classe rara (spesso quella positiva) 
non vengano ignorati solo perché sono meno frequenti. 

Invece la focal loss bilancia l'importanza tra sample facili e difficili all'interno di ciascuna classe 
(principalmente riducendo il peso degli esempi negativi facili) e quindi a guidare il training verso gli 
hard negative

MULTI LABEL vs MULTI CLASS 
Nei detector One Stage il task viene trattato come un problema multi label e non multi class 
- Multi class: si assume che un box appartenga a una sola classe e quindi si usa alla fine una softmax che normalizza 
gli output in modo che sommino 1, forzando una singola classe vincente 
- Multi Label: permette un box di appartenere a zero, una o piu' classi contemporaneamente(e' utile se nel box piu' classi
si sovrappongono) e si usa la sigmoid invece della softmax

LOSS FINALE RETINANET 

LOSS di Classificazione: si sommano tutte le WBCE per tutte le classi dove pic e' la probabilita' predetta(output della sigmoide) per la classe c per l'anchor i
yic e' la ground truth ed e' 1 se l'anchor i appartiene veramente alla classe c altrimenti 0 
non si usa la classe di background e invece viene considerato l'anchor background se tutte le probabilita' delle classi sono 
sotto un certo threshold

LOSS di REGRESSIONE
si usa una SmoothL1 loss calcolata solo per anchor positivi, quindi quelli che corrispondono a un oggetto ground truth con yij =! 0

La loss finale e' la somma pesata delle due loss 
L = Lclass + λ Lreg
λ serve a bilanciare i due termini e spesso e' uguale a 1


LIMITE DEGLI ANCHOR 
- Anchors e' un modo brute force per risolvere il task di detection, fra tutti i box scegliamo un subset che pero' non e' chiaro il modo
migliore per scegliere questo subset 
- otteniamo tanti duplicati che poi dobbiamo levare con NMS
- in fase di training dire se un anchor e' giusto (e' simile alla ground truth) e' basato su threshold e tecniche empiriche 

CENTERNET 
fa la detection non tramite gli anchor ma tramite i keypoint(tipo DoG), sostanzialmente un keypoint e' il centro di un oggetto e la rete impara a predirre 
la posizione dei keypoint, la rete produce heatmap per ogni classe di valori compresi fra 0 e 1, 
Yxyc vicino a 1 indica che nelle coordinate (x,y) di questa heatmap si ha un keypoint per la classe c
Le heatmap ovviamente hanno dimensione ridotta rispetto all'immagine e per fare questo downsampling si usa lo stride
pero' questo puo' far diventare meno precisa la heatmap
la rete predice pure queste cose anche se servono solo per i keypoint:
- Un offset locale che serve a correggere l'errore introdotto dallo stride per ritrovare la poszione esatta del centro dell'oggetto
- la dimensione del bounding box con centro il keypoint

INFERENCE TIME 
una volta che la rete ha prodotto le heatmap, i vari offset locali e bounding box come viene presentato l'output?
per ogni classe c si prende la corrispondente heatmap e si cercano i massimi locali per trovare il keypoint, una volta trovato 
viene usato l'offset per trovare l'effettivo centro dell'oggetto e poi viene associato il bounding box raffinato

GROUND TRUTH 
Come si fa a creare la ground truth? noi abbiamo un oggetto in un'immagine e sappiamo il suo centro, quello che dobbiamo fare e' projectare 
il centro nello spazio della heatmap che e' a piu' bassa risoluzione e si fa dividendo le coordinate del centro per lo stride 
(e poi in teoria in training il modello grazie all'offset dovrebbe fare il processo inverso di questa projezione)
una volta ottenute le coordinate del nuovo centro dobbiamo assegnare valori alla heatmap risultante, invece di mettere semplicmente 1 al 
centro e 0 al resto (approccio duro) CenterNet usa un approccio piu' smooth usa una distribuzione gaussiana per creare i valori con centro in p e poi valori positivi 
decrescenti man mano che ci si allontana dal centro.
L'approccio smooth rende il target meno sensibile a piccole imprecisioni

FLEXIBLE DESIGN 
Si e' visto che l'approccio a keypoint di CenterNet e' molto generalizzato, se hai dataset con ground truth che rappresentano altre cose tipo le 
articolazioni del corpo umano, CenterNet riesce a detectarle

SEGMENTAZIONE
ogni pixel viene fatto appartenere a una classe (un oggetto) e nella maschera ha un colore diverso
c'e' un dataset cityscapes dataset che e' segmentazioni di immagini stradali, volevo trainare un modello 
per guida autonoma, il problema e' che questo dataset e' troppo piccolo, cosi' hanno usato il motore grafico
di GTA 5 per generare dati sintetici e trainare il modello ma una volta provato nel mondo reale faceva schifo 
(Domain shift problem) perche' il dominio e' molto diverso, e' come le macchine tesla a guida autonoma trainate
solo su dati di strade americane una volta portata la guida autonoma in europa facevano schifo, parlando del 
modello iniziale quindi hanno trainato il modello con i dati sintetici e poi fine tunato con cityscape ottenendo
degli ottimi risultati

METRICHE 

IoU GENERALIZZATA 
IoUc = intersezione/unione 
l'intersection over union di una classe si calcola in questo modo, dove ad esempio l'intersezione e' 
il numero di pixel presenti per una determinata classe sia nella ground truth che nell'output del tuo modello 

MIoU
mIoU (Mean IoU) = IoUc1 + IoUc2 ... / numero di classi