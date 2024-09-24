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
