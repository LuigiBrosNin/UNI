1. Come si acquisiscono i dischi RAID?
	- La dimensione è la preoccupazione maggiore perché molti sistemi RAID ora stanno spingendo in exabyte o più di dati.

2. Quanta memoria di dati è necessaria per acquisire tutti i dati per un'immagine forense?
	- Pari alla dimensione degli archivi di memoria che si vogliono acquisire.

3. Che tipo di RAID viene utilizzato?
	- I tipi piu' comuni di RAID utilizzati sono
		- RAID 0 (striping)
		- RAID 1 (mirroring)
		- RAID 5 (distributed parity)
		- RAID 6 (dual parity)
	- diversi livelli di RAID possono essere combinati o innestati, ad esempio RAID 10 (striping of mirrors)

4. è necessario che tutte le unità siano collegate in modo che il sistema operativo ne veda il contenuto?
	- Se viene utilizzata un'acquisizione in formato proprietario con compressione applicata, è necessaria una minore memorizzazione dei dati. Tutti gli strumenti di analisi forense possono analizzare un'immagine perché vedono i dati acquisiti come un'unica unità di grandi dimensioni, non come tante unità separate.
	- Poiché i sistemi RAID possono avere dozzine o più terabyte di archiviazione dei dati, copiare tutti i dati non è sempre pratico. Per queste occasioni, recuperare solo i dati rilevanti per l'indagine con il metodo di acquisizione sparso o logico è l'unica soluzione pratica.

5. Come si acquisiscono le mail e come si presentano al giudice?
	- accedi al computer o al dispositivo mobile della vittima per recuperare le prove su di esso.
	- Utilizzando il client di posta elettronica della vittima, trova e copia qualsiasi potenziale prova.
	- Con un'indagine aziendale, assicurati che le politiche siano in atto per questa azione. Per un'indagine penale, sono necessari mandati per accedere o ottenere copie di file su un server.
	- L'intestazione contiene numeri identificativi univoci, come l'indirizzo IP del server che ha inviato il messaggio. Queste informazioni consentono di rintracciare l'e-mail del sospettato

6. Steganografia
	- La steganografia è una tecnica che si prefigge di nascondere la comunicazione tra due interlocutori. La steganografia, al contrario della crittografia, consente di nascondere un messaggio all'interno di un vettore che possa consentirne il trasporto senza destare sospetti. Nella steganografia digitale, le comunicazioni elettroniche possono includere la codifica steganografica all'interno di un livello di trasporto, ad esempio un file di documento, un file di immagine, un programma o un protocollo. I file multimediali sono ideali per la trasmissione steganografica a causa della loro grande dimensione. Ad esempio, un mittente potrebbe inviare un file di immagine innocuo e regolare il colore di un pixel ogni cento per farlo corrispondere a un carattere alfabetico. La modifica è così sottile che qualcuno che non lo cerca in modo specifico è improbabile che noti la modifica.

7. Hashing
	- Si tratta di un algoritmo matematico che mappa dei dati di lunghezza arbitraria in una stringa binaria di dimensione fissa chiamata valore di hash. Tale funzione di hash è progettata per essere unidirezionale (one-way), ovvero una funzione difficile da invertire.
	- La crittografica di hash ideale deve avere alcune proprietà fondamentali:
		- deve identificare univocamente il messaggio, non è possibile che due messaggi differenti, pur essendo simili, abbiano lo stesso valore di hash;
		- deve essere deterministico, in modo che lo stesso messaggio si traduca sempre nello stesso hash;
		- deve essere semplice e veloce calcolare un valore hash da un qualunque tipo di dato;
		- deve essere molto difficile o quasi impossibile generare un messaggio dal suo valore hash se non provando tutti i messaggi possibili.

8. Differenza tra usb 2.0 e 3.0
	- La velocità massima del 2.0 è di 480MB/s, del 3.0. 4,8Gb/s. Il 3.0. è 10 volte più veloce! Il 2.0. ed il 3.0. funzionano in modi diversi: il 2.0. ha solo la possibilità di scrivere o leggere i dati mentre il 3.0. può fare entrambe le cose contemporaneamente. Questo è il motivo per il quale il 2.0. ha 4 cavi ed il 3.0. ne ha 9.

9. Tipi di acquisizione
	- Acquisizione a runtime (peggior metodo dato che siamo in un ambiente non controllato)
	- Estrarre fisicamente il disco dal pc (non sempre possibile)
	- Live da un altro OS sullo stesso dispositivo (bisogna maneggiare con il processo di boot)

10. Differenza tra acquisizione logica e sparsa
	- (sparsa -> raw)
	- l'acquisizione sparsa e' un'acquisizione bit a bit del device fonte
	- l'acquisizione logica e' un'acquisizione di file selezionati
	- entrambe sono mantenute in un file di immagine forense

11. Come si acquisisce un file non allocato?
	- con un'acquisizione sparsa, ovvero bit a bit del dispositivo di archiviazione

12. Cos’è l’OCR?
	- L'**OCR** (Optical Character Recognition, ovvero "Riconoscimento Ottico dei Caratteri") è una tecnologia che consente di **convertire** immagini di testo stampato o scritto a mano in **testo digitale** modificabile e ricercabile.

13. Slack in windows 
	- lo slack e' lo spazio "avanzato" dentro un cluster dopo l'End of file. Puo' contenere dati di vecchi file, quasi esclusivamente incompleti. puo' avvenire solo negli hard disk, non in SSD.

14. Cosa sono rainbow table
	- Le **rainbow table** sono strumenti utilizzati nella **sicurezza informatica** per **decifrare** le **password** criptate, sfruttando un processo di **precomputazione**. Sono tabelle precompilate che contengono una grande quantità di hash di password comuni e le relative password in chiaro.

15. Write blocker spiegare
	- assicura l'integrita' dei device che si sta leggendo
	- Puo' essere sia hardware che software

17. Come si acquisisce VM 
	- ???

18. ordine di acquisizione da più a meno volatili
	- RAM
	- Cache/registri di sistema
	- Dati di rete (pacchetti)
	- File di paging e file di swap
	- dispositivi di memorizzazione non volatili (HD, SSD)
	- File di sistema e log (inclusi nei dispositivi non volatili)
	- Non e' sempre possibile acquisire i dati piu' volatili (eg. la RAM)

19. Ssd e acquisizione (garbage collection e trim)
	- Garbage collection e Trim sono meccanismi delle ssd che modificano o eliminano attivamente i dati, anche quelli che potrebbero sembrare ancora presenti a livello logico.
	- La Garbage Collection è un meccanismo che:
		- Raccoglie i blocchi di celle di memoria che sono "segnati come liberi" (cioè, che contengono dati obsoleti o cancellati).
		- **Sovrascrive** queste celle con nuovi dati per liberare spazio e mantenere le prestazioni dell'SSD.
	- TRIM segnala esplicitamente all'SSD che i blocchi di memoria che contenevano i dati eliminati possono essere cancellati immediatamente.

20. Formati di acquisizione vari, se sono proprietari e blabla
	- .img/.dd 
		- e' il formato delle acquisizioni forensi standanrd e libero, non contiene metadati avanzati come hash o dettagli sulla catena di custodia
	- .E01
		- EnCase (Guidance Software)
		- È un formato proprietario, quindi richiede EnCase per l'analisi, sebbene alcuni strumenti forensi possano supportare l'importazione di immagini E01.
	- AFF
		- Il formato **AFF** è proprietario, ma è un formato più aperto rispetto ad altri.
		- Riconosciuto da FTK imager
	- AD1
		- AccessData FTK
		- Il formato **AD1** è un formato di acquisizione proprietario sviluppato da **AccessData**. Supporta la creazione di immagini di disco bit-per-bit e memorizza metadati per garantire l'integrità dell'immagine acquisita.
	![[Pasted image 20250222121507.png]]


21. Autenticita' e integrita'
	- Relativo ai documenti digitali:
	- solo alcuni formati sono accettati, poiche' devono essere leggibili anche dopo diversi anni (so (eg) .CAD files are not ok, PDFs and PNGs are okay)
	- Documenti dinamici
		- documenti che contengono macro
		- documenti che contengono links
	- i docs dinamici non possono essere firmati con sicurezza dato che il loro output puo' cambiare, non garantendo l'integrita'.
	- Relativo agli Hash:
		- gli hash sono la base per garantire autenticita' di un documento, l'impronta digitale di un file.

22. Timeline
	- Legge gli ultimi accessi e modifiche
	- Legge i registri
		- contiene la cronologia del browser
		- contiene i dispositivi connessi
		- contiene tutte le connessioni al server
		- contiene le posizioni di archiviazione e le configurazioni dei driver


23. NIST
	- **NIST** (National Institute of Standards and Technology)
	- Il NIST crea e promuove standard e linee guida che disciplinano la pratica della digital forensics. Forniscono le **migliori pratiche** per la raccolta, l'analisi e la gestione dei dati durante le indagini digitali.
	- Il NIST sviluppa e supporta vari **strumenti open-source** e risorse software, quali:
		- **Forensic Tool (FTK Imager)**
		- **NIST Computer Forensic Tool Testing (CFTT)**
		- 



