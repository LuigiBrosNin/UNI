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
> Formalizing a ==Constraint Satisfaction Problem== (CSP) a CSP is a triple $<X,D,C>$
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
- ❕ we represent the board with $n x n$ Boolean variables $B_{ij} \in [0..1]$.
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
- $[X_1, X_2, …, X_n], [Y_1, Y_2, …, Y_n] \in [1..n]$
Constraints
- alldifferent($[X_1, X_2, …, X_n]$)
- alldifferent($[Y_1, Y_2, …, Y_n]$)
- $\forall i<j\ |X_i - X_j| ≠ |i - j|$
- $\forall i<j\ |Y_i - Y_j| ≠ |i - j|$
Channeling Constraints
- $\forall i,j\ X_i = j Y_j = i$

*we can omit 3/4 constraints*, the first 2 and either of the other 2, which leaves us with only 1 constraints

Variables
- $[X_1, X_2, …, X_n], [Y_1, Y_2, …, Y_n] \in [1..n]$
Constraints
- $\forall i<j\ |X_i - X_j| ≠ |i - j|$
Channeling Constraints
- $\forall i,j\ X_i = j Y_j = i$

## Constraint Propagation
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

## Global Constraints
==Global Constraints== -> captures common <u>complex</u>, <u>non-binary</u> and <u>recurring combinatorial substructures</u>

Embed specialized propagation which exploits the substructure B)

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
			- input array,
			- $N$ -> input array has to contain at least $N$ distinct values
		- eg. Nvalue$([1, 2, 2, 1, 3], 3)$ -> at least 3 distinct values, repetition is allowed ofc
	- **Gcc**
		- Global cardinality constraint -> alldifferent but each number can be repeated how many times we want, and we can decide individually
		- gcc$([X_1, X_2, …, X_k], [v_1, …, v_m], [O_1, …, O_m])$
			- input array
			- $v_1,..,v_m$ -> map of possible numbers
			- $O_1,..,O_m$ -> map of limits for each number with the same index $m$
		- gcc$([1, 1, 3, 2, 3], [1, 2, 3, 4], [2, 1, 2, 0])$ -> 1 can be repeated 2 times, 2 can be repeated 1 time, 3 can be repeated 2 times, 4 can be repeated 0 times
	- **Among**
		- Among constraint, constraints the number of variables taken from a given set of values
		- among$([X_1, X_2, …, X_k], s, N)$
			- input array, 
			- $s$ -> set of possible values, 
			- $N$ -> number of elements that have to be in the array
		- among$([X_1, X_2, …, X_k], s, l,u)$
			- input array,
			- $s$ -> set of possible values,
			- $l$ -> lower bound, 
			- $u$ -> upper bound of number of elements that can be in the array
		- among$([1, 5, 3, 2, 5, 4], \{1,2,3,4\}, 3, 4)$ -> $[1,3,2,4]$ , deletes the values not present in the $s$ set

- ==Sequencing Constraints== -> ensure a sequence of variables obey certain patterns
	- **Sequence/AmongSeq**
		- Constrains the number of values taken from a given set in any subsequence of $q$ variables (given a "condition", the array has to have it respected on every subsequence (eg. at least one number 1 in every 3 numbers)).
		- sequence$(l, u, q, [X_1, …, X_k], s)$
			- $l$ -> lower bound,
			- $u$ -> upper bound of number of elements that can be in the array,
			- $q$ -> subsequence length to respect
			- input array,
			- $s$ -> set of possible values that have to be in
		- sequence$(1,2,3,[1,0,2,0,3],\{0,1\})$ -> every 3 numbers must have a 0 and a 1, for every consequent subsequence, eg:
			$$ [1,2,3,4,5]$$
			:LiArrowBigDown: Subsequences checked for the array above :LiArrowBigUp:
			$$[\{1,2,3\},\{2,3,4\},\{3,4,5\}]$$

- ==Scheduling Constraints== -> Help schedule tasks with respective release times, duration, and deadlines, using limited resources in a time interval
	- **Disjunctive Resource Constraint/noOverlap**
		- Requires that tasks do not overlap in time
		- disjunctive$([S_1, …, S_k],[D_1, …, D_k])$
			- $t_1,..,t_k$ -> tasks
			- $S_1,..,S_k$ -> start time $S_i$ for task $t_i$
			- $D_1,..,D_k$ -> duration $D_i$ for task $t_i$
			![[Pasted image 20241014232753.png]]
		- Useful when a resource can execute at most one task at a time
	- **Cumulative Resource Constraint**
		- Constraints the usage of a shared resource
		- tasks $t_1,...,t_k$ associated with a start time $S_j$, duration $D_i$, resource requirement $R_i$ and a resource with capacity $C$
		- cumulative$([S_1,...,S_{k}],[D_1,...,D_{k}],[R_1,...,R_{k}],C) \Longleftrightarrow \sum\limits_{i|S_{i}\le u <S_{i}+D_{i}}R_{i}\le C \ \forall u \in D$
			- $S$ -> start time
			- $D$ -> Duration
			- $R$ -> Resource requirements
			- $C$ -> Capacity (resources limit)
			![[Pasted image 20241014145958.png]]
			- Useful when a resource with a capacity can execute multiple tasks at a time.

- ==Ordering Constraints== -> Enforce an ordering between the variables or the values
	- **Lexicographic Ordering Constraint**
		- Requires a sequence of variables to be lexicographically less than or equal to another sequence of variables.
		- Lex$\le ([X_1,..,X_k],[Y_1,..,Y_k])$
		![[Pasted image 20241014234555.png]]
		- eg. $A = \{1,2,3\}, B = \{1,2,4\} \to A[1] = B[1] = 1 \to ... \to A[3] < B[3]$  Lex(A,B) -> true
	- **Value Precedence Constraint**
		- Requires a value to precede another value in a sequence of variables
		- value_precede$(v_{j1}, v_{j2}, [X_1, X_2, …, X_k])$
			- $v_{j1}$ -> value to be preceded,
			- $v_{j2}$ -> value to check,
			- input array
		- value_precede$(5, 4, [2, 5, 3, 5, 4])$ -> 4 cannot appear unless there a 5 before it basically

---
==Specialized Propagation for Global Constraints==
approaches to develop specialized propagation for global constraints
- ==constraint decomposition== -> A global constraint is decomposed into smaller and simpler constraints, each of which has a known propagation algorithm.
	- among Decomposition
		- conjunction of disjunctions
		- $B_i$ with $D(B_i) = {0, 1} for 1 ≤ i ≤ k$
		- $C+i: B_i = 1 ↔ X_i ∈ s for 1 ≤ i ≤ k$
		- $Ck+1: \sum\limits_{i} B_i = N$ 
		- $AC(C_i)$ for all $i$ and $BC( \sum\limits_{i} B_i = N  )$ensures GAC on among.
	- Lex Decomposition
		- conjunction of disjunctions
		- $B_i$ with $D(B_i) =\{0,1\}$ for $1\le i \le k+1$ to indicate the vectors have been ordered by position $i-1$
		- $B_1=0$
		- $C_i: (B_i = B_i+1 = 0\ \land \ X_i = Y_i ) \lor (B_i = 0 \land B_i+1 = 1 \land X_i < Y_i ) \lor (B_i = B_i+1 = 1)\ for\ 1 ≤ i ≤ k$
		- GAC$(C_i)\forall i$ ensures GAC on $lex\le$ 
	
	⚠ Decompositions may not always provide an effective propagation
	- alldifferent Decomposition
		- conjunction of difference constraints
		- $C_{ij}: X_{i}\ne X_{j} \ for\ i<j \in \{1,..k\}$ 
		- weaker, since it does not compare all domains, just 2 variables at a time. decomposition does not prune anything
	- sequence decomposition
		- conjunction of among constraints
		- $C_i:$ among$([X_i, X_i+1, …, X_i+q-1], s, l, u)\  for 1 ≤ i ≤ k-q+1$ (weaker)
- ==dedicated ad-hoc algorithm== -> Decomposition may not always provide an efficient propagation (eg. many checks to do)
	- Incremental computation can improve efficiency:
		- propagation algs are called multiple times, we don't want to re compute everything each time
		- cache results at first call
		- exploit cached data on next invoke
	- Dedicated BC Alg for <u>Sum</u>, Operations needed for checking
		C: where $X_i$ and $N$ are integer variables.
		- $min(N) ≥ \sum\limits_{i}min(X_i)$
		- $max(N) ≤ \sum\limits_{i}max(X_i)$
		- $min(X_i) ≥ min(N) - \sum\limits_{i}max(X_i)\ for\ 1 ≤ i ≤ n$
		- $max(X_i) ≤ max(N) - \sum\limits_{i}min(X_i)\ for\ 1 ≤ i ≤ n$
		![[Pasted image 20241016162513.png]]
		:LiArrowBigUp: operations needed for the 1st check
	- Incremental computation in action
		$max(N) ≤ \sum\limits_{i}max(X_i)$
		- cache $max(N)$ as $max\$(N)$
		- whenever the bounds of a variable $X_i$ is pruned:
		- $max(N) ≤ max\$(N) - (old(max(X_i)) - max(X_i))$ -> $O(1)$
		Complexity went to $O(n)\to O(1)$ 🤯

- example
	![[Pasted image 20241016164012.png]]
	**bipartite graph** -> vertices are divided into 2 disjoint sets such that every edge connects a vertex to one to the other set
	**matching** -> subset of edges such that no two edges have a node in common
	![[Pasted image 20241016164327.png|]]
	**Maximal matching** -> largest possible matching

	Algorithm for max matching finding
	- compute all max matching (we asssume we do)
	- no max matching exists -> failure
	- <u>edge free</u> in all maximal matchings (always black) ->
		- remove the edge (remove value from domain in the corresponding variable)
	- <u>vital</u> edge (always red)->
		- keep the edge (assign value to corresponding variable)
	- edge maching in some but not all maximal matchings ->
		- keep the edge
	![[Pasted image 20241016165119.png]]

==Alternating path and cycle==
Technique used to find edges that are in other solutions using logic proprieties. We find out that some edges are part of *a solution* and that's about all we need.
- **Alternating path** -> simple path with edges alternating free and matching
- **Alternating cycle** -> cycle with edges alternating free and matching
- **Even path/cycle** -> path/cycle of even length
( :LiArrowBigUp: this part is confusing at first, look at the slides slowly to understand)

==Global constraints for generic purposes==

**Table (Extensional) Constraint** -> we basically list all possible touples in the domain as a constraint, efficient and effective
$$C(X_1, X_2) = {(0,0), (0,2), (1,3), (2,1)}$$

**==Product configuration problem==** -> compatibility constraints on product components, only certain combination of components work together
for each product $P_i$, we post a **table**($[X_{i1},..,X_{i5}],$ Products)

**==Formal Language-based Constraints==** -> table constraint requires precomputing all solutions
- We can use a deterministic fine-state machine automaton to define the solutions when it's not possible to precompute.
Useful when assignments need to obey certain patterns

==**Rostering Problems**== -> (have pattern within x range, we saw this before)
![[Pasted image 20241016175843.png]]
we can use a DFSA (Deterministic finite state automaton) to describe the constraint


## Search
So far we tried to get a smaller search space trough propagation, but we ignored search

==Backtracking Tree Search (BTS)==
![[Pasted image 20241104142042.png]]
By default, variables are instantiated sequentially and search is Depth-first traversal.
![[Pasted image 20241104142158.png]]

==BTS without Propagation==
enumerates all possible variable-value combinations via **systematic backtracking tree search**
Complexity $O(d^{n})$, exponential
![[Pasted image 20241104142957.png]]
:LiArrowBigUp: simple example about how search iterates, notice the difference with propagation on the domains
![[Pasted image 20241104143515.png]]
![[Pasted image 20241104143525.png]]
![[Pasted image 20241104144140.png]]
(Arc consistent propagation, also checks for feasibility of possibile spaces after FC propagation)

### Depth-first Search (DFS)

==Branching decisions==
Usually consists of posting a unary constraint on a chosen variable $X_i$.

**Enumeration (or labelling)** with single values from $D(X_i)$
![[Pasted image 20241104144651.png]]

**Domain partitioning** of $D(X_i)$
![[Pasted image 20241104145258.png]]
$S$ represents an arbitrary *Subset* of $D(X_i)$

Branching/Search Heuristics
- guide the search (eg deciding how to branch), known also as **Variable and value ordering** (vvo) heuristics
- Static vs dynamic heuristics
	- Static -> each lvl is associated with a variable
	![[Pasted image 20241104150245.png]]
	- Dynamic -> any node, any variable and branch can be considered
	![[Pasted image 20241104150332.png]]

- Problem specific vs generic heuristics

Search Heuristics can go into an *Infeasible sub-problems*, we need to explore the whole sub-tree before backtracking, so we want to do that as fast as possible

**Fail-first (FF) principle** -> try first where you are most likely to fail (we want to probe that a sub tree has no feasible solutions)
How do we know if a CSP is feasible or not?
- Trade-off
	- choose next the variable that is most likely to cause failure
	- choose next the value that is most likely to be part of a solution (least constrained value)
- Variable Ordering Heuristics (VOHs)

==Minimum domain (dom)== 
Generic Dynamic VOHs based on FF
- Choose next the variable with minimum domain size.
- Idea: minimize the search tree size.
![[Pasted image 20241104152727.png]]
![[Pasted image 20241104152811.png]]
![[Pasted image 20241104152837.png]]
![[Pasted image 20241104152852.png]]

==Most constrained (deg)==
- Choose next the variable involved in most number of constraints.
- Idea: maximize constraint propagation.

Why not use both lol
- **Minimize** $\frac {dom}  {deg}$ -> smallest domain and biggest constraints number

Map colouring example on slides, am not reporting it here but helps understand the search tree size with various methods

==Weighted degree heuristic==
Constraints are weightet, starting at 1 and incremented by 1 if the constraint fails.
$$w(X_i)=\sum\limits_{c.s.t\ X_{i}\in X(c)} w(c)$$
Domain over weighted degree heuristic (**domWdeg**) -> 
Choose the variable $X_i$ with minimum $dom(X_i) / w(X_i)$.

⚠ Minizinc heuristics calls the fail-first method "minimum weight" (?)

==Heavy tail behavior==
![[Pasted image 20241104155454.png]]
- Instance + solver parameters combination causes the trap into an exponential subtree
- A mistake early during search we get stuck in trashing
- Such mistakes are seemingly *random*

We can use the power of *Randomization* to our favor (eg. picking randomized parameters in search).
We can *restart* the search after a certain amount of resources are consumed, and in subsequent runs, search differently.
This makes us learn from the accumulated experiences of previous runs 🧠

==Restart strategies==
- **Constant** restart
	Restart after using L resources
- **Geometric** restart
	Restart after L resources, with limit $\alpha*L$ ($\alpha L, \alpha^{2}L,..$)
- **Luby** restart
	Restart after $s[i]L$ following the Luby sequence:
	$$[1,1,2,1,1,2,4,1,1,2,1,1,2,4,8,...]$$
	repeats two copies of the sequence ending in $2^i$ before adding the number $2^{i+1}$

==domWdeg & Restarts==
- it's an heuristic, collects fail counts
- can be really effective

### Best-first Search (BFS)
DFS puts tremendous burden on the heuristics early in the search, and light burden in deep search, so mistakes made near the root are costly

BFS (Best-firsts search) explores first promising nodes according to heuristic evaluation

==Limited Discrepancy Search (LDS)==

**Discrepancy** -> any decision in a search tree that does not follow the heuristic (any right branch out of a node)

LDS ->
- trusts heuristics and gives priority to left branches
- iteratively searches the tree by increasing number of discrepancies ($i$ discrepancies)
![[Pasted image 20241106164805.png]]
LDS potentially corrects *mistakes made near root*

==Depth-bounded Discrepancy Search (DDS)==

Biases search to discrepancies high in the tree via an iteratively increasing depth bound (aka, discrepancies below depth $i$ are forbidden)
![[Pasted image 20241106165422.png]]
solves LDS problems focusing on the top of the tree

### Constraint Optimization Problems (COPs)
-> Enhanced CSP with an optimization criterion (eg. min cost, shortest distance, etc)
$<X,D,C,f>$, where $f$ is the formalization of the optimization criterion as an objective function/variable (minimize $f$, maximize $-f$.

==Solving COPs==
- Enumeration -> 
	- generate all solutions
	- pick the best
	- scales badly with many solutions
- Search over $D(f)$
	- ==Destructive lower bound==
		- iterate $v \in D(f)$, starting from $\min(D(f))$
		- at each iteration, constraint $f\le v$ and solve the CSP
		- first feasible solution is optimal
		- intermediate computation results are discarded (**distructive**)
	- ==Destructive upper bound==
		- iterate $v \in D(f)$, starting from $\max(D(f))$
		- at each iteration, constraint $f\le v$ and solve the CSP
		- problem infeasible, solution from last iteration will be optimal
	- ==Pro & Cons==
		![[Pasted image 20241106172341.png]]
		anytime alg -> can be stopped at anytime and still have a feasible solution on its hands
	- ==Binary search== (combination of upper/lower)
		![[Pasted image 20241106173058.png]]
		
- Branch & bound
	- Solves a sequence of CSPs via a single search tree and incorporates bounding in the search
	- Each time a feasible solution is found, posts a new bounding constraint which ensures that a future solution must be better than it.
	- Backtracks and looks for a new solution with the additional bounding constraint, using the same search tree
	- Repeats until infeasible -> last solution found is optimal
	![[Pasted image 20241106174059.png]]




## Constraint-Based Scheduling

**Scheduling** -> ordering resource-requiring tasks over time

==Resource Constrained Project Scheduling Problem (RCPSP)==
Given:
- a set of **resources** with **fixed capacities**,
- a set of **tasks** with given **duration and resource requirements**,
- a set of **temporal constraints** between tasks,
- and a **performance metric**,
decide:
- when to execute each task so as to optimize the performance metric, subject to temporal and resource constraints.

==Constraint-based model==
- Tasks -> decision variables
	- correspond to operation performed, we need to decide the position in the timeline of the schedule
- Resource constraints -> 
	- unary/disjunctive/sequential resource;
	- cumulative/parallel resource.
- Temporal constraints.
- Performance metric → schedule dependent cost function.

==Decision variables==
- $a_i$ -> Activity
- $S_i$ -> Start Time
	- $EST_i$ -> $\min(S_i)$ earliest start time (release date)
	- $LST_i$ -> $\max(S_i)$ latest start time
- $d_i$ -> Duration
- $E_i$ -> End Time
	- $LET_i$ -> $\max(E_i)$ latest end time (deadline)
	- $EET_i$ -> $\min(E_i)$ earliest end time

**Preemptive activity** -> can be interrupted at any time
we'll focus on non-preemptive activities

**Resources** -> asset available to execute operations (eg. capacity, number of seats in a classroom, num of available workers)

==Cumulative/Parallel Resource==
**Cumulative/Parallel Resource** -> can execute multiple activities in paralel (activities can overlap over time, eg. a multi-core CPU)

![[Pasted image 20241118144610.png]]
- $r_k$ resource associated with capacity $c_k$
- Each task $A_i$ requires $rq_{ik}\ge 0$ of each resource $r_k$ during its execution
- total usage shouldn't exceed $c_k$ 
- $d_i$ is duration
Always related by a **cumulative constraint**
$\forall r_{k}\in R$ with capacity $c_{k}$ -> 
$$\text{cumulative}([S_1,...,S_n],[d_1,...,d_n],[rq_{1k},...,S_{nk}],c_{k}) 
\iff \sum\limits_{i|S_{i}\le u < S_{i}d_{i}}rq_{ik}\le c_{k}\ \forall u \in D $$
RCPSP resources are cumulative

==Unary/Disjunctive/Sequential Resource==
only 1 activity at a time
`noOverlap` constraint among any 2 activities

==Temporal Constraints==
- **Precedence** constraints -> forces one activity to end before another starts
	$a_{i} \to a_{j}|E_{i}\le S_j$
	Activities and precedence constraints form DAG
- **Time-legs** & **Time windows** -> Bounds the difference between the end time and the start time of two activities
- **Sequence-dependent set up times** -> defined for unary resources, if $a$ and $b$ are scheduled in a sequence, then they must obey a separation constraint
	![[Pasted image 20241118153626.png]]

==Cost Function==
**Makespan** -> completion time of the last activity
we want to minimize the Makespan
![[Pasted image 20241118154254.png]]

Total (weighted) ==Tardiness / earliness== costs -> tasks can finish late/early, we calculate it like this (given the end tasks and LET)
$$\sum\limits_{𝑎_{𝑖 \in 𝐴}} 𝑤_𝑖 ∗ \max(0, 𝐸_𝑖 - 𝐿𝐸𝑇_{𝑖}) \sum\limits_{𝑎_{𝑖 \in 𝐴}} 𝑤_𝑖 ∗ \max(0, EST_{𝑖}-E_{i})$$
$\max_{a_{i\in A}}(E_i-LET_{i})$ -> maximum tardiness

Throughput (number of tasks finished in $t$ time) / peak resource utilization / sum of set up times and costs

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

## Assignment 1 Notes -> N-Queens - Sequence Puzzle
Dunno if i should publish everything... or publishing anything at all

⚠ Slide 8 of Class Exercises 1-2 is outdated
[MinZinc 2.7.6](https://docs.minizinc.dev/en/stable/efficient.html#symmetry) is the updated chapter to look at
alternatively, use the `var_sqr_sym(B)`, which does exactly the permutation we need


## Assignment 2 Notes
not adding `::domain_propagation` does not use GAC
adding `::domain_propagation` uses it

BC -> **Bounds Consistency** (BC) They detect inconsistent partial assignments of the form $X_{i}=j$ , so $j$ can be removed from $D(X_i)$ via propagation

GAC -> **Generalized Arc Consistency** (GAC, Hyper-arc or domain consistency) basically defines all possible combinations that satisfy the $any$ constraint

## Assignment 3 Notes
`¯\_(ツ)_/¯`
##