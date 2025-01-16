==WIP PAGE!!==
🐰Le domande sono scritte live da un anonimo eroe che ci ha graziato con questa conoscenza, percio' possono risultare difficili da capire. Ho cercato di dare il mio meglio con le risposte, ma e' evidente che il buon Danilone non chiede la luna, gli bastano due paroline sull'argomento e ti manda a casa (con un bel voto dai :LiSmile:). 

1.  Differenza tra Data Mining e Data Warehouse
	- **Data Mining** si riferisce alla ricerca di pattern all'interno dei dati, dove i pattern sono delle regolarità che si ripresentano nei dati.
	- **Data Warehouse** è una collezione di dati orientati al soggetto, integrati, variabili nel tempo e non volatili

2. Differenza tra Boolean Model e Vector Space Model
	- Il **Boolean Model** fa data retrieval di tipo information retrieval (aka corrispondente, booleano), o i documenti corrispondono alla ricerca oppure no
	- **Vector Space Model** cerca i top $k$ documenti rilevanti, ordinandoli come se fossero vettori o matrici in base alle parole contenute. Il ranking viene espresso grazie al peso delle parole, dato in parte ma non solo dalla frequenza dei termini.
	- Nel VSM (Vector Space Model) ogni dimensione del vettore rappresenta un termine, mentre documenti e query sono anch'esse considerate vettori. Per la rilevanza alla query infatti i vettori vengono classificati per distanza vettoriale dal vettore query (euclidea, angolo).

3. Relazione tra XPath e XQuery 
	- **XPath** fa parte di XQuery e ti permette elaborare e manipolare le stringhe. Ci si può estrarre valori da nodi xml o alberi che rappresentano documenti xml.
	- **XQuery** si appoggia a XPath per calcolare cammini (path) su dati espressi in formato xml.
  
4. Se volessi prendere XQuery ed estenderlo per manipolare grafi piuttosto che alberi, che problemi ci sono?
	- In un grafo puoi non terminare (per la possibilità' di grafi contenenti cicli), in un albero termini sempre. 

5. Se invece di estrarre dal testo la dimensione temporale volessimo estrarre la dimensione spaziale, immaginiamo che nel testo ci sia un riferimento spaziale e ci sia un modo che lo riconosca. Problemi di un sistema di IR che contiene la dimensione spaziale e le query relative.
	- Una dimensione spaziale e' possibile da implementare come oggetto di una query di un sistema IR, ma non perfettamente: i maggiori problemi che sorgono sono riguardo la **coerenza e pertinenza** del testo con la query invece che delle match esatte. Infatti, le query possono essere ambigue (il nome di una via puo' corrispondere ad un altro luogo nel mondo non necessariamente una via), cosi' come i risultati possono essere soggetti a diversi significati (con che criterio posso giudicare se dei risultati sono "vicini"?). Questo e' il problema principale non solo della dimensione spaziale, ma un problema di IR su testo in generale.

6. Nei Data Warehouse che cos'è un fatto/misura e che proprietà hanno?
	- **Fatto**: il soggetto che vogliamo analizzare -> La vendita dei prodotti
	- **Misura**: Quantifica i fatti -> quantità di prodotti venduti
	- Misure possono essere:
		 - **additive** -> sommate su tutte le dimensioni
		 - **semiadditive** -> sommate su alcune dimensioni
		 - **non additive** -> non sommate per alcuna dimensione
		 - **distributive** -> definite come una funzione di aggregazione che viene calcolata in modo distributivo (count)
		 - **algebriche** -> definite come una funzione di aggregazione che può essere espressa come una funzione scalare  (media)
		 - **olistiche** -> non possono essere calcolate da altri sottoaggregati (mediana)

7. Pensiamo ai dati semi-strutturati: se uno ti dicesse mettiamo in piedi un modello di progettazione semi strutturato come ti muoveresti?
	> 🐰ma e' proprio come parla Danilone!
	
	 - I modelli semi-strutturati non hanno schemi fissi, e' possibile liberamente aggiungere attributi in qualsiasi momento, tuttavia lo schema ER potrebbe avere valori nulli come conseguenza. Non avrei sicuramente problemi a definire uno schema sul momento data la manovrabilita' in retrospettiva dello stesso, tuttavia sara' necessario trovare un modo per aggiornare i campi mancanti nei vecchi documenti, se necessario.

8. Fare data mining su dati testuali, che tipo di attività si potrebbero fare?
	- Data mining ricerca dei pattern nei dati ottenuti per estrapolare informazioni (eg. relazione tra comprare il latte e comprare i cereali).
	- Alcune misure di classifica/pattern che si possono estrapolare sono:
		- Popolarità di autori
		- Classificazione di parole
		- Frequenza

9. Cosa si può fare con il data mining applicati a social network? 
	- Rilevazione di pattern e correlazioni, eg. 
		- Sentimenti nei post
		- Popolarità di post relazionati ad utenti
		- Interessi di uno specifico utente (funzionalita' dell'algoritmo)
		- estrazione di sottografi basati su proprietà (clustering)

10. SQL/XML e XQuery che differenza c'è?
	- **SQL/XML** è utilizzato per manipolare storage di dati XML in SQL. Prende in input dati relazionali e tira fuori alberi XML
	- **XQuery** è utilizzato per manipolare documenti XML, e quindi permette di accedere a dati semi-strutturati. Prende in input documenti xml e tira fuori xml
	- SQL/XML prende dati relazionali e tira fuori alberi XML. XQuery prende documenti XML e tira fuori XML.

11. se immagini che un linguaggio parte da insiemi di grafi, dobbiamo supporre di fare un join tra grafi. Come ti muoveresti?
	- Bisogna prima di tutto individuare vertici o etichette comuni dei grafi interessati per l'operazione di join. Questo dipende da caso in caso, dato che si potrebbero unire grafi in parte, con archi comuni o con nuovi significati agli archi dei grafi
	- esempio:
		- Il **grafo A** ha vertici etichettati con persone e archi che indicano amicizie.
		- Il **grafo B** ha vertici etichettati con persone e archi che indicano parentele.
		Se desideriamo fare un join tra i due grafi sulla base delle persone (vertici comuni), il risultato potrebbe essere un nuovo grafo in cui ogni vertice rappresenta una persona, e ogni arco rappresenta sia una relazione di amicizia che un grado di parentela. Se i vertici non corrispondono esattamente, potremmo unirli utilizzando identificatori comuni.

TODO CONTINUA A SISTEMARE LE DOMANDE DA QUI

12. Riguardo i dati semistrutturati, che problematiche vedi nell'uso di questi dati per l'apprendimento automatico?
	- Il problema piu' importante è la mancanza di uno schema, e che quindi i dati differiscono da un caso all'altro. L'apprendimento automatico dipende fortemente dai dati inseriti per il training, a priori dall'approccio usato. Dati inconsistenti fondamentalmente.

 
13. Perchè abbiamo introdotto il Vector Space model? Cosa non andava bene nel modello booleano?
	- Il modello booleano presenta un limite che il Vector space model sorpassa: I documenti/dati corrispondono alla query oppure no. Avevamo bisogno di uno spettro di corrispondenza alla query. In altre parole ricercare documenti per rilevanza piuttosto che corrispondenze esatte. Il VSM permette un ranking dei risultati per pertinenza con la query, invece che una lista di exact matches.
	- Un esempio e' quando effettuiamo una ricerca per topic.

14. ETL nel data warehouse.
	- **Estrazione** dei dati dalle diverse sorgenti (statica o incrementale)
	- **Trasformazione**: trasformazione e cleaning dei dati in un formato valido per il dw
	- **Loading**: caricamento dei dati nel dw

15. Differenza tra i sistemi SQL e i sistemi NoSQL.
	- SQL rispettano la proprietà ACID mentre NoSQL rispettano la proprietà BASE(Basic Avaliability, Soft State, Eventual Consistency).
	- La differenza fondamentale è che con i SQL c'è poca disponibilità, non ridondanza e forte consistenza, mentre nei NoSQL molta disponibilità, meno consistenza e appoccio best effort

16. Star Schema e Snowflakes schema nei Data Warehouse.
	- La tabella dei fatti e' al centro dello schema in entrambi.
		1. **Snowflake** Ha ridondanza e ha una sola tabella per dimensione
		2. **Star** Elimina la ridondanza frammentando in più tabelle gerarchiche normalizzate
		![[Pasted image 20250116115848.png]]

17. Valutazione dei sistemi di Information Retrieval tramite collezione TREC.
	- Text REtrieval Conference -> Grandi collezioni, bisogna estrarre parole affini efficacemente
		 - coefficiente di dice
		 - mutual information
		 - expected mutual information
		 - pearson's chi-squared


18. Abbiamo visto SQL/XML: se volessimo fare SQL/Text che prende dati relazionali e li mette in documenti testuali come potremmo procedere?
	- Dalla natura normalizzata di SQL, non e' necessario effettuare operazioni complesse per sistemare dati in un documento di testo.
	- Per la ricerca nei documenti testuali sarebbe sufficiente la clausola "contains"


19. Abbiamo visto SQL/XML, XPath e XQuery, relazione tra i tre linguaggi e differenze un po' ad alto livello.
	- **SQL/XML** e' un linguaggio che contiene costruttori, routine e funzioni che supportano la manipolazione e archiviazione di XML in un database SQL
	- **XPath** permette di elaborare e manipolare le stringhe all'interno di documenti. Ci si può estrarre valori da nodi xml o alberi che rappresentano documenti xml.
	- **XQuery** si appoggia a XPath per calcolare cammini (path) su dati espressi in formato xml. E' usato per effettuare query su documenti XML.

20. Relazione tra misura e dimensione in un cubo di un data Warehouse.
	- Le dimensioni influiscono sulla decisone dell'aggregazione delle misure. Cambia il livello di astrazione nel quale i dati vengono visualizzati. In particolare abbiamo misure:
		 - **additive** -> sommate su tutte le dimensioni
		 - **semiadditive** -> sommate su alcune dimensioni
		 - **non additive** -> non sommate per alcuna dimensione

21. SQL per gestire immagini o video.
	- 🐰Bleah
	- Storing images and videos in SQL databases is possible trough Binary fields, but it is considered a bad practice, as it's difficult to manipulate due to the size of these files, as well as the inability to accurately locate and preview the files after a given query.
	- A "good" approach would be to store the path to the resources (url or local location).

23. Come nasce cosa fa e che caratteristiche ha XQuery.
	- XQuery was born to access XML data
	- Has XSLT functions (e**X**tensible **S**tylesheet **L**anguage **T**ransformations)
	- Operates on sequences 
	- Can receive in input $0$﻿ or $n$﻿ sequences
	- Can output an <u>ordered and not-nested</u> sequence
	- Explore XML elements trough n