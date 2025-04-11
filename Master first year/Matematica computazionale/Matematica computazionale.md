
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

Mathematica non esegue mai una (qualsiasi) operazione numerica che potrebbe convertire una espressione esatta in una approssimata.
eg. `Sqrt[3]` -> $\sqrt 3$
Perché per fare ciò dovrebbe inserire una approssimazione (dato che `Sqrt[3]` non ha una rappresentazione decimale finita).
invece
`Sqrt[3.]` -> `1.73205`
L’argomento 3. (della funzione `Sqrt[ ]`) è considerato approssimato, perché contiene la virgola mobile ed e' considerato gia' approssimato.

`N[]` -> valuta sempre numericamente ogni espressione esatta.

<u>MachinePrecision + ExactPrecision = MachinePrecision</u> (ovviamente)

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
Null appare se sopprimiamo esplicitamente un output (magari perche’ è troppo grande, oppure perché non ci interessa vederlo)

`SetDelayed[ ]` -> funzione che opera producendo un effetto collaterale (side effect):
il risultato atteso dalla esecuzione della funzione non è il return value, ma è piuttosto un *cambiamento apportato allo stato della sessione di Mathematica* (aka valuta l'espressione non nel momento della chiamata di SetDelayed ma quando richiamiamo la "variabile")

==Disgressione==
```mathematica
(* Ricetta per un disastro! *)
yin := yang
(* il primo statement dice al Kernel che yin può essere riscritto come yang *)
yang := yin
(* il secondo statement dice al Kernel che yang può essere riscritto come yin *)
```
- attenti alle dipendenze cicliche, altrimenti avrete `$IterationLimit: Iteration limit of 4096 exceeded.`, perche' yin diventa yang e yang diventa yin ciclicamente.
- per evitarlo si usa `Hold[yin]`, che dopo $2^{12}$ iterazioni, Mathematica fa automaticamente

`Message[]` -> può essere chiamata direttamente (dal programmatore, per associare messaggi di errore o warnings alle funzioni che lei/lui scrive)
## 2.3 Operatori, Funzioni, Espressioni Composite, Liste, Rule
### 2.3.2 Operatori relazionali e booleani
Stessi operatori in C, short-circuit evaluation (in `FALSE && e_1`, `e_1` non viene evaluata, si ferma al false)
- And -> `&&`
- Or -> `||`
- Xor -> `Xor[e_1, e_2, ...]`
- Equal -> ` ==`
- Unequal -> `!=`
- LessEqual -> `<=`

Proprieta' Funzioni
- Idempotenza -> `OneIdentity` `f[x],f[f[x]], ...` sono equivalenti a `x`
- Associativa ->`Flat` `f[f[a,b],f[c]] = f[a,b,c]`
- Commutativa -> `Orderless` `f[a,b]=f[b,a]`
- Listable -> `f[a,b,c] = f[a],f[b],f[c]`
- Protected -> previene i simboli dall'essere modificati (eg. $\pi$)

Gli operatori relazionali possono essere usati a catena
`5 > 4 > 3` corrisponde a `5 > 4 && 4 > 3` -> `True`
I simboli rimangono Unevaluated
- `SameQ[]` -> ` ===` evaluation dei simboli
- `UnsameQ[]` -> ` =!=` negazione logica di SameQ
### 2.3.6 Definizione di funzione
*Mathematica* ci permette di definire nostre funzioni.
```mathematica
z[x_ , y_] := x + y (* SetDelayed *)
(* z -> dichiarazione *)
(* x+y corpo funzione *)
```
- I valori dei parametri formali x ed y non dipendono dai valori dei simboli globali x ed y (perche' `z` e' definito con `setDelayed[]`.
- Se non la definiamo con `setDelayed[]`, definire `x` e `y` globalmente cambia il risultato della funzione (perche' valuta `x` e `y` globali e basta)
- `Blank[]` -> `x_` , indicano che sono parametri formali e non valori letterari

Possiamo definire `f` piu' volte e richiamare la versione che vogliamo a seconda degli argomenti
![[Pasted image 20250228111815.png]]


### 2.3.7 Espressioni Composite
```mathematica
Clear[a] ; a = 1 ; b = 2 ; a+b
```
- gli output saranno nella stessa linea, utile quando sono ingombranti
- `CompoundExpression[]` -> `;`
- i `;` permettono uno stile di programmazione simil C per le funzioni
```mathematica
f[x_] := (
	firstLine;
		secondLine;
	...
	lastLine
)
```
- psa. usate `Block[]` o Module/DynamicModule per scrivere funzioni (vediamo dopo)
- la prof non vuole vedere parentesi tonde nei progetti
### 2.3.8 Liste
Sono la struttura dati base in Mathematica
```mathematica
{1,x,i+j, Graphics[Circle[], ImageSize -> Tiny]}
```
- Indici iniziano da 1 😦

Possiamo fare plot 2D e 3D
![[Pasted image 20250228112615.png]]
![[Pasted image 20250228112701.png]]
Ci sono diverse built-in per la manipolazione liste
```mathematica
miaLista = Table[i,{i,10}];
mialista
---
{1,2,3,4,5,6,7,8,9,10}
```
- `Table[f[iterator], {iterator, start, stop, step} *]` -> crea liste e le popola
- per accedere ad un indice usiamo `[[]]`
- Le liste possono essere annidate, non sono matrici ma si accedono come se lo fossero
```mathematica
miaLista = {a, {b, c, {d, e}, f}, g}
d == miaLista[[2, 3, 1]] 
---
True
```
- `MatrixForm[lista]` -> converte una lista in forma matrice (visualizzazione)

Lista stampata come Tree
![[Pasted image 20250228114224.png]]
### 2.3.9 Rules
- `Rule[a,b]` -> `a -> b`
- container per una coppia di espressioni con forma speciale di I/O
- `ReplaceAll[expression, rule]` -> `/.` applica la regola ad una lista, eg
```mathematica
ReplaceAll[x+y^2, x -> w]
---
w + y^2
```
- Un altro impiego comune per le Regole e’ nello specificare Opzioni ad una funzione, detti “argomenti-con-nome” (named arguments) ed hanno la forma nome → valore (name → value).

- La built-in `Options[ ]` restituisce la lista di tutti gli argomenti opzionali (e dei loro valori di default) di una data funzione
- `SetOptions[ ]` ->  cambia i valori di default per gli argomenti opzionali di una funzione (utile se dobbiamo chiamare una funzione tante volte)

Il resto di questo file parla di come usare i plot, sicuramente sara' utile ma lo vedro' da solo quando mi servira', non lo sto a segnare qui (sono pigro)

## 6 Programmazione basata su Regole
### 6.1.1 Pattern
**Pattern** -> espressione in Mathematica che rappresenta una intera classe di espressioni (eg. il Blank `_` singolo)
I pattern possono essere usati per alterare la struttura di espressioni.

Regola che eleva al quadrato ogni numero reale nella espressione `expr`
```mathematica
expr = 3a+4.5b^2
expr /. x_Real -> x^2
```

- `x_Symbol` sostituisce i simboli, attenti ad usare sta roba

```mathematica
expr /. x_Symbol -> x^2
---
Plus^2[Times^2[3, a^2], Times^2[4.5, Power^2[b^2 , 2]]]
```
- `Plus^2` e' privo di ogni significato e non valutabile, stessa cosa per ogni altra sostituzione
- Pero' e' utile per cambiare operazione, eg `Plus -> Times`

Possiamo definire una lista di sostituzioni per comodità
```mathematica
expr /. {a -> x^2, b -> x^2}
---
3x^2 + 4.5x^4
```

Possiamo usare pattern per definire variabili-pattern (pattern variables)
```mathematica
test = (f[a] + g[b])/(f[a,b]);

test /. expr_f -> expr^2
---
(f[a]^2 + g[b])/(f[a,b]^2);
```
- `expr_f` matcha tutte le espressioni con head `f`
- `f[x_]` matcha head `f` ed una sola variabile x in chiamata
### 6.1.3 Testare Pattern
#TODO 
### 6.1.4 Ruolo degli Attributes
### 6.1.5 Funzioni Built-in che usano Pattern
### 6.2.2 DownValues
`DownValues[f]` or `? f` -> restituisce le regole corrispondenti alle definizioni fatte per il simbolo `f`

Come la prof vuole che programmiamo:
```mathematica
f[ x_ /; x > - 2] := g1[x];
f[x_ /; x < 2] := g2[x];

DownValues[ f] // TableForm
```
g1 e g2 non sono ancora definite, pero' il "redirecting" e' gia' operativo

`/;` -> condizionale


### Module and Block
**Module** -> scoping statico o lessicale (localizza i nomi di variabile): le variabili sono trattate come locali ad una determinata <u>sezione del codice</u> (in un programma).  
**Block** -> scoping dinamico (localizza i valori delle variabili): le variabili sono trattate come locali ad una determinata parte della <u>history di esecuzione</u> (di un programma).

==Block example==
```mathematica
z;
x=1;
print["prima block: x= ", x, ", z= ", z];
Block[ {x} (* local "variable" *)
z=x;

print["dentro block: x= ", x, ", z= ", z];
]

print["fuori block: x= ", x, ", z= ", z];

x=2;

print["x riassegnata: x= ", x, ", z= ", z];
---
(*
prima block: x=1, z=z
dentro block: x=x, z=x
finita block: x=1, z=1
x riassegnata: x=2, z=2
*)
```
Block crea una parte di codice che cambia temporaneamente il valore delle variabili d'interesse

==Module example==
```mathematica
z;
x=1;
print["prima module: x= ", x, ", z= ", z];
Module[ {x} (* local "variable" *)
z=x;

print["dentro module: x= ", x, ", z= ", z];
]

print["fuori module: x= ", x, ", z= ", z];

x=2;

print["x riassegnata: x= ", x, ", z= ", z];
---
(*
prima module: x=1, z=z
dentro module: x=x$3723, z=x$3723
finita module: x=1, z=x$3723
x riassegnata: x=2, z=x$3723
*)
```
Ogni volta che Module è usata, viene creato un nuovo simbolo per rappresentare ciascuna delle sue variabili locali.


### 6.2.3 Definizioni multiple per uno stesso simbolo File
#TODO 
### 6.2.5. Rimuovere selettivamente le definizioni File
### 6.2.6. Programmazione "puramente" basata su regole 
### 6.3.1. Pattern di vincolo 
3 costrutti possono essere usati come pattern di vincolo
- `_head`  -> Un Blank puo' essere vincolato a combaciare solo con certe espressioni aventi un Head particolare (eg. `_Integer`)
- `_?test` -> test puo' essere qualsiasi funzione di un solo argomento, e se restituisce true il pattern combacia (eg `_?IntegerQ`)
	- Possiamo usare test definiti da noi
	- Possiamo combinare pattern (eg. `_Integer?NonNegative`)
- `/;` -> Condition (eg. `factorial1[ n_ Integer /; NonNegative[n]] := body[ n ]` )

Common mistake:
```Mathematica
(* SI! *) f[x_ , y_ ] /; x < y := body[x];  
(* NO *) f[x_ , y_ /; x < y ] := body[x];
(* la condition si applica a y_ solamente e riferisce alla variabile x globale*)
```


==Single, double, triple blank==
identificano 1,2,3 patterns
![[Pasted image 20250314112555.png]]
`_` -> single "element"
`_ _` -> any number of elements minus none
`_ _ _` -> any number of elements


## Packets
###
#TODO
###
## Dynamic
`Dynamic[exp]` ->Built in che aggiorna l'output man mano che cambia (valuta nuovamente l'espressione)

`Slider[0.5]` -> built in che crea uno slider centrato su 0.5 tra 0 ed 1

```mathematica
{Slider[Dynamic[q]], Dynamic[q]}
---
(* slider con visualizzazione aggiornata*)
```

E' possibile usarlo anche per disegnare funzioni
![[Pasted image 20250331114723.png]]




##
# Project
## Cose da evitare/fare
### No-Nos
- La prof <u>non</u> vuole piu' istruzioni raggruppate nelle parentesi tonde (compound expressions), non bisogna usare questo modo di scrivere funzioni
	```mathematica
f[x_] := (
	firstLine;
		secondLine;
	...
	lastLine
)
```
- La prof <u>non</u> vuole che venga usata la funzione del simbolo `%`
- La prof <u>non</u> vuole che venga effettuato l'accesso a variabili globali dentro una `Module` o `Block`
- La prof <u>non</u> vuole variabili nel contesto globale in aree private
- La prof <u>non</u> vuole codice ripetuto
- La prof <u>non</u> vuole messaggi di errori/celle non valutate, ogni possibile errore dev'essere gestito
### Musts
- La prof vuole una programmazione rule-based
- La prof vuole documentazione dettagliata (ogni funzione descritta con input ed output descritti) con una lingua consistente per tutta la doc
- ogni pacchetto creato deve avere l'intestazione, eg:
```mathematica
(* :Title: MappaComplessa4 *)  
(* :Context: MappaComplessa4` *)  
(* :Author: GS *)  
(* :Summary: a version of the ComplexMap package *)  
(* :Copyright: GS 2025 *)  
(* :Package Version: 3 *)  
(* :Mathematica Version: 14 *)  
(* :History: last modified 14/ 3/ 2025 *)  
(* :Sources: bblio *)  
(* :Limitations: educational purposes *)  
(* :Discussion: Passare Options a routine ausiliarie *)  
(* :Requirements: *)  
(* :Warning: DOCUMENTATE TUTTO il codice *)
```

## Elementi Progetto
- Tutorial con report e frontend
- Pacchetto
- Un minimo di testing per il catch degli errori

#
