[Slides, Prof's site](https://www.cs.unibo.it/~babaoglu/courses/csns/calendar/index.html)

> Notes taken by Luizo ( [@LuigiBrosNin](https://t.me/LuigiBrosNin) on Telegram)

- Exam info
	https://www.cs.unibo.it/~babaoglu/courses/csns/papers/index.html
	paper presentation -> send an email of the picked paper link, then there are presentations in class
	1. Relevance of the topic to the course,
	2. Quality of the contents,
	3. Quality of the delivery,
	4. Quality of the slides,
	5. Adherence to the time limit (30 minutes)
	
	final project -> individual, using PeerSim or NetLogo modeling environment
	
	Final grade for the course will be based on three factors: (i) the research paper presentation (40%), (ii) the project written report (50%) and (iii) the project discussion (10%).

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
	- Planetary dynamics -> motion of planets and other celestial bodies
	- Fluid dynamics -> motion of fluids, turbulence, air flow
	- Crowd dynamics -> behavior of groups of people, stampedes
	- Population dynamics -> how populations vary over time
	- Climate dynamics -> variations in temperature, pressure, hurricanes
	- Financial dynamics -> variations in stock prices, exchange rates
	- Social dynamics -> conflicts, cooperation

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
	4. Nearly all initial patterns evolve into structures that interact in complex and interesting ways (**complex** -> capable of universal computation)![[Pasted image 20240930185822.png]]

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
	- Confession leads to higher individual payoff -> selfishness
	- Denial leads to higher global payoff -> cooperation
	
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
	![[Pasted image 20241010142524.png]]
	![[Pasted image 20241010142725.png]]
	- width of each edge is proportional to the score of the chromosome 
	![[Pasted image 20241010142822.png]]
	![[Pasted image 20241010142948.png|250]]
	Parent 1 -> chromosome 6
	Parent 2 -> chromosome 2
	With some small probability called the mutation rate (typical values between 0.1 and 0.001) flip some bit in the offspring
	![[Pasted image 20241010143144.png]]
	![[Pasted image 20241010143206.png]]

```
Generate a population of random chromosomes
Repeat (generation)
	Calculate fitness of each chromosome
	Repeat
		Select pairs of parents with roulette selection
		Generate offsprings with crossover and mutation
	Until (a new population has been produced)
Until (best solution is good enough)
```

- ==GA Algorithm variants==
	Different selections
	- Tournament
	- Elitism
	- etc
	Different recombination
	* Multi point crossover
	* 3 way crossover
	* etc
	Different encodings
	- integer values
	- ordered set of symbols
	Different mutations

- ==GA parameters==
	- $N$ -> population size
	- $m$ -> mutation rate
	- $c$ -> crossover rate
	need to be tuned
	Some common values: $N = 50,\ m = 0.05,\ c = 0.9$

(i skipped the iterated prisoner's dilemma part, you can watch [this](https://www.youtube.com/watch?v=emyi4z-O0ls) to get the jist)

==Evolutionary game theory==
Basic idea of evolutionary game theory is that the fitness of an individual cannot be measured in isolation but has to be evaluated in the context of the full population in which it lives.
An organism’s characteristics and behaviors (determined by its genes) are like its strategy in a game.
Its fitness is its payoff and this payoff depends on the strategies (characteristics, behaviors) of the organisms with which it interacts.

2 beetles competing for food
![[Pasted image 20241010140304.png]]
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
Networks can represent any binary relationship over objects, both can be physical or virtual
A network is defined by the list of objects and the relations that exist over
objects, not by its visualization

- **Edges thickness** in visualization means a strong relationship
- **Node size** in visualization means how important it is (usually based on the number of edges)

Network challenges
- Size -> current  networks might have billions of nodes, and thus several hundred billion friendship relations
- Complexity -> 24 nodes, $(24\times23)/2$ symmetric relations, $2^{(24\times23)/2}$ possible networks
We need a way to represent networks and capture their properties succinctly and abstractly without having to “catalogue” them

**Erdős numbers** -> shortest "distance" between a given mathematical and the hungarian mathematician Paul Erdős (a mathematician)
![[Pasted image 20241014104217.png]]

## Graph Theory

**Graph Theory** -> Branch of mathematics for the study of discrete structures called graphs for modeling pairwise relations between objects

==Graph base definitions==

Graph -> pair $G= (N,E)$ where
- $N$ -> Set of nodes (vertices)
- $E$ -> set of edges (links, arcs)
Notation
- $n$ -> number of nodes
- $m$ -> number of edges
Letters to label nodes, node pairs to label edges
![[Pasted image 20241014110935.png]]
graph visualization for the graph
$$G = (\{A, B, C, D\}, \{(A, B), (A, C), (A, D), (B, D)\})$$

**Binary relations** -> Nodes are the objects, the presence of an edge indicates that some relation $R$ holds between the nodes, the absence indicates that relation $R$ does not hold. not very expressive beyond connecting 2 nodes (eg. paper written by 3 authors)
![[Pasted image 20241014111658.png]]

**Directed graphs** -> An asymmetric binary relation holds in one direction only and is represented by a directed edge
![[Pasted image 20241014111851.png]]

**Weighted graphs** -> Both directed and undirected graphs can have a weight associated with edges to represent the strength of the relation

$n$ nodes, $2^{n(n-1)/2}$ possible combinations 

**Degree** of a node -> number of edges incident on it
in-degree / out-degree distinction in direct graphs
![[Pasted image 20241017160827.png]]

**Path** -> alternating sequence of nodes and edges of the graph, can be a **Cycle** where first and last nodes are the same, but otherwise all nodes are distinct
![[Pasted image 20241017161200.png]]
- $CABD$ -> simple path
- $ADBAC$ -> path
- $BDAB$-> cycle

**Length** -> number of steps in a path, the number of edges
**Distance** -> between two nodes in a graph is the *length* of the shortest path between them
**Diameter** -> longest distance between all pairs of nodes (*longest shortest path*)
**Connected subgraph** -> a subgraph where there is a path between every pair of nodes
**Component** of a graph -> maximal connected subgraph (directed paths can be strongly connected)
**Giant Component** -> largest component of a graph that contains a significant proportion of all nodes
**Bridge** -> edge that if deleted increases the number of components of the graph
	![[Pasted image 20241017162648.png]]

==Clustering==
**Clustering** -> measure of how "bunched up" (unevenly distributed) the edges are
**Clustering coefficient of node** $A$ -> probability that two randomly selected friends of $A$ are friends themselves
$CC$ is between 0 and 1
![[Pasted image 20241017163316.png]]
$A$ has 4 friends
6 possible friendships among them ($4\times 3/2$)
only 4 are present
$CC=\frac{4}{6}= 0.\overline 6$

**Clustering coefficient of graph** $G$ -> average of $CC$s of all nodes in $G$
![[Pasted image 20241017163207.png]]
Clustering quantifies the likelihood that nodes that share a common neighbor are neighbors themselves
<u>Alternative definition</u> of **clustering coefficient of a graph** -> Proportion of all possible triangles that are actually closed
![[Pasted image 20241017163836.png]]

**Edge density** -> the actual number of edges in proportion to the maximum possible number of edges in a graph
$$p = \frac m {n(n-1)/2}=\frac {2m} {n(n-1)} $$

$p \in$ 0 to 1
![[Pasted image 20241017140655.png]]

We will compare the **clustering coefficient** $CC$ of a graph to its edge density $p$
**Highly clustered graph** -> $CC >> p$

![[Pasted image 20241017140824.png]]

==Centrality metrics==
given nodes in a graph, **centrality metrics** try to formalize notions such as “important”, “influential” or “popular”
![[Pasted image 20241017143419.png]]
eg. Medici is an important family

Different notions of centrality
- Degree -> well connected-ness
- Between-ness -> criticality for connected-ness
- Closeness -> short distances to the rest of the graph
- Eigenvector -> importance
Centrality is a property of a node but in context of the entire graph

**Centralization** -> define a global notion of centrality that applies to the entire graph

**Degree centrality** -> the greater the degree of a node, the more "important"

Degree-based centrality is not able to capture the notion of **brokerage** -> ability of a node in a graph to act as a bridge between different components

- **==Between-ness==** -> of a given node $u$  is the fraction of all pairwise shortest paths that go trough $u$
	$$B(u) = \sum\limits_{all\ pairs\ i,j} \frac {g_{ij}(u)} {g_{ij}}$$
	$g_{ij}$ -> number of shortest paths between $i,j$
	$g_{ij}(u)$ -> number of shortest paths between $i,j$ that go trough $u$
	![[Pasted image 20241017145430.png]]
	:LiArrowBigUp: examples

- **==Closeness==** -> closeness to the "central" position, close to the rest of the graph, closeness of a given node $u$ :
	$$C(u)=\frac {n-1}{\sum\limits_{i}d(u,i)}$$
	$d(u,i)$ -> length of shortest path between nodes $u$ and $i$
	![[Pasted image 20241017145234.png]]
	:LiArrowBigUp: closeness examples

- ==Eigenvector centrality== -> importance of a node determined by the <u>importance of its neighbors</u> (recursive definition)
	Informally, an important node in a directed graph is pointed to by lots of other important nodes
	![[Pasted image 20241017150706.png]]
	$$R(t+1,B)=\sum\limits_{\forall A:(A,B)\in E} \frac {R(t,A)}{out(A)}$$
	Formally, the solution is equivalent to solving for the *eigenvector* of a matrix (describing the connectivity of the graph)
	We can approximate the result algorithmically by iterating
	![[Pasted image 20241017151142.png]]
	Example




## Real Networks and Universal Properties
Networks are typically very different at the microscopic level
==Universal structural properties==:
- **Heavy-tailed degree distributions** -> “hubs”, “connectors”
- **Small diameter** -> “six degrees of separation”
- **Highly clustered** -> “friends of a friend are friends”
- **Well connected** -> only one giant component
Need to make precise the notions “heavy”, “small”, “highly” and “well”

- Heavy-tailed distributions
	![[Pasted image 20241024134450.png]]
	- Nodes with **small degree** (eg. number of connection per node) are most frequent
	- Fraction of high-degree nodes decreases but much more slowly than what is predicted by the random models with Poisson or Normal degree distributions which decay exponentially
	- Typical of networks that have a few hub or connector nodes with very high degree and many nodes with small degree
	What are the <u>signatures</u> of heavy-tailed distributions? -> Plotting degree distribution

- Plotting degree distributions
	two forms for the distribution function
	- Exponential $f(x)=c^{-x}$
	- Power-law $f(x)=cx^{-a}$
	![[Pasted image 20241024133355.png]]
	A straight line on a **log-log scale** becomes the signature of power-law distributions
	$$f(x) = cx−α$$$$\log( f(x)) = \log(cx^{−α} )$$$$\log( f(x)) = \log(c) + \log(x^{−α})$$$$\log( f(x)) = \log(c) − α\log(x)$$
	Power-law distributions in the wild Math Reviews co-authorship
	![[Pasted image 20241024134118.png]]
	![[Pasted image 20241028225715.png]]

==Power-laws and popularity==

> *A power law is a functional relationship between two quantities, where a relative change in one quantity results in a relative change in the other quantity*

Popularity is a phenomenon characterized by extreme imbalances due to
network effects, it is a result of positive feedback or reinforcement due to correlated decisions in a population.
The “rich-get-richer” phenomenon

We measure **popularity** with the *number of in-edges*, and from web data (contrary from what we would expect from the central limit theorem) the fraction of pages that have $k$ in-edges follows a power-law and is approximately proportional to $k^{−c}$

iPhone app popularity
![[Pasted image 20241028230740.png]]

Small changes in early history can change the ranking

==**Scale-free networks**== -> Networks with degree distributions that are described by power-laws (adhere to that distribution)

$f(x)$ is called scale free if $f(bx)=C(b)\cdot f(x)$
$C(b)$ -> some constant that depends only on $b$
aka, the overall form of the function does not change when considering values for $x$ that are a factor $b$ larger
related to mathematics **fractals**
![[Pasted image 20241024143222.png]]

==Path lengths==
**Diameter** -> longest shortest path
Smallest Diameter -> $1$
Largest Diameter -> $n-1$ (grows linearly)

A network exhibits small diameter if it is not constant but grows <u>sublinearly</u> with network size -> $\log n, \log \log n$, etc

diameters and path lengths behave similarly, thus under weak assumptions we can show they're roughly proportional
![[Pasted image 20241028232707.png]]

==**Clustering coefficient**== -> probability that two randomly selected
friends of it are friends themselves (*closed triangle*)
**Edge density** -> number of edges in proportion to the maximum possible number of edges
**High clustering** -> when the clustering coefficient is significantly greater than the edge density

> [!Notes] Universal properties summary
> - Heavy-tailed degree distribution
> - Small diameter and average path length
> - Highly clustered
> - Very few (typically just one) connected components

## Erdős-Rényi Model for Network Formation
approach of Random model -> choices independent of current network structures
Characteristics
- Undirected network
- Start with all isolated nodes and add edges one at a time randomly
- Simple af but helpful, benchmark for evaluating real networks
- Populating by
	- randomize edge presence or absence
	- randomize node pairs

==Random edge presence==
$n$ -> Number of nodes
$p$ -> Probability that an edge is present
![[Pasted image 20241121153237.png]]
![[Pasted image 20241121153322.png]]
$k$ -> node degree (number of edges connected to that node)
The probability that a given node has degree $k$ is given by the Binomial
distribution:
$$\pmatrix{n-1 \\ k}p^k(1-p)^{n-1-k}$$
![[Pasted image 20241121153841.png]]
![[Pasted image 20241121153901.png]]

![[Pasted image 20241121153924.png]]

==Randomize node pairs==
$n$ -> number of nodes
$m$ -> number of nodes
![[Pasted image 20241121154731.png]]

==Degree distribution in ER models==
The ER model is a poor predictor of degree distribution compared to real
networks, as it results in Poisson degree distributions that have exponential
decay (real networks exhibit power-law degree distributions that decay way slower)

==ER diameter==
**Diameter** -> longest shortest path between pairs of nodes / the average distance between 2 random nodes
Diameter range based on model parameter $p$ -> 0 to 1
ER diameter (after calculations) is in the order of $l$ steps $\log(n)/\log(z)$ 
$z$ being the mean $p(n-1)$
Actual diameter is roughly twice $\log(n)/\log(z)$, and ER is a good predictor of diameter and avg path length for real networks

==ER clustering coefficient==
**Clustering coefficient** of a node -> probability that two randomly selected friends of it are friends themselves
in ER model, an edge is present with probability $p$ = CC
**Edge density** of a network -> actual number of edges in proportion to the
maximum possible number of edges
in ER model, $pn(n−1)/2$ nodes on average
ER models are not highly clustered and are bad predictors

==ER giant component==
for edge density $p$, expected node degree is $p(n-1) \sim pn$ for large $n$   
Giant components start to form at low values of $p$
- $p< 1/n$ -> probability of a giant component tends to 0
- $p> 1/n$ -> probability of a giant component tends to 1, components have at most size $\log n$

EL model is able to explain
- small diameter, path lengths
- giant components
EL model is not able to explain
- degree distributions
- clustering

## Clustered Models
Extending the ER model to be a better predictor
Let's add edges with reason instead of randomly

**Triadic closure** -> People that have common friends have more occasions to meet each other and
become friends themselves
**Homophily** -> People who have common friends often also have common interests

==Alpha model==
Bias connection towards nodes that have common neighbors

$y$ -> probability of adding an edge between a pair of nodes with $x$ common neighbors
$$y\sim p+(x/n)6^a$$
for some constants $p,a$
![[Pasted image 20241125195519.png]]
![[Pasted image 20241125195536.png]]
we can tune the model with the $a$ parameter and achieve high clustering

==Watts-Strogatz model==
regular network capturing relations that correspond to geographic, social proximity
high clustering, large diameter

**Rewire** -> replace a few local edges with random shortcut edges corresponding to occasional contacts outside of usual social circles (balance local and "long distance" edges)
![[Pasted image 20241125195949.png]]
$q$ -> probability of replacing an edge
- Diameter is governed by the number of random shortcuts ($qn$)
- Clustering is governed by the fraction of random shortcuts ($q$)
![[Pasted image 20241125200057.png]]

Clustering coefficient of $K$-regular lattice:
$$\frac{3(K-2)}{4(k-1)}$$
Converges to 3/4 in the limit for large $K$
 Average path length for a d-dimensional hypercube scales as $n^\frac{1}{d}$ which grows much faster than logarithmic

CC of WS model:
$$\frac{3K(K-1)}{2K(2K-1)+8qK^2+4q^2K^2}$$
Average path length:
$$\frac{n^\frac{1}{d}}{K}f(qKn)$$
where $f$ is a universal scaling fuction

(yeah i understood nothing either  in that last slide lol)

## Random and preferential attachment models for network growth
We want to examine models that define network growth.
Growth adds more realism, dynamism and heterogeneity

==Uniform random model==
Extend the Erdos-Renyi model to dynamic nodes
- a new node is born at each time step
- the new node has $m$ edges to allocate to existing nodes
- each node to link to is selected at random uniformly
- Assume first $m$ nodes are fully connected
- At time $t$ there will be $t$ nodes all together ($t−1$ existing nodes plus the new one) and an existing node will get a new link with probability $m/t$
![[Pasted image 20241205193606.png]]
**Average edges for each node** at time $t$ -> $m+m/(i+1)+m/(i+2)+ … +m/t$ 
for large $t$ can be approximated to -> $m(1+\log (t/i))$
**Average node degree less than k** are those such that -> $m(1+\log(t/i)) < k$
![[Pasted image 20241205194112.png]]
if we solve $m(1+\log(t/i)) < k$ for $i$ we get the time that a node has to be born to have degree less than $k$ ($i > t\ e^{−(k−m)/m}$)
Distribution of expected degrees is exponential with mean $m$

==Preferential attachment==
Idea: Do not link new nodes uniformly and randomly but according to a “rich-get-richer” scheme which is known to produce heavy-tailed distributions
This process amplifies inequality among node degrees

**Preferential attachment** -> model where the likelihood of linking to a node is proportional to its current degree. The greater the degree, the more edges it will get making its degree even greater

## 13 MISSING

## Peer-to-Peer Systems
Definition -> Distributed systems where all nodes are peers without distinction between servers and clients

Each node can be both a server and a client (provide and consume services)

- Napster functionality example
	![[Pasted image 20241114132205.png]]

![[Pasted image 20241114132331.png]]

- Example Client/server vs peer to peer
	![[Pasted image 20241114132550.png]]
	![[Pasted image 20241114132606.png]]


| Client-server                                                        | Peer-to-peer                                                        |
| -------------------------------------------------------------------- | ------------------------------------------------------------------- |
| ==Asymmetric==: client and servers carry out different tasks         | ==Symmetric==: No distinction between nodes; they are peers         |
| ==Global knowledge==: servers have a global view of the network      | ==Local knowledge==: nodes only know a small set of other nodes<br> |
| ==Centralization==: communications and management are centralized    | ==Decentralization==: no global knowledge, only local interactions  |
| ==Single point of failure==: a server failure brings down the system | ==Robustness==: several nodes may fail with little or no impact     |
| ==Limited scalability==: servers easily overloaded                   | ==High scalability==: high aggregate capacity, load distribution    |
| ==Expensive==: server storage and bandwidth capacity is not cheap    | ==Low-cost==: storage and bandwidth are contributed by users        |

Peer-to-Peer systems are usually structured as “overlays” -> Logical structures built on top of a physical routed communication infrastructure (IP) that creates the allusion of a completely-connected graph

Links are based on logical “knows” relationships rather than physical connectivity

**Churn** -> Nodes may disconnect temporarily, nodes are continuously joining and leaving the system

Malicious users may try to bring down the system, or run hacked clients in order to avoid contributing resources

P2P enables environments that
- Highly available
- Fault-tolerant
- Self organizing
- Scalable
- Difficult or impossible to shut down
"grassroots" approach and a "democratization" of the internet

Problems
- Overlay construction and maintenance
- Data location -> locate data over large number of nodes
- Data dissemination -> propagate in a robust way
- Global reasoning with local information -> maintain local views
- Tolerance to churn -> system invariants despite node arrivals and departures

Applications
- Sharing content
- Sharing storage
- Sharing CPU time

Topologies
- Unstructured
- Structured
	- Centralized
	- Hierarchical
- Hybrid

Common topologies
- Flat unstructured
	![[Pasted image 20241114140010.png]]
	- Easy to disseminate data
	- Hard to search for it (*Flooding*, aka request propagates to all nodes until found, high traffic for each request, even with search horizon)
- Two-level unstructured
	![[Pasted image 20241114140033.png]]
	- SuperPeer nodes
	- Small overlay
- Flat structured
	![[Pasted image 20241114140050.png]]
	- efficient data location
	- long join and leave procedures

==Key-Based Routing==
Structured networks use a routing algorithm that implements key-based routing (KBR)
- Nodes are assigned an id (randomly)
- given key $k$, look for the smallest $id \ge k$ , will be the ==k root==
- $O(\log n)$ to route the message to the root of $k$
- $objectId$ is tracked by the root of key $objectId$
![[Pasted image 20241114144001.png]]

(this was confusing, but we're basically just mapping in a way that lets us find stuff in log n time lol)


## Decentralized Network Formation
The set of all nodes is known and static in normal network formation models
in practical settings it's unrealistic, as the set of nodes is not known, huge and dynamic

We can relax the model to achieve something similiar to Erdos-Renyi network

==Newscast==
Decentralized protocol, creates and maintains a random overlay
- Resilient to churn
- Simple design based on info **gossip**
	- each node knows its immediate neighbors (its **view**)
	- each node picks periodically a random node from its view, and exchange their views and updating them 🧠
$entry =\{node\ adress,\ timestamp\}$
in the algorithm, always keep the most recent entries when exchanging views
![[Pasted image 20241114151325.png]]
![[Pasted image 20241114151340.png]]

- Newcast Plots
	Path length by network size
	
	![[Pasted image 20241114152008.png]]
	
	Path length by round
	![[Pasted image 20241114152425.png]]
	
	Churn affecting the path length between 20 and 40
	![[Pasted image 20241114152444.png]]

==Robustness of networks==
some components can be attacked to cause maximum harm
failures -> removing nodes/links selected at random, included in churn
attacks -> removing nodes that have the largest degree and links that are bridges

Robustness in how much removal of nodes/links affects connectivity and average path length
![[Pasted image 20241114153403.png]]

![[Pasted image 20241114154316.png]]

![[Pasted image 20241114154343.png]]

==Cyclon==
modified Newscast to generate networks with small diameter and small clustering coefficients
- instead of picking a random node it picks $Q$ = Oldest node
![[Pasted image 20241114154600.png]]
![[Pasted image 20241114154625.png]]

- Small clustering coefficient
- Small average path length
- Cyclon generated graphs are closer to random (rather than small world)

- ==Cyclon Plots==
	![[Pasted image 20241114154709.png]]

==Topology management==
- **Morphogenesis** attempts to understand the processes that control the organized spatial distribution of cells during embryonic development and that give rise to the characteristic forms of *tissues, organs, and overall body anatomy*
- An interesting theory based on “differential cell adhesion”
	- different cell types “sort out” based on “likes” and “dislikes” for each other
	- any cell configuration has an energy level
	- cells try to minimize the free energy in the system by a stochastic movement process
![[Pasted image 20241118092423.png]]

In overlay networks we have freedom to define peer relationships as we wish
- Using the notion of "like" and "dislike" by ranking function
- We can change topology on the fly

==T-Man==
Each node maintains a local view of neighbors, and periodically exchange its view with a random neighbor peer
Each nodes updates its local view by applying the ranking function to the union of the two views

- ==T-Man plots==
	![[Pasted image 20241118093136.png]]
	![[Pasted image 20241118093204.png]]

## Aggregation
Networks seen as the underlying transport mechanism for processes that are being carried out on top of them
So far we've seen processes as
- Gossiping
- Heartbeat sync
- Formation creation
We'll look into **aggregation** now

**Aggregation** -> Each node has an initial value, i want to compute in a decentralized manner an aggregate function over the initial values
eg. Average

==Gossip instantiation example==
Style -> Push-pull
Local state `S` -> current estimate of global aggregate
Method `SelectPeer()` -> Single random neighbor
Method `Update()` -> defined according to the desired global aggregate

$S_p$ local variable, current estimate of the aggregate
`Update`$(S_p,S_{q})=\frac{S_p+S_q}{2}$ (average)

In gossip-based averaging, if the selected peer is a globally random sample, then the expected variance among the estimates decreases exponentially
![[Pasted image 20241118100757.png]]

==Network size estimation==
- Base the size estimate on the aggregate value that can be computed trough a decentralized algorithm
- Compute the arithmetic mean starting from zeroes at all nodes except one that holds 1
- Mean value is $1/n$ and network size $n$ is obtained by inverting the mean

Vulnerable to failures, especially early on
We fix it with redundant execution and average all result instances :)

- Robustness plots
	![[Pasted image 20241118101656.png]]
	![[Pasted image 20241118101716.png]]
	![[Pasted image 20241118101726.png]]
	![[Pasted image 20241118101742.png]]

## Rational dynamics
**Dynamics** -> what is happening in the network (eg. navigation, gossiping, ...)
**Rational dynamics** -> nodes as individuals/active entities with intent, goals and self-interests

Let's study rational dynamics trough *Game theory*

Players are **rational** -> each tries to maximize her own payoff, given her beliefs about the strategies used by other players

Iterated network games, prisoner's dilemma
(i won't explain the dilemma again)

==**Copy and rewire**==
- Two logically distinct networks:
	- Random overlay network to maintain connectivity
	- Application-dependent interaction network
- Periodically, node P compares its utility with that of a peer Q selected at random (from the connectivity network)
- If Q has been achieving higher utility
	- P copies Q ’s strategy
	- P rewires its links to the neighbors of Q
- With (very) small probability, node P
	- “Mutates” its strategy (picks an alternative strategy at random)
	- Drops all of its current links
	- Links to a random node

- Pull style interactions
- Local state $S$ -> Current utility, strategy and neighborhood within an interaction network
- `SelectPeer()`: Single random sample
- `Update()`: Copy strategy and neighborhood if the peer is achieving better utility (average payoff achieved so far)

==Homophily==
Individuals seek similar individuals

Peer effects -> related but different property where individuals adopt the
behavior of their peers

**Segregation** -> Individuals:
- Have a type;
- Achieve utility based on the types of individuals in their surrounding;
- They care about where they live; 
- Can move if they're not happy;
The individuals will (obv) tend to aggregate

==Schelling’s threshold model==
Schelling’s Segregation Model to study homophily in a fixed grid network based on a threshold $t$

The eight compass neighbors of an individual
define its “neighborhood”
- If the percentage of same-type individuals in its neighborhood is at least $t$, the given individual is happy and stays where it is
- Otherwise, it is unhappy and it moves to another (empty) grid position
- Collective game
![[Pasted image 20241118111917.png]]
5 changes from red to green -> $x$ will leave

With a $k\times k$ grid, there are $k^{2}$ possible strategies about choosing where to live

payoffs:
$h$ -> percentage of neighbor cells with the same type as self
$t$ -> threshold 
payoff 1 -> $h\ge t$
payoff 0 -> $h< t$

individuals move when payoff is 0
Equilibrium dynamics reached when all players have payoff 1

51% Tolerance leads to almost perfect desegregation (94% of individuals having similar type neighbors)
## 18 MISSING

##

# Paper presentation
[[Presentation notes]]

You can find the presentation source file in my repo :)
# NetLogo Notes

**NetLogo** -> Programmable modeling environment, used to model complex system development, FOSS :)

- ==Environment==
	![[Pasted image 20241114141640.png]]
	The whole world is a **discrete grid**, each basic region is called a **patch**
- ==Agents==
	![[Pasted image 20241114141753.png]]
	Agents are called **turtles**, they can move independently
	Each turtle has a
	- position
	- heading (expressed in degrees, 0 -> north)
	- size
	- color
	- shape
	![[Pasted image 20241114141944.png]]
	Agent action are performed in discrete time, every **tick**
	
	Each agent has a set of properties
	- who
	- heading
	- xcor and ycor
	- shape,size,color
	- hidden?
- ==Observer==
	The **observer** modifies the environment and the agents trough **commands**
	- `create turtles <num>
	- `inspect turtle <whoID>`
	![[Pasted image 20241121142911.png]]

==NetLogo programming==
**Instructions** tell agents what to do
classification
- primitive -> built in
- procedure -> user implemented
---
- report -> produces an output
- command -> does not produce an output

Functions (basically)
![[Pasted image 20241121145625.png]]
![[Pasted image 20241121145642.png]]

Style tips
- camelCase for procedures
- no underscores in names
- command procedure are nouns, reporters with berbs

Variables
- Local -> part of a procedure
- Agent -> part of each agent
- Global -> accessible by procedures and agents
![[Pasted image 20241121143411.png]]
Variables are dynamically typed.
primitives -> numbers (all floating points), booleans, lists, strings

Agentsets
When asking to update an agent variables a subset of all the agents,
called agentset, can be used.
An **agentset** contains one or more agents, all of the same type, and
it's always randomly ordered.
```netLogo
ask one-of turtles [ <command> ] ; randomly choose among the whole set

let some-patches patches with [ pxcor < 3 ] ; take patches with X < 3

ask some-patches [ set pcolor red ] ; change the color of the subset
```

Conditionals examples
![[Pasted image 20241121144044.png]]

Loops examples
![[Pasted image 20241121144119.png]]

Lists
Lists are immutable, ordered and potentially (regarding type) heterogeneous
`[1, true, "two"]`

General program structure
1. global variable declaration
2. agent variable declaration
3. setup procedure -> global variables initialization, agents creation, environment initialization
4. go procedure -> implements one cycle of simulation

==Some useful features==
**Higher order procedures** -> we can simulate it using anonymous procedures/reporters (basically inline functions)
![[Pasted image 20241121145722.png]]
example
![[Pasted image 20241121145757.png]]

**Map, filter and reduce** -> basic constructors that allow efficient and elegant operations on lists.
- **Map** -> applies an anonymous-reporter to every element in a list.
- **Filter** -> applies a predicate (in the form of anonymous-reporter) to a list and returns only those items that entails the predicate.
- **Reduce** -> applies an anonymous-reporter from left to right, resulting in a single value.

**Breeds** -> a way to **subclass** the turtle type ("breeding" an agentset)
**Graphing** -> special agents that moves trough the graph
* **setup** -> where we set the graph range (x-axis) with special agent pen properties
- **update** ->where we need to draw data, called every tick


#

## 

%% Begin Waypoint %%
- **[[attachments]]**

- [[Presentation notes]]

%% End Waypoint %%