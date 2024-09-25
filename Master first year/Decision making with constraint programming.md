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

