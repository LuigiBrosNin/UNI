[Slides, Prof's site](https://www.cs.unibo.it/~babaoglu/courses/csns/calendar/index.html)

> Notes taken by Luizo ( [@LuigiBrosNin](https://t.me/LuigiBrosNin) on Telegram)

## Theory

### Intro

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

### Dynamical Systems and Non-Linear Dynamics

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

![[Pasted image 20240926150044.png]]
Logistic map an Tent map are *equivalent* ->  Need to find a transformation function $g(x)$ and its inverse $g{−1}(x)$ such that
$$L(x)=g{−1}(T(g(x)))\ and\ T(x)=g(L(g{−1}(x)))$$
![[Pasted image 20240926150702.png]]
:LiArrowBigUp: tent map behavior
- $b_1$ must be 0 because any binary number will be $\ge 1/2$ if $b_1$ is 1 compared to the maximum value it can have ( 100 -> 4, 111 -> 7 for example)
- to compute $2x$, since we double everything and we're in a binary system, the 1 bit shift is a $\times 2$ operation, just like in decimal shifting a number is a $\times 10$ operation.

![[Pasted image 20240926150933.png]]

![[Pasted image 20240926151611.png]]

- Case 1 ⟹ “fixed point”
- Case 2 ⟹ “periodic”
- Case 3 ⟹ “chaotic”

The Logistic Map at chaos can be turned into a “random bit generator"
$$ x_{i}\le 0.5 \implies 0 \qquad x_{i}> 0.5 \implies 1$$
