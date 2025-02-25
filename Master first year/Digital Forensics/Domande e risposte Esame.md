1. Come si acquisiscono i dischi RAID?
	- Numera i vari dischi e poi acquisisci disco per disco, una volta finita l'acquisizione puoi ricreare il raid avendo numerato i dischi, dovrai avere tanto spazio per poter acquisire tutti i dischi del raid, per alcuni casi quindi sarebbe meglio fare un'acquisizione sparsa
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

4. è necessario che tutte le unità siano collegate in modo che il sistema operativo ne veda il contenuto?  ovvero se, per accedere ai dati memorizzati su un array RAID, sia indispensabile che tutti i dischi che compongono il RAID siano fisicamente collegati e riconosciuti dal sistema operativo?
	1. Risposta Luizo
		- Se viene utilizzata un'acquisizione in formato proprietario con compressione applicata, è necessaria una minore memorizzazione dei dati. Tutti gli strumenti di analisi forense possono analizzare un'immagine perché vedono i dati acquisiti come un'unica unità di grandi dimensioni, non come tante unità separate.
		- Poiché i sistemi RAID possono avere dozzine o più terabyte di archiviazione dei dati, copiare tutti i dati non è sempre pratico. Per queste occasioni, recuperare solo i dati rilevanti per l'indagine con il metodo di acquisizione sparso o logico è l'unica soluzione pratica.
	2. Risposta Giuseppe
		- Dipende dal tipo di RAID tipo per un raid 0 essendo tutti i dati sparsi in stripping 
	    - per forza devi avere tutti gli strip per accedere ai dati
	    - per Raid 1 basta che hai la meta' dei dischi 
	    - per RAID 5 puoi non avere un disco tanto viene ricostruito dal sistema di parita'
	    - per RAID 6 come 5 ma puoi non avere due dischi
    

5. Come si acquisiscono le mail e come si presentano al giudice?
	- accedi al computer o al dispositivo mobile della vittima per recuperare le prove su di esso.
	- Utilizzando il client di posta elettronica della vittima, trova e copia qualsiasi potenziale prova.
	- Con un'indagine aziendale, assicurati che le politiche siano in atto per questa azione. Per un'indagine penale, sono necessari mandati per accedere o ottenere copie di file su un server.
	- L'intestazione contiene numeri identificativi univoci, come l'indirizzo IP del server che ha inviato il messaggio. Queste informazioni consentono di rintracciare l'e-mail del sospettato

6. Steganografia
	- La steganografia è una tecnica che si prefigge di nascondere la comunicazione tra due interlocutori. La steganografia, al contrario della crittografia, consente di nascondere un messaggio all'interno di un vettore che possa consentirne il trasporto senza destare sospetti. Nella steganografia digitale, le comunicazioni elettroniche possono includere la codifica steganografica all'interno di un livello di trasporto, ad esempio un file di documento, un file di immagine, un programma o un protocollo. I file multimediali sono ideali per la trasmissione steganografica a causa della loro grande dimensione. Ad esempio, un mittente potrebbe inviare un file di immagine innocuo e regolare il colore di un pixel ogni cento per farlo corrispondere a un carattere alfabetico. La modifica è così sottile che qualcuno che non lo cerca in modo specifico è improbabile che noti la modifica.

7. Hashing
	1.  Risposta Luizo
		- Si tratta di un algoritmo matematico che mappa dei dati di lunghezza arbitraria in una stringa binaria di dimensione fissa chiamata valore di hash. Tale funzione di hash è progettata per essere unidirezionale (one-way), ovvero una funzione difficile da invertire.
		- La crittografica di hash ideale deve avere alcune proprietà fondamentali:
			- deve identificare univocamente il messaggio, non è possibile che due messaggi differenti, pur essendo simili, abbiano lo stesso valore di hash;
			- deve essere deterministico, in modo che lo stesso messaggio si traduca sempre nello stesso hash;
			- deve essere semplice e veloce calcolare un valore hash da un qualunque tipo di dato;
			- deve essere molto difficile o quasi impossibile generare un messaggio dal suo valore hash se non provando tutti i messaggi possibili.
	2. Risposta Giuseppe
		- la funzione hash e' una funzione matematica che mappa dati di lunghezza arbitraria in una stringa di dimensione fissa, e' una funzione one-way ovvero molto difficile da invertire, in digital forensics gli hash possono essere usati per checkare l'integrita' di un file o per escludere file da una ricerca per identificare file noti senza vederne il contenuto o anche filtrare duplicati in una ricerca.
	    - Inoltre gli hash soffrono del fenomeno delle collisioni, allora non hanno valore legale? No, si e' detto che comunque hanno valore legale poiche' il fatto che due documenti di senso sensato collidono sullo stesso hash e che provano due fatti diversi e' impossibile.
	    - Generalmente gli algoritmi usati sono MD5, SHA-1 o SHA-256.
	    - Ricordati che checksum 64 bit non e' un algoritmo di hashing e serve invece a verificare se una porzione di memoria e' stata sterilizzata correttamente 

8. Differenza tra usb 2.0 e 3.0
	1. Risposta
		- La velocità massima del 2.0 è di 480MB/s, del 3.0. 4,8Gb/s. Il 3.0. è 10 volte più veloce! Il 2.0. ed il 3.0. funzionano in modi diversi: il 2.0. ha solo la possibilità di scrivere o leggere i dati mentre il 3.0. può fare entrambe le cose contemporaneamente. Questo è il motivo per il quale il 2.0. ha 4 cavi ed il 3.0. ne ha 9.
	2.  Risposta Giuseppe
		- Usb 2.0 ha una velocita' massima teorica di 480 mega bit al secondo, ha 4 fili. Generalmente il connettore e' nero o bianco
	    - Usb 3.0 ha una velocita' massima teorica di 4.8 gigabit al secondo, 10 volte usb 2.0, ha 9 fili e quindi riesce a scrivere e leggere dati contemporaneamente, generalmente il connettore e' blu

9. Tipi di acquisizione
	1. Risposta Luizo
		- Acquisizione a runtime (peggior metodo dato che siamo in un ambiente non controllato)
		- Estrarre fisicamente il disco dal pc (non sempre possibile)
		- Live da un altro OS sullo stesso dispositivo (bisogna maneggiare con il processo di boot)
	2. Risposta Giuseppe
		- acquisizione live - puo' compromettere i dati ma serve se bisogna acquisire pure dati di memorie volatili 
	    - copia forense - copia bit a bit, , acquisisci pure file eliminati o slack space, una volta veniva molto usata prima che venissa introdotta l'acquisizione con immagine forense poiche' la copia forense ha il difetto che il dispositivo dest su cui salvi la copia deve essere sterile 
	    - immagine forense - viene fatta l'acquisizione e viene wrappata nell'immagine forense, acquisisci pure file eliminati o slack space
	    - acquisizione logica - si fa l'acquisizione a livello logico del file system quindi solo quello che vede il file system, non puoi acquisire file eliminati, slack space, e' piu' veloce rispetto all'acquisizione fisica e, in alcuni casi, puoi fare solo l'acquisizione logica tipo se devi acquisire il cloud personale di un utente oppure quando devi acquisire un server che pero' non puoi spegnere

10. Differenza tra acquisizione logica e sparsa
	1. Risposta Giuseppe
		- acquisizione sparsa si acquisiscono solo una porzione dei device target, puo' essere sia logica che fisica, serve perche' e' piu' veloce
	    - acquisizione logica si fa l'acquisizione a livello logico del file system quindi solo quello che vede il file system, non puoi acquisire file eliminati, slack space

11. Come si acquisisce un file non allocato?
	1. Risposta Luizo
		- con un'acquisizione completa del dispositivo, ovvero bit a bit del dispositivo di archiviazione
	2. Risposta Giuseppe
		- un file non allocato e' un file eliminato dall'utente e quindi non piu' visibile dal sistema operativo che contrassegna quella porzione di memoria come libera o non allocata, per poterlo acquisire si deve fare per forza un'acquisizione fisica

12. Cos’è l’OCR?
	1. Risposta Luizo (chatgpt lol)
		- L'**OCR** (Optical Character Recognition, ovvero "Riconoscimento Ottico dei Caratteri") è una tecnologia che consente di **convertire** immagini di testo stampato o scritto a mano in **testo digitale** modificabile e ricercabile.
	2. Risposta Giuseppe
		- L’OCR sta per Optical Character Recognition. È una tecnologia che consente di convertire immagini di testo (scritto o stampato) in testo digitale editabile e ricercabile. In pratica, "legge" il contenuto di un’immagine e lo trasforma in caratteri che un computer può elaborare. Puo' essere utile per digitalizzare testi cartacei.

13. Slack in windows
	1. Risposta Luizo
		- lo slack e' lo spazio "avanzato" dentro un cluster dopo l'End of file. Puo' contenere dati di vecchi file, quasi esclusivamente incompleti. puo' avvenire solo negli hard disk, non in SSD.
	2. Risposta Giuseppe
		- l'unita' piu' piccola di storage di dati in un file system e' chiamato cluster che poi puo' essere costituito da piu' settori un file puo' non fittare perfettamente lo spazio di un cluster e quindi vi e' dello spazio aggiuntivo chiamato Slack, per chi fa analisi forense e' fondamentale lo Slack space poiche' all'interno ci puoi trovare residui di file eliminati. Per quanto riguarda Windows, fino a un po' di tempo fa tipo in Windows 2000 nello spazio slack venivano salvate computazioni della RAM provocando dei problemi a livello di sicurezza, in seguito e' stato rimossa questa features

14. Cosa sono rainbow table
	- Le **rainbow table** sono strumenti utilizzati nella **sicurezza informatica** per **decifrare** le **password** criptate, sfruttando un processo di **precomputazione**. Sono tabelle precompilate che contengono una grande quantità di hash di password comuni e le relative password in chiaro.

15. Write blocker spiegare
	1. Risposta Luizo
		- assicura l'integrita' dei device che si sta leggendo
		- Puo' essere sia hardware che software
	2. Risposta Giuseppe
		- il write blocker e' fondamentale per non compromettere i dati durante l'acquisizione assicura l'integrita' dei dati
	    - write blocker fisico - e' un dispositivo fisico attaccato ai due dispositivi (il tuo pc) e il dispositivo a cui fai l'acquisizione, si usa generalmente quando devi fare l'acquisizione di un pc e hai la possibilita' di estrarre il suo hard disk che vuoi acquisire
	    - write blocker software - ad esempio Paladin offre questa funzione oppure dd anche se non preserva gli hash dell'acquisizione e quindi vi e' l'estensione dc3dd vengono usati write blocker software quando e' scomodo rimuovere l'hard disk dal pc target e quindi si usa una chiavetta USB con una distro LIVE (ovvero che non salva i dati in maniera persistente sulla chiavetta) per creare una distro Live si puo' usare RUFUS

17. Come si acquisisce VM 
	1. Risposta Giuseppe
		per prima cosa devi individuare il path alla virtual machine dove sono salvati tutti i file relativi alla virtual machine tipo file relativi al file system della cvm oppure file relativi allo snapshot della vm oppure file relativi alla configurazione della vm o anche file relativi allo stato della RAM della vm quindi della memoria  volatile, ogni tipologia di file che ho elencato avra' un estensione diversa ed essa dipende anche dall'azienda che gestisce vm tipo Virtual Box, una volta identificati questi file fai un'acquisizione logica se vuoi fare un'acquisizione live o fisica se non ti serve recupare la memoria volatile

18. ordine di acquisizione da più a meno volatili
	1. Risposta Luizo
		- RAM
		- Cache/registri di sistema
		- Dati di rete (pacchetti)
		- File di paging e file di swap
		- dispositivi di memorizzazione non volatili (HD, SSD)
		- File di sistema e log (inclusi nei dispositivi non volatili)
		- Non e' sempre possibile acquisire i dati piu' volatili (eg. la RAM)
	2. Risposta Giuseppe
		- e' importante l'ordine di acquisizione dei dati volatili per non compromettere i dati acquisiti, ad esempio se acquisi prima una cosa non volatile magari la cosa volatile si puo' perdere
	    - live system - log di sistema 
	    - running - i processi running 
	    - network - ARP table, routing table, connessioni
	    - virtual - dispositivi virtuali, ad esempio una virtual machine e quindi puoi acquisire lo snapshot della macchina
	    - physical - dispositivi fisici come USB o Hard Disk

19. Ssd e acquisizione (garbage collection e trim)
	1. Risposta Luizo
		- Garbage collection e Trim sono meccanismi delle ssd che modificano o eliminano attivamente i dati, anche quelli che potrebbero sembrare ancora presenti a livello logico.
		- La Garbage Collection è un meccanismo che:
			- Raccoglie i blocchi di celle di memoria che sono "segnati come liberi" (cioè, che contengono dati obsoleti o cancellati).
			- **Sovrascrive** queste celle con nuovi dati per liberare spazio e mantenere le prestazioni dell'SSD.
		- TRIM segnala esplicitamente all'SSD che i blocchi di memoria che contenevano i dati eliminati possono essere cancellati immediatamente.
	2. Risposta Giuseppe
		- Il firmware dell'SSD fa delle operazioni in maniera arbitraria che possono  compromettere l'hash dell'acquisizione infatti se uno fa l'acquisizione magari oggi con un certo hash e poi non usa piu' il dispositivo e poi dopo qualche mese rifa' l'acquisizione senza cambiare i dati comunque l'hash puo' essere diverso.
	    - operazioni firmware:
	        - per preservare il componente fisico dell'SSD nei vari chips il firmware  puo' spostare dati fra diversi chips per non consumare esageratamente un certo chips ma espandere i dati fra tutti i chips 
	        - quando si elimina un file il garbage collector puo' far avvenire il processo  di trimming in cui vengono effettivamente eliminati file in spazio non allocato mettendo tutti i bit a 0 

20. Formati di acquisizione vari, se sono proprietari e blabla
	1. Risposta Luizo
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
	2. Risposta Giuseppe
		- dd - il formato raw di acquisizione e' dd (open source) ed e' associato a un comando linux chiamato dd, diversi tool forensics usano dd o sue estensioni come dc3dd, ad esempio FTK imager
	    - E01 - il formato di acquisizione del software proprietario EnCase, nel tempo E01 e' diventato un formato standard e ormai non solo EnCase lo usa
	    - AFF - formato open source di immagini forense 

    di base si usa dd o E01

21. Autenticita' e integrita'
	1. Risposta Luizo
		- Relativo ai documenti digitali:
		- solo alcuni formati sono accettati, poiche' devono essere leggibili anche dopo diversi anni (so (eg) .CAD files are not ok, PDFs and PNGs are okay)
		- Documenti dinamici
			- documenti che contengono macro
			- documenti che contengono links
		- i docs dinamici non possono essere firmati con sicurezza dato che il loro output puo' cambiare, non garantendo l'integrita'.
		- Relativo agli Hash:
			- gli hash sono la base per garantire autenticita' di un documento, l'impronta digitale di un file.
	2. Risposta GIuseppe
		- dipende in che contesto e' fatta questa domanda, se parliamo di autenticita' e integrita' di prove allora esse sono garantite dalla catena di custodia se parliamo di un file allora conviene parlare degli hash se parliamo di un documento digitale allora si parla che il CAD (codice amministrazione digitale) ha introdotto tre concetti:
		    - firma elettronica semplice - insieme di dati che attribuiscono un file a un individuo
		    - firma elettronica avanzata - permette di identificare in maniera univoca che e' stato quell'individuo a firmare
		    - firma digitale - firma col massimo valore legale, e' rilasciata da un ente certificatore accreditato

22. Timeline
	1. Risposta Luizo
		- Legge gli ultimi accessi e modifiche
		- Legge i registri
			- contiene la cronologia del browser
			- contiene i dispositivi connessi
			- contiene tutte le connessioni al server
			- contiene le posizioni di archiviazione e le configurazioni dei driver
	2. Risposta Giuseppe
		- la timeline e' fondamentale per capire il contesto nel quale e' avvenuto un determinato evento e per attribuire con maggiore fermezza un evento a una persona se si guarda solo il MAC di un file (Modified, Accessed, Created) il tutto e' abbastanza limitante e poi il MAC potrebbe essere modificato dall'utente stesso quindi conviene vedere tutto il contesto e creare una timeline per seguire come e' avvenuto un determinato evento, i vari passi, e vedere tanti file e sorgenti diverse come log di sistema o network, e' importante controllare pure il time system del pc. La timeline viene creata automaticamente dai tool forense avanzati come Autopsy


23. NIST
	1. Risposta Luizo
		- **NIST** (National Institute of Standards and Technology)
		- Il NIST crea e promuove standard e linee guida che disciplinano la pratica della digital forensics. Forniscono le **migliori pratiche** per la raccolta, l'analisi e la gestione dei dati durante le indagini digitali.
		- Il NIST sviluppa e supporta vari **strumenti open-source** e risorse software.
	2. Risposta Giuseppe
		- e' il National Institute of Standard and Technology, per quanto riguarda la digital forensics esso offre delle linee guida per creare degli standard a livello mondiale, offre dei dataset per validare e testare i propri tool forense o anche offre un documento per la catena di custodia, ha fornito pure il RDS (reference data set) che e' un insieme di hash di firme digitali di file sia di tool buoni che cattivi e dannosi e quindi puo' essere utile quando si fa un'acquisizione fare un check su questo dataset di firme digitali

24. catena di custodia
	1. Risposta Giuseppe
	    - la catena di custodia e' un registro dettagliato che documenta ogni passaggio della prova da quando e' stata acquisita al suo utilizzo finale (ad esempio viene usata in tribunale) essa garantisce l'integrita' della prova(non viene alterata o modificata) e autenticita' (la prova e' cio' che si afferma essere) nel documento della catena di custodia viene scritto quindi come e' stata acquisita la prova e quando e poi ogni passaggio di testimone con firma e data, e poi una descrizione della prova 


