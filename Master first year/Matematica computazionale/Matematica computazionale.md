
> Notes taken by Luizo ( [@LuigiBrosNin](https://t.me/LuigiBrosNin) on Telegram)

NOTE IN ITALIANO

SILLABO -> https://www.unibo.it/it/studiare/dottorati-master-specializzazioni-e-altra-formazione/insegnamenti/insegnamento/2024/479026
Avvisi -> https://www.unibo.it/sitoweb/giulia.spaletta/avvisi

- Link vari
	- ![[MC-LinkVari.pdf]]
	- 

# Notes
Le risorse su virtuale sono magnifiche, soprattutto per gli esercizi e la teoria, spiegati bene come se fossimo bambini :)))

## 2 Mathematica tutorial
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

### 2.1.1 Espressioni normali
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



### 2.1.2 Atomi
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
### 2.1.2 Numeri (Atomi)
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


## 2.2 Valutazione espressioni
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
- `SetDelayed[expression], :=` -> ritorna il risultato della valutazione di tale espressione quando richiediamo la "variabile"
	- eg `s2 = Sqrt[2] (*set*) - s3 := Sqrt[3]`
	- se valuto la cella, stampera' `Sqrt[2]`, verra' restituito `Null` (che non viene stampato), s3 verra' valutato e restituito quando chiederemo nuovamente di stampare/utilizzare s3 (⚠ valutato ogni volta che viene chiamato)

- **Disgressione** (aka roba che la prof ci fa vedere arricchendo la spiegazione)
```mathematica
(* Disgressione su Null e sul punto-e-virgola *)
f1[ x_] := Module[
	{tmp = x}
	While[tmp > 2, tmp = Sqrt[tmp]];
	(* NOTIAMO il punto-e-virgola dopo While[] *)
	tmp
];
f1[ 100.]
f2[ x_] := Module[{tmp = x},
	While[tmp > 2, tmp = Sqrt[tmp]]
	(* Nella Module, lo spazio tra While[] e statement tmp è interpretato come prodotto *) ×
	tmp
	(* Pertanto, viene restituito Null esito di While[] moltiplicato per il valore salvato in tmp *)
];
f2[ 100.]
---
1.77828
```
#TODO finish?
## 2.3 Operatori, Funzioni, Espressioni Composite, Liste, Rule
### Operatori relazionali e booleani
Stessi operatori in C, short-circuit evaluation (in `FALSE && e_1`, `e_1` non viene evaluata, si ferma al false)
- And -> `&&`
- Or -> `||`
- Xor -> `Xor[e_1, e_2, ...]`
- Equal -> ` ==`
- Unequal -> `!=`
- LessEqual -> `<=`

Proprieta' Funzioni
- Idempotenza -> `f[x],f[f[x]], ...` sono equivalenti a `x`
- Associativa -> `f[f[a,b],f[c]] = f[a,]`

###
###

#