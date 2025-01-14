WIP PAGE!!

1.  Differenza tra Data Mining e Data Warehouse
	Data Mining si riferisce alla ricerca di pattern all'interno dei dati, dove i pattern sono delle regolarità che si ripresentano nei dati.
	Data Warehouse è una collezione di dati orientati al soggetto, integrati, variabili nel tempo e non volatili

2. Differenza tra Boolean Model e Vector Space Model
	Il Boolean Model fa data retrival di tipo information retrival (matcha), o caccia tanti documenti o ne caccia pochi
	Vector Space Model cerca i top k documenti rilevanti utilizzando varie feature come la frequenza e la frequenza di termini rari
	Vede un documento come tante parole ed è rappresentato come un vettore di termini pesati. Uno spazio vettoriale di dimensione |v|, gli assi sono i termini e i doc sono vettori di questo spazio (sparsi) e anche le query sono visti come vettori. La rilevanza si calcola con la distanza dei vettori dei documenti con il vettore query (euclidea, angolo)

3. Relazione tra XPath e XQuery 
	XPath fa parte di XQuery e ti permette elaborare e manipolare le stringhe. Ci si può estrarre valori da nodi xml o alberi che rappresentano documenti xml.
	XQuery di appoggia a XPath per calcolare cammini su dati espressi in formato xml.
  
4. Se volessi prendere XQuery ed estenderlo per manipolare grafi piuttosto che alberi, che problemi ci sono?
	In un grafo puoi non terminare, in un albero termini sempre. 

5. Se invece di estrarre dal testo la dimensione temporale volessimo estrarre la dimensione spaziale, immaginiamo che nel testo ci sia un riferimento spaziale e ci sia un modo che lo riconosca. Problemi di un sistema di IR che contiene la dimensione spaziale e le query relative.

6. Nei Data Warehouse che cos'è un fatto/misura e che proprietà hanno?
	Fatto: il soggetto che vogliamo analizzare -> La vendita dei prodotti
	Misura: Quantifica i fatti -> quantità di prodotti venduti
	Misure possono essere:
	 - additive -> sommate su tutte le dimensioni
	 - semiadditive -> sommate su alcune dimensioni
	 - non additive -> non sommate per alcuna dimensione
	 - distributive -> definite come una funzione di aggregazione che viene calcolata in modo distributivo (count)
	 - algebriche -> definite come una funzione di aggregazione che può essere espressa come una funzione scalare  (media)
	 - olistiche -> non possono essere calcolate da altri sottoaggregati (mediana)

7. Pensiamo ai dati semi-strutturati se uno ti dicesse mettiamo in piedi un modello di progettazione semi strutturati come ti muoveresti?
	I semi non hanno schemi fissi potrai dover aggiungere attributi tra qualche mese e dover aggiungere dei valori, lo schema ER potrebbe avere valori nulli.

8. Fare data mining su dati testuali, che tipo di attività si potrebbero fare?
	Risposta: popolarità di autori, classificazione di parole, frequenza

9. Cosa si può fare con il data mining applicati a social network? 
	Popolarità, estrazione di sottografi basati su proprietà (clustering)

10. SQL/XML e XQuery che differenza c'è?
	SQL/XML è utilizzato per manipolare storage di dati XML in SQL. Prende in input dati relazionali e tira fuori alberi XML
	XQuery è utilizzato per manipolare documenti XML, e quindi permette di accedere a dati semi-strutturati. Prende in input documenti xml e tira fuori xml
	SQL/XML prende dati relazionali e tira fuori alberi XML. XQuery prende documenti XML e tira fuori XML.

11. se immagini che un linguaggio parte da insiemi di grafi, dobbiamo supporre di fare un join tra grafi. Come ti muoveresti?


12. Dati semistrutturati che problematiche vedi nell'uso di questi dati per l'apprendimento automatico.
	problema piu importante è la mancanza di uno schema che differiscono da un caso all'altro.

 
13. Perchè abbiamo introdotto il Vectore Space model? Cosa non andava bene nel modello booleano?

14. ETL nel data warehouse.
	Estrazione dei dati dalle diverse sorgenti (statica o incrementale)
	Trasformazione: trasformazione e cleaning dei dati in un formato valido per il dw
	Loading: caricamento dei dati nel dw

15. Differenza tra i sistemi SQL e i sistemi NoSQL.
	SQL rispettano la proprietà ACID mentre NoSQL rispettano la proprietà BASE(Basic Avaliability, Soft State, Eventual Consistency).
	La differenza fondamentale è che con i SQL c'è poca disponibilità, non ridondanza e forte consistenza, mentre nei NoSQL molta disponibilità, meno consistenza e appoccio best effort


16. Star Schema e Snowflakes schema nei Data Warehouse.
	Tabella dei fatti al centro dello schema in entrambi.
	1. Ha ridondanza e ha una sola tabella per dimensione
	2. Elimina la ridondanza frammentando in più tabelle gerarchiche normalizzate

17. Valutazione dei sistemi di Information Retrieval tramite collezione TREC.
	Estrarre parole affini
	 - coefficiente di dice
	 - mutual information
	 - expected mutual information
	 - pearson's chi-squared


18. Abbiamo visto SQL/XML se volesismo fare SQL/Text che prende dati relazionali e li mette in documenti testuali 
	Clausola contain, i sistemi relazionali sono normalizzati quindi non ha senso fare tipo la frequenza dei termini 


19. Abbiamo visto SQL/XML, XPath e XQuery, relazione tra i tre linguaggi e differenze un po' ad alto livello.

20. Relazione tra misura e dimensione in un cubo di un data Warehouse.
	L'aggregazione delle misure cambia il livello di astrazione nel quale i dati vengono visualizzati.
	 - additive -> sommate su tutte le dimensioni
	 - semiadditive -> sommate su alcune dimensioni
	 - non additive -> non sommate per alcuna dimensione

21. SQL per gestire immagini o video.

22. Come nasce cosa fa e che caratteristiche ha XQuery.