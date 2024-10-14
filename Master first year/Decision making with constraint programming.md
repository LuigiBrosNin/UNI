[Virtuale](https://virtuale.unibo.it/course/view.php?id=60686)

> Notes taken by Luizo ( [@LuigiBrosNin](https://t.me/LuigiBrosNin) on Telegram)

Exam notes
	exercises + oral exam (50/50 weight on the grade)
	5 exercises, 2 deadlines for the first 2 and the remaining 3
	deadlines: nov 1, dec 11
	high grades, if you fail the oral you do not repeat the exercises (at least within the same year, idk about following years)
	exercises uses MiniZinc


# Theory

This course reminds me a lot about Combinatorial Optimization, if you liked that, you'll like this. The prof seems really human and the exams seems chill.

## Intro
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

## Overview of CP
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

## MiniZinc basic syntax

![[Pasted image 20240925173418.png]]
:LiArrowBigUp: Basic syntax, coloring problem :LiArrowBigUp:

Knapsack problem -> Given items, each with a weight and a value, determine which item and how many of it to pack in your knapsack without exceeding its capacity while maximizing your profit?

![[Pasted image 20240925175625.png]]

MinZinc comes with a cheat sheet under the "help" tab that looks really helpful :)

## Modeling in CP
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

- ==Modeling tips for excercises==
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
**Alldifferent model**
Variables
- $[X_1,...,X_n]$ rows -> <u>no row attack</u>
- $\{1,...,n\}$ columns
 $X_i=j$ -> queen in row $i$ is in column $j$
Constraints
- alldifferent($[X_1,...,X_n]$) -> <u>no column attack</u>
-  $\forall \ i<j\quad |X_i-X_j| \ne |i-j|$ -> <u>no diagonal attack</u>
equivalent writings of the non-diagonal atk constraint
$$\forall\  i<j\quad |X_i - Xj| ≠ |i - j|$$
$$≡ \forall\ i<j\quad X_i - X_j ≠ i - j \land X_i - X_j ≠ j - i \land Xj - X_i ≠ i - j \land X_j - X_i ≠ j - i$$
$$≡ \forall\ i<j\quad X_i - i ≠ X_j - j \land X_i + i ≠ X_j + j$$
≡ alldifferent($[X_1 - 1, …, X_n - n]$)
≡ alldifferent($[X_1 + 1, …, X_n + n]$)

We are studying this case because it presents an interesting form of symmetry
![[Pasted image 20241006205116.png]]
we'll define an equivalent model and then <u>combine</u> the two models to create something better than both B)

**Lex model**
Variables and Domains
- ❕ we represent the board with $n x n$ Boolean variables $B_{ij} ∊ [0..1]$.
Attacking Constraints
- $\sum\limits 𝐵_{ij}= 1$ on all rows and columns, $\sum\limits 𝐵_{𝑖𝑗} ≤ 1$ on all diagonals.
Symmetry Breaking Constraints
- Flatten the 2-d matrix to a single sequence of variables.
	E.g., append every row to the end of the first row.
+ Every symmetric configuration corresponds to a variable permutation of the original solution, which is easy to define.
- Impose an order between the original solution and all the solutions obtained by the 7 permutations:
	$lex≤(B, π(B))\ \forall\ π.$ (pi being the permutations)

==Lex== -> **Lexicographic Ordering Constraint**
Function that requires a sequence of variables to be lexicographically less or equal to another sequence
eg. $A = \{1,2,3\}, B = \{1,2,4\} \to A[1] = B[1] = 1 \to ... \to A[3] < B[3]$ , so we say $A$ is **lexicographically smaller** than $B$.
![[Pasted image 20241007212145.png]]
we use the lex function to break symmetry in N-Queens
now we combine the *alldifferent* model and the *lex* model, to get the best of both words (since both have some drawbacks and strong points)

**Combined model**
Variables
$$\forall i,\ X_{i}\in [1..n],\forall i,j\ B_{ij}\in [0..1]$$
Constraints
- alldifferent($[X_1, X_2, …, X_n]$) 
- alldifferent($[X_1 + 1, X_2 + 2, …, X_n + n]$)
- alldifferent($[X_1 - 1, X_2 - 2, …, X_n - n]$)
- $lex≤(B , π(B))\ \forall π$
Channeling constraints
$\forall i,j\ X_{i} = j\leftrightarrow B_{ij} = 1$

another dual model we can study is the original one... and a "flipped" variant
![[Pasted image 20241007215201.png]]![[Pasted image 20241007215208.png]]
the difference is visual and self explanatory

we can get a *combined model*

Variables
- $[X_1, X_2, …, X_n], [Y_1, Y_2, …, Y_n] ∊ [1..n]$
Constraints
- alldifferent($[X_1, X_2, …, X_n]$)
- alldifferent($[Y_1, Y_2, …, Y_n]$)
- $\forall i<j\ |X_i - X_j| ≠ |i - j|$
- $\forall i<j\ |Y_i - Y_j| ≠ |i - j|$
Channeling Constraints
- $\forall i,j\ X_i = j Y_j = i$

*we can omit 3/4 constraints*, the first 2 and either of the other 2, which leaves us with only 1 constraints

Variables
- $[X_1, X_2, …, X_n], [Y_1, Y_2, …, Y_n] ∊ [1..n]$
Constraints
- $\forall i<j\ |X_i - X_j| ≠ |i - j|$
Channeling Constraints
- $\forall i,j\ X_i = j Y_j = i$

## Constraint Propagation & Global Constraints
- Search decisions and propagation are interleaved, example:
	![[Pasted image 20241009162811.png]]
	![[Pasted image 20241009162910.png]]
	![[Pasted image 20241009163021.png]]

==Local Consistency==
-> a form of inference which <u>detects inconsistent partial assignments</u>, local because we examine individual constraints

Popular local consistencies are domain-based
- **Generalized Arc Consistency** (GAC, Hyper-arc or domain consistency)
- **Bounds Consistency** (BC)
	They detect inconsistent partial assignments of the form $X_{i}=j$ , so $j$ can be removed from $D(X_i)$ via propagation

==GAC==
A constraint $C$ defined on $k$ variables $C(X_1,…, X_k)$ gives the set of allowed combinations of values (i.e. allowed tuples).
- $C \subseteq D(X_1) x … x D(X_k)$
- E.g., $D(X_1) = \{0,1\},\ D(X_2) = \{1,2\},\ D(X_3) = \{2,3\}\ C_1: X_1 + X_2 = X_3$
$$C(X_1,X_2,X_3) = \{(0,2,2), (1,1,2), (1,2,3)\}$$
:LiArrowBigUp: This constraint basically defines all possible combinations that satisfy the $C_1$ constraint

- Each allowed tuple $(d_1,…,d_k) ∈ C$ where $d_i ∈ X_i$ is a **support** for $C$
- **C is GAC** $\iff \forall X_{i} \in \{X_1,...X_k\},\forall v\in D(X_{i})$ , $v$ belongs to a support for C 
- **CSP is GAC** $\iff$ all C are GAC

==BC==
- ❌ BC might not detect all GAC inconsistencies
- ✅ Easier to look for a support in a range than in a domain
- ✅ Achieving BC is often cheaper than GAC
- ✅ Achieving BC is enough to achieve GAC for monotonic constraints

- Examples
	- GAC = BC
		![[Pasted image 20241009165722.png]]
	- GAC > BC
		![[Pasted image 20241009165822.png]]
		![[Pasted image 20241009170000.png]]

==Constraint Propagation==
**Propagation algorithm** -> achieves a certain level of consistency on a constraint C by removing the inconsistent values from the domains of the variables in C.
Level of consistency depends on C

- **constraint propagation** process ->
	When there are multiple constraints:
	- propagation algorithms interact;
	- a propagation algorithm can wake up an already propagated constraint to be propagated again
	- in the end, propagation reaches a fixed-point and all constraints reach a level of consistency
- Example
	![[Pasted image 20241009172641.png]]

Properties of Propagation Algorithms
- may not be enough to remove inconsistent values from domains once
- the algorithm must wake up again when necessary

Complexity of propagation algorithms
- Assume $|D(X_i)|=d$
- local consistency property -> $C(X_1,X_2)$ takes $O(d^2)$ time
- (we can do better)
- Examples
	- C: $X_1 = X_2$
		- $D(X_1) = D(X_2) = D(X_1) ∩ D(X_2)$
		- Complexity: the cost of the set intersection operation
	- C: $X1 ≠ X2$
		- When $D(X_i) = \{v\}$, remove v from $D(X_j)$.
		- Complexity: $O(1)$
	- C: $X_1 ≤ X_2$
		- $max(X_1) ≤ max(X_2), min(X_1) ≤ min(X_2)$
		- Complexity: $O(1)$

==Specialized Propagation==
-> Propagation specific to a given constraint
- ✅ exploits the constraint semantics
- ✅ potentially much more efficient than a general propagation approach
- ❌ Limited use
- ❌ Not always easy to develop one, worth for recurring constraints tho.

- Example
	![[Pasted image 20241009174147.png]]

==Global Constraints==
-> captures common <u>complex</u>, <u>non-binary</u> and <u>recurring combinatorial substructures</u>
embed specialized propagation which exploits the substructure B)

Basically common and known constraints have been cataloged to already have specialized propagation for our needs B)))

Modelling benefits
- Reduce the gap between the problem statement and the model.
- Expression of constraints that are otherwise not possible to state using primitive constraints (<u>semantic</u>).
Solving benefits
- Strong inference in propagation (<u>operational</u>).
- Efficient propagation (<u>algorithmic</u>).

> It's a beautiful thing, the destruction of words
> *G. Orwell, in 1984*

> [!note] ==Groups of global constraints==
>- **Counting**
>- **Sequencing**
>- **Scheduling**
>- **Ordering**
>- Balancing
>- Distance
>- Packing
>- Graph-based
>- etc.

- ==Counting== -> restrict the number of variables satisfying a condition or the number of times values are taken
	- **alldifferent**
		- alldifferent$([X_1,...,X_k])\Longleftrightarrow X_{i}\ne X_{j}\ \forall i<j \in \{1,..,k\}$ 
	- **Nvalue**
		- Means <u>at least</u> all different up to the $N$th value
		- Nvalue$([X_1,...,X_k],N)\Longleftrightarrow N = |\{X_{j} |1\le i \le k\}|$ 
		- eg. Nvalue$([1, 2, 2, 1, 3], 3)$ -> at least 3 distinct values, repetition is allowed ofc
	- **gcc**
		- Global cardinality constraint -> alldifferent but each number can be repeated how many times we want, and we can decide individually
		- gcc$([X_1, X_2, …, X_k], [v_1, …, v_m], [O_1, …, O_m])$
		- input array, map of possible numbers, map of limits for each number with the same index $m$
		- gcc$([1, 1, 3, 2, 3], [1, 2, 3, 4], [2, 1, 2, 0])$ -> 1 can be repeated 2 times, 2 can be repeated 1 time, 3 can be repeated 2 times, 4 can be repeated 0 times
	- **among**
		- Among constraint, constraints the number of variables taken from a given set of values
		- among$([X_1, X_2, …, X_k], s, N)$
		- input array, set of possible values, number of elements that have to be in the array
		- among$([X_1, X_2, …, X_k], s, l,u)$
		- input array, set of possible values, lower bound, upper bound of number of elements that can be in the array
		- among$([1, 5, 3, 2, 5, 4], \{1,2,3,4\}, 3, 4)$ -> $[1,3,2,4]$ would be accepted

- ==Sequencing Constraints== -> ensure a sequence of variables obey certain patterns
	- **Sequence/AmongSeq**
		- Constrains the number of values taken from a given set in any subsequence of $q$ variables (given a condition, the array has to have it respected on every subsequence (eg. number 1 on every 2 numbers)).
		- 

- ==Scheduling Constraints== -> Help schedule tasks with respective release times, duration, and deadlines, using limited resources in a time interval
	- **Disjunctive Resource Constraint/noOverlap**
		- requires that tasks do not overlap in time
		- 
	- **Cumulative Resource Constraint**
		- Constraints the usage of a shared resource
			- tasks $t_1,...,t_k$ associated with a start time $S_j$, duration $D_i$, resource requirement $R_i$ and a resource with capacity $C$
			- cumulative$([S_1,...,S_{k}],[D_1,...,D_{k}],[R_1,...,R_{k}],C) \Longleftrightarrow \sum\limits_{i|S_{i}\le u <S_{i}+D_{i}}R_{i}\le C \ \forall u \in D$
			- 
			![[Pasted image 20241014145958.png]]

- ==Ordering Constraints== -> Enforce an ordering between the variables or the values
	- **Lexicographic Ordering Constraint**
		- Requires a sequence of variables to be lexicographically less than or equal to another sequence of variables.
		- 
	- **Value Precedence Constraint**
		- Requires a value to precede another value in a sequence of variables
		- 

==Specialized Propagation for Global Constraints==
approaches to develop specialized propagation for global constraints
- ==constraint decomposition== -> A global constraint is decomposed into smaller and simpler constraints, each of which has a known propagation algorithm.
	- among Decomposition
	- Lex Decomposition
		- conjunction of disjunctions
		- $B_i$ with $D(B_i) =\{0,1\}$ for $1\le i \le k+1$ to indicate the vectors have been ordered by position $i-1$
		- $B_1=0$
		- $C_i: (B_i = B_i+1 = 0\ \land \ X_i = Y_i ) \lor (B_i = 0 \land B_i+1 = 1 \land X_i < Y_i ) \lor (B_i = B_i+1 = 1)\ for\ 1 ≤ i ≤ k$
		- GAC$(C_i)\forall i$ ensures GAC on $lex\le$ 
	May not always provide an effective propagation
	- alldifferent Decomposition
		- conjunction of difference constraints
		- $C_{ij}: X_{i}\ne X_{j} \ for\ i<j \in \{1,..k\}$ (weaker, since it does not compare all domains, just 2 variables at a time)
	- sequence decomposition
		- conjunction of among constraints
		- $C_i:$ among$([X_i, X_i+1, …, X_i+q-1], s, l, u)\  for 1 ≤ i ≤ k-q+1$ (weaker)
- ==dedicated ad-hoc algorithm== -> 


## 


##
---
# Exercises
## MiniZinc Setup ⚠ IMPORTANT
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

## Assignment 1 -> N-Queens - Sequence Puzzle
Dunno if i should publish everything... or publishing anything at all

⚠ Slide 8 of Class Exercises 1-2 is outdated
[MinZinc 2.7.6](https://docs.minizinc.dev/en/stable/efficient.html#symmetry) is the updated chapter to look at
alternatively, use the `var_sqr_sym(B)`, which does exactly the permutation we need


##