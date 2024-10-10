[Slides, Prof's site](https://www.cs.unibo.it/~babaoglu/courses/csns/calendar/index.html)

> Notes taken by Luizo ( [@LuigiBrosNin](https://t.me/LuigiBrosNin) on Telegram)

# Theory

## Intro

Weaver's 3 classes of problems:
- Problems of simplicity -> few variables with well known relations (eg. $F=ma$)
- Problems of *==disorganized==* complexity -> 
	- billions+ of variables
	- random "disorganized" variables with little relations
	- allows statistical methods for describing behaviors trough averages
	- eg. temperature and pressure of air molecules that results in winds
- Problems of *==organized==* complexity ->
	- middle ground in the number of variables
	- strong, nonlinear interactions
	- "The whole is **more** than the sum of its parts"

Examples of complex systems
	-  Social insects
		![[Pasted image 20240923183210.png]] ![[Pasted image 20240923183239.png]]
	-  The human brain
	- The mammalian immune system
	- Economies, financial markets
	- Cities, traffic
	- Data centers
	- The Internet
	- Peer-to-peer systems
	- The World Wide Web

Interactions among agents is central to complex systems
Networks allows us to monitor these interactions and thus are important in the study of complex systems.

Common proprieties of complex systems
- **Simple components** -> agents, actors
- **Decentralized control** -> no distinguished “master”
- **Nonlinear interactions** -> components act autonomously but interact with other components directly or indirectly
- **Emergent behavior** -> the global system exhibits properties that cannot be derived or predicted from understanding behaviors of individual components
	-  **Hierarchical structure** -> proteins to nucleic acids to cells to tissues to organs to organisms to colonies to ecosystems
	-  **Self organization** -> people into economies, birds into flocks, ants into bridges, social networks into communities
	-  **Adaptation** -> agents react to changes in their environment in an effort to maintain favorable outcomes, resulting in learning and evolution
	-  **Information processing** -> while individual agents remain ignorant, the system as a whole is able to process information and even compute

Linear systems obey the superposition principle:
$$F(a_1x_1+...)=a_1F(x_{1})+...$$
Superposition principle is the basis for ==reductionism==: a system can be
understood by studying its individual parts

Measures of complexity, 3 different aspects
- **Descriptive** -> measured in bits
- **Operational** -> measured in time, space, money, energy
- **Organizational** -> difficulty in describing structure, amount of information

==Entropy== allows us to formalize the notions of “orderly” (or “regular”) and
“disorderly” (or “random”).

Complex systems key concepts
- **Dynamics** -> how behaviors and structures change over time
- **Information** -> how data is represented and communicated
- **Computation** -> how information is processed
- **Evolution** -> how systems adapt to changes in the environment

The method of complex system is the scientific one

## Dynamical Systems and Non-Linear Dynamics

- ==Dynamics== ->Study of how systems change over time, eg:
	- Planetary dynamics — motion of planets and other celestial bodies
	- Fluid dynamics — motion of fluids, turbulence, air flow
	- Crowd dynamics — behavior of groups of people, stampedes
	- Population dynamics — how populations vary over time
	- Climate dynamics — variations in temperature, pressure, hurricanes
	- Financial dynamics — variations in stock prices, exchange rates
	- Social dynamics — conflicts, cooperation

==Dynamical systems theory== is a branch of mathematics for studying how systems change over time.
It gives us a vocabulary and a set of tools for describing dynamics.

#### Dynamics of iteration (example)
- Dynamics result from some process repeating itself over and over, such as the
population of some species
- Consider an extremely simple model for population growth
- At each time step, every member of the population gives birth to some constant
number of new members
- Parameters
	- Initial population size
	- Birth rate

- Define the system state as the current population size
- State variables denote the system state and change with time
- Let $n_t$ denote the size of the population at time $t$
- Consider discrete time model with t assuming the values of natural numbers
- Initial population is $n_0$
- Let $R$ denote the birth rate -> number of offsprings produced by a member at each time step
- In other words, $n_1=Rn_0$ and $n_2=R_n1$, …
- In general, $n_{t+1}1=Rn_t$

 Assume initial population $n_0 = 1$ and birth rate $R = 2$
 ![[Pasted image 20240925000627.png]] 
 $n_t = R^t$
![[Pasted image 20240925000733.png]]
- System is **exponential** in the time series
- System is **linear** in the state space
- Linearity is due to the fact that there are no interactions among the population members -> each member acts in isolation
- ==The whole is indeed the sum of its parts==

#### Linear vs NonLinear
linearity leads to unbounded population growth (positive feedback)

We introduce nonlinearity by adding negative feedback resulting from interactions
among members (some die for $xyz$ reasons).
The new model becomes $n_{t+1} = R(n_t−d)$ where $d$ is the death rate
Assume $d = \frac {n_t^2}k$ where $k$ is the maximum “carrying capacity”
$$
\frac {n_{t+1}}k = R(\frac {n_{t}}k − \frac {n_t^{2}}{k^{2}}) \qquad 
x_{t+1} = R(x_t−x_t^2)
$$
the equation is no longer linear and Consists of a “**positive feedback**” term ($Rx_t$) and a “**negative feedback**” term ($−Rx_t^2$)

Resulting equation is known as the “==Logistic Map==”.
#### Logistic map graphs to make u understand
![[Pasted image 20240926134348.png]]

Note that $x_t$ denotes the “**normalized**” population thus $0 ≤ x_t ≤ 1$

![[Pasted image 20240926134440.png]]
Imagine the values as the next generation $t+1$ in a simulation, to study its behavior

![[Pasted image 20240926134540.png]]
Increasing R makes the slope higher
![[Pasted image 20240926134725.png]]
![[Pasted image 20240926134814.png]]
Fixed point dynamics :LiArrowBigUp:

![[Pasted image 20240926135120.png]]
Periodic points dynamics :LiArrowBigUp:

![[Pasted image 20240926135244.png]]
Period doubling :LiArrowBigUp:

![[Pasted image 20240926135457.png]]
Oneset of chaos -> infinite-period limit cycle :LiArrowBigUp:

![[Pasted image 20240926135929.png]]
In order of colour, left -> right
Fixed point -> Periodic dynamics with 2 points -> Periodic dynamics with 4 points -> periodic dynamics with 8 points -> chaos

Bifurcation occur at shorter and shorter ranges, at a constant rate called ==Feigenbaum's constant== -> $4.6692016...$
(pronunced with italian spelling "Faigunbaum")
![[Pasted image 20240926140441.png]]
Feigenbaum proved that the result applies to any dynamical system that is
characterized through a “one-humped” map

#### Chaos vs Randomness, Diversion, Tent map
>even if we have a simple model in which all the parameters are determined exactly, long-term prediction is nevertheless impossible

-> this is because of stuff like arbitrarily close initial conditions, that can vary the result drastically

**Chaos** is characterized not so much by randomness but by extreme sensitivity to
initial conditions.

in logistic maps, we define "==diverge significantly==" as a Yes/No function
$$
x_{t}\le 0.5 \implies No \qquad x_{t}> 0.5 \implies Yes
$$
![[Pasted image 20240926142346.png]]
in $f^1$, the 1 doesn't mean the power of the function, it's just notation.
![[Pasted image 20240926143654.png]]

$f^m$ will have $2^{m−1}$ humps
$f^m$ will have $2\times 2 ^{m-1} +1 = 2^{m}+1$
To predict $f^m$ we need to distinguish which of the $2^m+1$ regions the initial value falls into
This requires that the initial value be encoded with at least ==$m+1$ bits of accuracy==
Fewer bits -> the prediction can be no better than a random guess
for example, 0.987654321 requires roughly 9×3=27 bits to encode (because 3 bits can represent 7 out of 10 numbers, approximated)

- ==Chaos system proprieties==
	- **Deterministic** -> given its history, the future of a chaotic system is not random but completely determined
	 - **Sensitive** -> chaotic systems are extremely sensitive to initial conditions (butterfly effect)
	- **Ergodic** -> the state space trajectory of a chaotic system will always return to the local region of previous point on the trajectory
	==These properties are necessary but not sufficient==
	**Ergodic property** implies that a continuous time system with fewer than 3 state
	variables cannot be chaotic (the Logistic map is one-dimensional and chaotic
	but it is a discrete time system)
	![[Pasted image 20240926153355.png]]
	For contradiction, suppose that a continuous time system with only 2 state
	variables is chaotic
	-  State space (of 2 variables) can be seen as a plane
	- Ergodicity requires that each point in this plane be reached, with no point ever being revisited
	- Equivalent to covering the entire plane with ink without ever crossing a line or lifting the pen -> impossible
	- To not cross an existing line, must jump over it -> 3rd dimension

Chaos showed that it is possible to create a behavior that is effectively random through a deterministic process.

==Tent map== -> a function we can study for predicting the behavior of Logistic maps based on input numbers
![[Pasted image 20240926150044.png]]
Logistic map an Tent map are *equivalent* ->  Need to find a transformation function $g(x)$ and its inverse $g{−1}(x)$ such that
$$L(x)=g{−1}(T(g(x)))\ and\ T(x)=g(L(g{−1}(x)))$$
in simple words, find the inverse of a function so that we can map both $L$ and $T$
while we do not demonstrate the equivalency, we'll study the behavior 

![[Pasted image 20240926150702.png]]
:LiArrowBigUp: tent map behavior
- $b_1$ must be 0 because any binary number will be $\ge 1/2$ if $b_1$ is 1 compared to the maximum value it can have ( 100 -> 4, 111 -> 7 for example)
- to compute $2x$, since we double everything and we're in a binary system, the 1 bit shift is a $\times 2$ operation, just like in decimal shifting a number is a $\times 10$ operation.

![[Pasted image 20240926150933.png]]
:LiArrowBigUp: tent map behavior part 2
one iteration always "consumes" 1 bit, and knowing this we can study the long term behavior of different numbers through cases:
1. finite rational number ( 0.1000100001 ) -> logistic map at **fixed point**
2. infinite rational number ( 0.101110111011... ) -> logistic map at **periodic**
3. irrational number ( 0.0101000011011... ) -> logistic map **chaotic**

> [!Note] Fun fact
> The Logistic Map at chaos can be turned into a “random bit generator"
$$ x_{i}\le 0.5 \implies 0 \qquad x_{i}> 0.5 \implies 1$$

## Models and Cellular automata
Models are abstractions of reality that serve two purposes
- Explain past behaviors
- Predict future/unobservable behaviors
Anything can be modeled, and they're the basis for understanding and turn data into knowledge.
A model has to be *compact and simple* while maintaining *fidelity*

==Cellular automata== -> abstract model for simple individual behaviors and simple interactions leading to complex aggregate behaviors

#### 1-Dimensional Cellular Automata
![[Pasted image 20240930183651.png]]
An infinite array of cells, each having a value from a $k$-ary state
Each cell has a position $i$ and has $r$ left and right neighbors

The state of a cell at time $t+1$ is a function of cell's state and its neighbors' state at time $t$

- Example
	assume $k = 2, r = 1$ (binary state and neighborhood size 2 ($2r$))
	![[Pasted image 20240930184808.png]]
	![[Pasted image 20240930184927.png]]
	there are $2^{3^{3}}= 256$ possible CAs (Wolfram canonical enumeration)
	reading the final state column of the lookout table as a binary number gives each possible CA identified trough an integer 0-255
	![[Pasted image 20240930185342.png]]

- Wolfram's classification (Classes 1->4):
	1. Nearly all initial patterns evolve quickly into a stable, homogeneous state (**fixed point**)
	   ![[Pasted image 20240930185736.png]]
	2. Nearly all initial patterns evolve quickly into stable or oscillating structures (**periodic**)
	   ![[Pasted image 20240930185753.png]]
	3. Nearly all initial patterns evolve in a pseudo-random or chaotic manner (**chaotic**)
	   ![[Pasted image 20240930185805.png]]
	4. Nearly all initial patterns evolve into structures that interact in complex and interesting ways (**complex** — capable of universal computation)![[Pasted image 20240930185822.png]]

#### CAs as dynamical systems
- CAs are discrete-time (non continuous), deterministic dynamical systems that exhibit fixed-point, periodic and chaotic behavior.
- Similar to logistic maps (except continuity)
- control parameter $R$ equivalent -> $\lambda$ ==Landon's metric==

Langdon's $\lambda$ metric seeks a compact characterization of the CA behavior class
this number corresponds to the number of "ones" in the look up table final state column
![[Pasted image 20240930190617.png]]![[Pasted image 20240930190654.png]]
![[Pasted image 20240930190733.png]]
:LiArrowBigUp: Wolfram's classifiation and normalized Langdon's $\lambda$ metric

#### Conway's "Game of Life"
- 2-Dimensional Cellular Automata
- Developed by British mathematician John Conway

![[Pasted image 20240930191037.png]]
- Each cell (on an infinite plane) has eight neighbors
- Each cell can be “alive” or “dead”
- Cells come alive, die or survive according to simple rules

- Rules:
	- a live cell with 2 or 3 live neighbors survives (survival)
	- a live cell with fewer than 2 live neighbors dies (death from loneliness)
	- a live cell with more than 3 live neighbors dies (death from over crowding)
	- a dead cell with exactly 3 live neighbors come alive (birth)
Example Glider $t=0$ -> $t=4$
![[Pasted image 20240930191226.png]]

#### CAs as computers
- CAs can perform "computation" (as "processing of information", aka storing, representing and inputing, transferring, transforming, oputputting info)
- "Universal computation" -> ability to compute anything that is computable
- "Programmable computers" are capable of universal computation

Conway's game of life and CA rule 110 **are capable of universal computation** (equivalent to a Turing Machine, basic logical operators can be constructed using them)

CAs as “universal computers” are not practical
Yet, CAs have been used to perform special-purpose, practical parallel
computations such as image processing


## Agent-Based Models

Agent-based models allow us to consider richer environments with greater fidelity than equation-based models and explore a larger set of questions
Characteristics:
- **Individuals (agents)** -> objects of the model
- **Behaviors** -> simple or rational rules that guide agents (motives)
- **Outcomes** -> results of the behavior
- *Micro-motives* vs *Macro-outcomes*
Macro outcomes can be observed as proprieties of the environment or as proprieties of the individuals

- ==Langton's Ants==
	We have:
	- 2-Dimensional “grid”
	- Each square can be “black” or “white”
	- Ants have a direction and can turn right or left, move one square in the current direction, flip color of square they are on
	- Rules:
	- If current square “white”, turn 90° right, flip the color of square, move forward one unit
	- If current square “black”, turn 90° left, flip the color of square, move forward one unit
	- Think of “black” and “white” as the presence or absence of “pheromones” deposited by ants to their environment
	![[Pasted image 20241003143631.png]]
	![[Pasted image 20241003143755.png]]
	The system is not linear, and thus the sum of the ant's paths is not the sum of the individual behaviors

- ==Foraging ants==
	In nature, ants are known to “forage” (scout ants go looking for food far away from their nest while leaving pheromone trails for other ants to follow)
	Real ant pheromone trails diffuse and evaporate
	
	The existence and strength of pheromone trails encode the ant colony’s collective information about food in their environment
	![[Pasted image 20241003144023.png]]
	:LiArrowBigUp: ants movement

- ==Termites==
	Wood “chips” distributed over a 2-Dimensional space
	Termites can move, pick up or drop wood chips
	- Rules:
		- Wander randomly
		- If bump into a wood chip and “free”, pick the chip up, and continue to wander randomly
		- If bump into a wood chip and “full”, find a nearby empty space and put the wood chip down, continue to wander randomly
	$x$ termites -> Chips will get collected in a single location as a result of the rules, they'll conform in bigger chunks in $x$ speed

==Sorting and peer effects==
**Sorting (Homophily)** -> individuals seek similar individuals (eg. in society, friend groups)
**Schelling's Segregation module** -> creating of segregated areas (eg. neighborhood)
**Peer effects** -> individuals adopt the behavior of their peers
**Self organization** -> macro outcomes are a result of this propriety of individuals (eg. flocking and schooling)

- Flock rules example
	![[Pasted image 20241003134352.png]]

==Gossip-style interactions==
effective for constructing decentralized solutions to problems in large networks, since interactions are limited to *peers*
System is fully symmetric
Gossip can be
- Timing -> Reactive, Proactive (independently)
- Direction ->Push, pull, push-pull (subject asks for or is told gossip)
A set of peers that a node knows is called a **view** and they define **overlay networks**

- Network example
	![[Pasted image 20241003140417.png]]
	to define a framework we need to define
	- How peers are selected through method `SelectPeer()`
	- Style of interaction (push, pull etc)
	- How local state is updated trough `Update()`

==Heartbeat synchronization==
Synchrony in nature of independent agents is common
- Chirping crickets
- Flashing of fireflies
- Menstrual cycles of women living together
- Heart pacemaker cells

Agents belong to the same organism or are parts of different organisms

<u>Coupled oscillators</u>  is a form of self-synchronization
they need to be coupled trough something in the environment, otherwise independent agents will never synchronize

Minor adjustments locally lead to global synchrony that emerges in a decentralized matter

- ==Firefly Gossip framework instantiation==
	Certain species of (male) fireflies (e.g., luciola pupilla) are known to synchronize their flashes despite
	- Sparse connectivity network (each firefly has a small number of “neighbors”)
	- Communication not instantaneous
	- Independent local “oscillators” with random initial periods
	
	- Style of interaction: push
	- Local state `S`: Current phase of local oscillator $ϕ$, period $Δ$
	- Method `SelectPeer()`: (small) set of random neighbors
	- Method `Update()`: Function to reset the local oscillator based on the phase of arriving flash
	![[Pasted image 20241003144556.png]]
	:LiArrowBigUp: sync algorithm
	![[Pasted image 20241003144732.png]]
	:LiArrowBigUp: Convergence of periods
	![[Pasted image 20241003144815.png]]
	:LiArrowBigUp: Chaos to coherent emissions (they're accurate with a margin of error)

==Formation creation==
Is a Dynamic collection of agents that can move in physical space in any direction
- Each agent has a unique ID and can determine the relative position of other agents
- Agents are interconnected through a sparse network that can be used to provide random samples from the entire population
- Devise a protocol such that mobile agents self organize into pre-specified global formations in a totally decentralized manner

Examples -> Drones flying in formation, Satellites in orbit

- ==Formation creation Gossip framework instantiation==
	- Style of interaction: pull
	- Local state $S$: Current physical position and motion vector
	- Method `SelectPeer()`: $k$ random samples from population
	- Method `Update()`: Compute motion vector based on positions of most and least preferred neighbor (defined in a manner similar to the ranking function of overlay topology creation inspired by differential cell adhesion)
	![[Pasted image 20241003150851.png]]
	:LiArrowBigUp: starting formation of Ring formation
	![[Pasted image 20241003150921.png]]
	:LiArrowBigUp: ending formation of Ring formation

## Game theory / Cooperation and Competition

- Agents need to choose among several options
- The outcome of agent decisions (actions) depends on the choices made by other agents they are interacting with
	- pricing a new product in a competitive market
	- biding in an auction
	- choosing a route in a data network
	- choosing a stance in international relations
	- deciding to resort to doping or not
- Want to study notions like “**cooperation**” in a world where agents are in perpetual competition
==Game ingredients==
- Players -> set of participants
- Strategies -> set of options for behavior
- Payoff -> results for each choice of strategies
- Payoff matrix -> summarized payoffs
	![[Pasted image 20241009113516.png]]
	studying for project or exam

**Rational players** -> maximize their own payoff given her beliefs about the strategies used by other players
**Strictly Dominant Strategy** -> strategy that is the best choice regardless what the other player does
![[Pasted image 20241009113908.png]]
Generic two-player dilemma game
- **R** -> **reward** for mutual cooperation
- **S** -> **sucker’s payoff**
- **T** -> **temptation** to defect 
- **P** -> **punishment** for mutual defection
**Dilemma** -> Each player wants the other to cooperate but both are tempted to defect

- ==Prisoner's dilemma example==
	- Two robbery suspects apprehended by police, being interrogated in separate rooms
	- There isn't enough evidence to convict either one, but each can be charged with a lesser crime (resisting arrest)
	- Each suspect needs to decide unilaterally (no talking, collusion) whether to “Confess” (C) or “Deny” (D)
	![[Pasted image 20241009140444.png]]
	- Confession leads to higher individual payoff — selfishness
	- Denial leads to higher global payoff — cooperation
	
	“Dilemma” because both prisoners would have been better off if both had chosen “Deny”
	Captures the conflict between individual rationality (selfishness) and common good (cooperation)

expect players to use strategies that are best responses to each other, no player will have an incentive to deviate to an alternative strategy
:LiArrowBigDown:
**Nash equilibrium** -> Pair of strategies $(S,T ), S$ for Player 1 and $T$ for Player 2, is a **Nash equilibrium** if $S$ is a best response to $T$ and $T$ is a best response to $S$

==Coordination games==
![[Pasted image 20241009141900.png]]
Players have an incentive to adopt the same behavior (eg. units of measure, metric vs imperial 💩)
**Balanced game** -> equal payoffs $a=b$
**Unbalanced game** -> $a \ne b$
**Multiple equilibria** ->
	![[Pasted image 20241009142548.png]]

==Mixed strategy games==
No Nash equilibria when restricted to pure strategy (eg. randomness)
- Strategy becomes choosing a probability with which to play H
- Strategy $p$ for Player 1: play H with probability $p$, play T with probability $(1−p)$
- Strategy $q$ for Player 2: play H with probability $q$, play T with probability $(1−q)$
Payoffs for these mixed strategy games become random quantities
- Suppose Player 1 chooses pure strategy H while Player 2 chooses probability $q$ for playing H
- Expected payoff to Player 1 is $(−1)q+(1)(1−q)=1−2q$
- Suppose Player 1 chooses pure strategy T while Player 2 chooses probability $q$ for playing H
- Expected payoff to Player 1 is $(1)q+(−1)(1−q)=2q−1$

==Equilibrium with mixed strategies==
**Nash equilibrium** for a mixed strategy game -> pair of strategies (now probabilities) such that each is a best response to the other
Pure strategies cannot be part of any nash equilibrium, same with probabilities that make expectations unequal
Thus we must have $1−2q = 2q−1,$ or $q = 1/2$ for the game to be in a nash equilibrium

==Penality kick game==
Goalie and Kicker player, they have to decide whenever to Dive/Kick respectively Left/Right
![[Pasted image 20241009145700.png]]
This game is asymmetric
To make the kicker **indifferent**, the goalie must pick $p$ such that <u>payoff from kicking left = payoff from kicking right</u>
$$(0.58)( p) + (0.95)(1−p) = (0.93)( p) + (0.7)(1−p)$$
resulting in $p=0.417$



## Adaptation, Evolution, Genetic algorithms
Concept
```
Repeat
	Generate a random feasible solution
	Test the solution to evaluate its "goodness"
Until (solution is good enough
```
usable if
- only few possible solutions
- enough time is given

Better concept (GA)
```
Generate a set of random solutions
Repeat
	Test each solution in the set and rank them
	Remove some bad solutions from set
	Duplicate some good solutions
	Make small changes to some of them
Until (“best” solution is good enough)
```
GA's often encode solutions as fixed length "bit strings", each bit represents some aspect of the proposed solution

We need to be able to "test" any string and get a "score" indicating how "good" a solution is

==Fitness function==
**Fitness function** -> function that can generate a score for each solution based on a function that measures “how good” it is 
- simple fitness function are one-dimensional $f(x)$
- many dimensions can be searched, eg. 2 -> $f(x,y)$
- point in space -> possible genotype
- GA tries to move the points to higher fitness
	![[Pasted image 20241009155443.png]]
==Search space==
- its nature dictates the performance of GA
- GA can be stuck in local maxima
- "smooth" spaces (small movements get closer to global optimum) are good

==Adding Sex - Crossover 😏==
previous GA concept had Asexual reproduction, but we can do better
**Sexual reproduction** -> selecting 2 parents during reproduction and combining their genes to produce offspring, each offspring may then be changed randomly (mutation)
- "Roulette Wheel" selection is often used
	![[Pasted image 20241010142524.png|400]]
	![[Pasted image 20241010142725.png]]
	- width of each edge is proportional to the score of the chromosome 
	![[Pasted image 20241010142822.png|350]]
	![[Pasted image 20241010142948.png|250]]
	Parent 1 -> chromosome 6
	Parent 2 -> chromosome 2
	With some small probability called the mutation rate (typical values between 0.1 and 0.001) flip some bit in the offspring
	![[Pasted image 20241010143144.png|450]]
	![[Pasted image 20241010143206.png|450]]


> [!Warning] slide 19 - 40 missing

==Evolutionary game theory==
2 beetles competing for food
![[Pasted image 20241010140304.png|300]]
Beetles do not choose a size (=strategy), they're hard-wired to choose one strategy (the one they're born with)

Nash Equilibrium -> replaced by  **evolutionary stable strategy**, a genetically-determined strategy that tends to persist once it becomes prevalent.
**Fitness of an organism in a population** -> payoff it receives from an interaction with a random number

Strategy $T$ **invades** strategy $S$ at level $x$ (for some small positive number $x$) $\implies$ a fraction of $x$ of the underlying population uses $T$ and a fraction $1-x$ of the underlying population uses $S$

Strategy $S$ is **evolutionary stable** $\implies$ there's a small positive number $y$ such that when any other strategy $T$ invades $S$ at any level $x<y$, the fitness of an organism playing $S$ is strictly greater than the fitness of an organism playing $T$ (simple words: $S$ is the generally optimal "choice" in the sphere of that system i suppose)

$\Phi(X)$ -> payoff of strategy $X$

- Beetle fight for food example
	Large invades Small
	payoff for Small
	$$\Phi(S) = 5(1−x) + 1⋅x = 5−4x$$
	payoff for large
	$$\Phi(L) = 8(1−x) + 3⋅x = 8−5x$$
	$$(\Phi(L)>\Phi(S))$$
	$S$ in not evolutionary stable

Natural selection increases the fitness of individual organisms in a *fixed* environment, when the environment changes to become more hostile to organisms, their fitness could decrease (we see it happen in nature obv)

## Network Science Introduction
**Network science** -> study of networks, interdisciplinary study based on mathematics blending ideas from many other fields (Physics, CS, Sociology, etc.)

2 perspectives
- Theoretical
- Experimental -> available with data availability

2 aspects
- Structure -> "shape" of a network (relations)
- Dynamics -> how the "shape" changes over time

**Network** -> Abstract mathematical construct representing relations that exist between pairs of objects 

##
##