[Virtuale](https://virtuale.unibo.it/course/view.php?id=60686)

> Notes taken by Luizo ( [@LuigiBrosNin](https://t.me/LuigiBrosNin) on Telegram)

Exam notes
	exercises + oral exam (50/50 weight on the grade)
	5 exercises, 2 deadlines for the first 2 and the remaining 3
	deadlines: nov 1, dec 11
	high grades, if you fail the oral you do not repeat the exercises (at least within the same year, idk about following years)
	exercises uses MiniZinc


## Theory

This course reminds me a lot about Combinatorial Optimization, if you liked that, you'll like this. The prof seems really human and the exams seems chill.

### Intro
restrictions = constraints
any solution -> meets all constraints
optimal solution -> best solution according to an objective
![[Pasted image 20240923145936.png]]
AI is a tool for decision making too

Combinatorial decision making proprieties:
- computationally difficult (NP-hard)
- can only be solved by ==intelligent search== 
- experimental in nature 
- finding good/optimal solutions can save  time, money and reduce enviromental impact
Techniques
- incomplete methods (eg. Heurstic search)
- Complete methods (eg. Integer Linear Programming, Boolean Satisfiability, SAT modulo theories, ==constraint programming==)

What is constraint programmming?
==a declarative programming paradigm== -> 
- state our problem; 
- formalize:
	- decisions variables ($X_j$)
	- domains (possible values $D(X_j)=\{v_j\}$).
	- constraints (relations between variables $r(X_j,X_i)$)
- employ models to process and solve the problem.
- Example -> Covid-19 Test Scheduling
	
	> When and where to test each employee?
	
	**Availability Constraints** -> Testing room, tester, and employee availabilities.
	**Frequency constraints** -> The spacing between tests performed on the same employee should be within given bounds.
	**Operational constraints** -> Each employee should be tested within their working shift.
	Only a limited share of employees from the same work area should be scheduled for a test on the same day.

A constraint ==solver== finds a solution to the model (or prove that it doesn't exist) by assigning a value to every variable via a search algorithm.
Practically, we'll tweak the search algorithm to find the solution we want.

### Overview of CP
a ==Constraint solver== enumerates all possible variable-value combinations via a **systematic backtracking tree search**.
During search, the solver removes incompatible values from the domains of the future (unexplored) variables, via **propagation**. 
![[Pasted image 20240925162827.png]]
:LiArrowBigUp: Example schema :LiArrowBigUp:

The model:
- Captures combinatorial structures
- Enables solver to reduce the search space

Model example on small puzzle :LiPuzzle: :
	![[Pasted image 20240925163653.png]]![[Pasted image 20240925163718.png]]

Good heuristics are important but not always possible, when it's not, we can apply a stronger form of propagation during search.
Stronger propagation can be achieved with better modelling (not that intuitive)

For an efficient CP solving, we need:
- effective propagation algorithms;
- a model with effectively propagating constraints;
- effective search algorithm and heuristics.

### MiniZinc basic excercises

![[Pasted image 20240925173418.png]]
:LiArrowBigUp: Basic syntax, coloring problem :LiArrowBigUp:

Knapsack problem -> Given items, each with a weight and a value, determine which item and how many of it to pack in your knapsack without exceeding its capacity while maximizing your profit?

![[Pasted image 20240925175625.png]]

MinZinc comes with a cheat sheet under the "help" tab that looks really helpful :)

### Modeling in CP
User models a decision problem by formalizing:
- **the unknowns** of the decision → ==decision variables== $(X_i)$.
- **possible values** for unknowns → ==domains== $(D(X_i) = \{v_j\})$.
- **relations** between the unknowns → ==constraints== $(r(X_i, X_i’))$.

> [!note] CSP
Formalizing a ==Constraint Satisfaction Problem== (CSP)
a CSP is a triple $<X,D,C>$
> - ==X== -> set of decision variables $(X_1,...,X_n)$
> - ==D== -> set of domains $\{D_1,...,D_n\}$ for $X$:
> 	- $D_i$ is a set of possible values for $X_i$;
> 	 - usually non-binary and assume finite domain;
>- ==C== -> set of constraints ${C_1,…,C_m}$:
> 	- $C_i$ is a relation over $X_j,...,X_k$, denoted as $C_i(X_j, …, X_k)$;
> 	 - $C_i$ the set of combination of allowed values $C_i \subseteq D(X_j) x ...x D(X_k)$.

A ==solution== to a CSP is an assignment of values to the variables which satisfies (that is feasible for) all **constraints** simultaneously.

CSP enhanced with ==optimization criterion== (eg. minimum cost, shortest distance, etc.)
$<X,D,C,f>$ -> **$f$ is the formalization** of the optimization criterion, to minimize or maximize ( $-f$ )

==Variables & Domains==
- binary, integer, continuous
- take a value from any finite set
- special structured variable types
	- set variables -> set of elements as value
	- activities/internal values (scheduling apps)

==Constraints==
- any kind of constraint can be expressed as **listing of allowed combinations** (**extensional** representation, called ==table== constraints), but it's inconvenient and inefficient with large domains
- declarative relations (eg. $X > Y$) (**Intensional** representation, called ==element== constraints)
	- Order of imposition does not matter
	- Non-directional -> A constraint between X and Y can be used to infer domain information on Y given domain information on X and vice versa
	- Rarely independent

==Modeling tips for excercises==
	apply in order:
	- choose variables
	- enforce constraints
	- check if you can exploit global constraints
	- check for the need of any auxiliary variables
	- check for redundant constraints
	- check for implied constraints
	- check to eliminate any symmetry
	- check for dual viewpoints
	- are there alternative methods that are preferred?

an **implied constraint** is a semantically redundant constraint that give us a computational advantage (because the solver reduces search space) since for us an implicit constraint can be obvious, it's not for the solver

a **symmetry** in CSPs means any equivalent search states -> a state leading to a solution/failure will have many symmetrically equivalent states.
- **Permutation** is a form of symmetry (when re-arranging a set of elements that are all the same solution)
- **Variable symmetry**, intuitively permuting values, depending on the problem we can have combinations or order reversal (Golomb Ruler)
*To understand better, look at the example with Golomb Ruler in the slides*

A common technique is to **impose an ordering** to avoid permutations
==⚠ At least one solution from each set of symmetrically equivalent solutions must remain==

Symmetry breaking constraints enable **constraint simplification** -> they can make some constraints redundant
![[Pasted image 20241003214950.png]]

==Dual Viewpoint==
viewing a problem $P$ from different prospective may result in different models of $P$. Each model has the same set of solutions, but has different variables, domains and constraints and different <u>search space size</u>.

==N-Queen problem case study==
Maximize the number of queens in a board so that they cannot eat each other
![[Pasted image 20241004205551.png]]
Variables
- $[X_1,...,X_n]$ rows -> <u>no row attack</u>
- $\{1,...,n\}$ columns
 $X_i=j$ -> queen in row $i$ is in column $j$
Constraints
- alldifferent($[X_1,...,X_n]$) -> <u>no column attack</u>
-  $\forall \ i<j\quad |X_i-X_j| \ne |i-j|$ -> <u>no diagonal attack</u>
equivalent writings of the non-diagonal atk constraint
$$\forall\  i<j\quad |Xi – Xj| ≠ |i – j|$$
$$≡ \forall\ i<j\quad X_i – X_j ≠ i – j \land X_i – X_j ≠ j – i \land Xj – Xi ≠ i – j \land X_j – X_i ≠ j – i$$
$$≡ \forall\ i<j\quad X_i – i ≠ X_j – j \land X_i + i ≠ X_j + j$$
≡ alldifferent($[X_1 – 1, …, X_n – n]$)
≡ alldifferent($[X_1 + 1, …, X_n + n]$)

We are studying this case because it presents an interesting form of symmetry
![[Pasted image 20241006205116.png]]
we'll define an equivalent model and then <u>combine</u> the two models to create something better than both B)

Variables and Domains
- we represent the board with $n x n$ Boolean variables $B_{ij} ∊ [0..1]$.
Attacking Constraints
- $\sum\limits 𝐵_{ij}= 1$ on all rows and columns, $\sum\limits 𝐵_{𝑖𝑗} ≤ 1$ on all diagonals.
Symmetry Breaking Constraints
- Flatten the 2-d matrix to a single sequence of variables.
	E.g., append every row to the end of the first row.
+ Every symmetric configuration corresponds to a variable permutation of the original solution, which is easy to define.
- Impose an order between the original solution and all the solutions obtained by the 7 permutations:
	$lex≤(B, π(B))\ \forall\ π.$

Lex -> **Lexicographic Ordering Constraint**
Function that requires



### MiniZinc Setup ⚠ IMPORTANT
Setup is quick and easy: all you need to do is modify a few parameters from the configuration editor (the solver)
Set up like this to get the info needed to fill the assignments
![[Pasted image 20241007160142.png]]


> [!Warning] Error: Registry: Constraint fzn_all_different_int not found
if you're on Linux (like me) and this error pops up, instead of spending 2 hours fixing it, here's what you have to do
MiniZinc menu -> Preferences -> Solvers
> 
Create a new solver and save it as such
![[Pasted image 20241007155806.png]]
> 
> make sure it's saved (clicking ok seems to not do it, idk)
>then select it as the solver.
> 
> I had this issue from the AppImage and Snap installation
> 
> [Solution Source](https://github.com/MiniZinc/MiniZincIDE/issues/51)

### Assignment 1 -> NQueens - Puzzle
