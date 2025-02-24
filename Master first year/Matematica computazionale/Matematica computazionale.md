NOTE IN ITALIANO

SILLABO -> https://www.unibo.it/it/studiare/dottorati-master-specializzazioni-e-altra-formazione/insegnamenti/insegnamento/2024/479026
Avvisi -> https://www.unibo.it/sitoweb/giulia.spaletta/avvisi

- Link vari
	- ![[MC-LinkVari.pdf]]
	- 

# Notes
Le risorse su virtuale sono magnifiche, soprattutto per gli esercizi e la teoria, spiegati bene come se fossimo bambini :)))

## Mathematica tutorial
[Free licence with Unibo](https://www.unibo.it/it/studiare/vivere-luniversita-e-la-citta/agevolazioni-per-computer-tablet-e-software/mathematica-licenza-campus)

`ResourceFunction["DarkMode"][]` -> mette la darkmode lol

**Mathematica** -> sistema basato sulla riscrittura dei termini
aka sostituisce termini
```mathematica
a * a + D[ a ^ 3, a]
---
4 a^2
```

La funzione Trace ti spiega passo passo la sostituzione
`Trace(a * a + D[ a ^ 3, a])`
![[Pasted image 20250221100227.png]]

### Espressioni normali
**Espressioni** -> sono l’unico tipo di oggetto in Mathematica, vengono usate per rappresentare sia il codice che i dati.
- Struttura annidata, espressioni composte da altre espressioni fino ad atomi (non suddivisibili)
- Il Kernel rimpiazza espressioni (rispettando uno standard stabilito su come rappresentare certe espressioni)
- -Form desinenza indica che la "funzione" stampa in output quel che computa
==Ogni cosa in Mathematica è una espressione.==
ogni espressione normale ha forma `Head[part1, part2, ...]`
eg.
```Mathematica
Sin[Log[2.5,7]]
```
- Head e' un atomo (`Sin`)
- 1 parte (`Log[2.5,7]`), espressione normale
	- Head -> atomo `Log`
	- 2 parti -> num reale 2.5 e num intero 7

`RGBColor[1,0,0]` -> direttiva grafica, primitiva e non funzione, resa colore
![[Pasted image 20250221102829.png]]

Ogni espressione in Mathematica può essere costruita usando solo tre blocchi di costruzione sintattica: atomi, virgole, parentesi quadre `[ ]`.

FullForm e Map
![[Pasted image 20250221103011.png]]

`*-+^` -> forme speciali di input, al posto di Times, Minus, Plus etc. 



### Atomi
**Atomo** -> espressione che non puo' essere suddivisa
- Simbolo
	- `{a, abc, a2, a2b, $a, a$}`
	- non e' necessario assegnare un valore ad un simbolo
	- Un simbolo segnala se stesso.
	- Un simbolo non è meramente un sostituto (proxy) per un dato.
- Numero
- Stringa di caratteri
	- sequenza di caratteri racchiusa tra una coppia di apici
		![[Pasted image 20250221103804.png]]
	- ci sono built-in per agire sulle stringhe di caratteri
### Numeri (Atomi)
- Intero -> decimali `ddddd`
- Razionale -> `intero1/intero2`
	- i razionali si semplificano automaticamente (`4/6` -> `2/3`)
- Reale -> `dddd.dddd`
	- 16 cifre significative a 64 bit
	- soggette a machine precision invece che vera precisione
	- possiamo usare ScientificForm per avere il numero in notazione scientifica
- Complesso -> `a+b I` dove `a` e `b` sono qualsiasi dei tipi precedenti

- **Esatti** -> interi, razionali, complessi con coefficienti esatti
- **Approssimati** -> numeri che contengono sempre la virgola mobile
	- precisione di macchina
	- precisione arbitraria

TODO finish last 2 pages to recap


## Valutazione espressioni
- Il Kernel continua a riscrivere termini fino a che non rimane nulla che esso sappia riscrivere in una forma diversa.
- In analogia alla chiamata di funzione in altri linguaggi, chiamiamo valore di ritorno (return value) di una data espressione il risultato della valutazione di tale espressione.

- `Trace[expression]` -> ottieni una descrizione post mortem della valutazione
- `TreeForm[expression]` -> stampa l'espressione esplicitamente in forma d'albero
- `HoldForm[expression]` -> restituisce la stampa di un'espressione mantenendo l'espressione in formato non valutato (unevaluated) ( `Log(2.5 , 7)` rimane cosi' invece che un numero float)
- `Attributes[head]` -> verifica se una head simbolica inibisce la valutazione delle sue parti ed esaminare le caratteristiche
	- eg.
```mathematica
Attributes[HoldForm]
(* HoldForm ha la caratteristica HoldAll i.e. per tutte le
parti incluse nell'head HoldForm[] è inibita la valutazione *)
(* HoldForm ha la caratteristica Protected
i.e. il suo nome non è ridefinibile da utente *)
---
{HoldAll, Protected}
```

- `SetDelayed[]` -> rutirba uk rusyktati dekka valutazion

##

#