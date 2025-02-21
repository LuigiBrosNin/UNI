NOTE IN ITALIANO

SILLABO -> https://www.unibo.it/it/studiare/dottorati-master-specializzazioni-e-altra-formazione/insegnamenti/insegnamento/2024/479026
Avvisi -> https://www.unibo.it/sitoweb/giulia.spaletta/avvisi

- Link vari
	- ![[MC-LinkVari.pdf]]
	- 

# Notes

## Mathematica tutorial
[Free licence with Unibo](https://www.unibo.it/it/studiare/vivere-luniversita-e-la-citta/agevolazioni-per-computer-tablet-e-software/mathematica-licenza-campus)

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

**Espressioni** -> sono l’unico tipo di oggetto in Mathematica, vengono usate per rappresentare sia il codice che i dati.
- Struttura annidata, espressioni composte da altre espressioni fino ad atomi (non suddivisibili)
- Il Kernel rimpiazza espressioni (rispettando uno standard stabilito su come rappresentare certe espressioni)
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

##
##

#