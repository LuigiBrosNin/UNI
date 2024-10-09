[Virtuale](https://virtuale.unibo.it/course/view.php?id=66347)

> Notes taken by Luizo ( [@LuigiBrosNin](https://t.me/LuigiBrosNin) on Telegram)

- Exam info
	project followed by Gabrielli and Zingaro, easy exam (at least as Gabrielli says)
	group of 1->4 people, ideally 3, but they're flexible
	discussion is about the project mainly, and important theory stuff, but not much in depth

# Teoria
## Intro
> [!note] Artificial Intelligence Definitions (informal)
> 1. Turing's imitation game test
> 2. "Knowing what to do when you don't know what to do"
> 3. Models that are designed to generate new content, such as images, text, audio, or even video (Generative AI)
> 4. Thinking/Acting humanly, Thinking/Acting rationally

**Artificial General Intelligence** (AGI) -> AGI is envisioned as having the capability to perform any intellectual task that a human being can do

To solve problems with AI, there's not a defined algorithm, but we **train** (a neural network) to adjust the model's result trough labeled data (basically data with solutions).
In Training phase each neuron has a simple function $f(x)=\alpha x$ where is is a real number, the weight of $x$ on the final decision (output).
Comparing the $output\ net - desired \ output$ will make sure that the error will be lower.
There are different measures to attest the efficiency of the model, one of them is *accuracy*, but there are many others that have to be used case per case. as accuracy is not always a good metric.

3 types of AI
- Symbolic AI -> Rule based systems
- ..
- ..
## Neural Networks

## 
i'm following the lessons without notes from now on, as there are some notes on CSUnibo i could study into, i might still do summaries and exam resources. as usual i recommend Cortigiano's notes (italian notes).


# Summaries

## Intelligent agents
**Agents function** (History -> Action)
$$f : P^∗ → A$$
**Rationality** -> choosing whichever action maximizes the expected value of the performance - <u>exploration, learning, autonomy</u> (not being successful) 
**PEAS** -> Task environment
- Performance measure 
- Environment
	- Observable
	- Deterministic
	- Episodic
	- Static
	- Discrete
	- Single-Agent
- Actuators -> possible low level actions
- Sensors
==Agent types==
- Simple reflex agents (Condition -> Action)
	![[Pasted image 20241009094201.png|450]]
- Reflex agents with states (State -> condition -> action)
	![[Pasted image 20241009094419.png|450]]
- Goal-based agents (State -> prediction -> action)
	![[Pasted image 20241009094552.png|450]]
- Utility-based agents (State -> prediction -> maximize utility -> action)
	![[Pasted image 20241009095530.png|450]]
- Learning agents (feedback -> changes -> knowledge -> learning goals)
	![[Pasted image 20241009100821.png|450]]
## Problem solving and search
![[Pasted image 20241009101635.png]]
:LiArrowBigUp: General formalization of an agent
==Problem types==
- Deterministic, fully observable ⇒ **single-state problem**
- Non-observable ⇒ **conformant problem**
- Nondeterministic and/or partially observable ⇒ **contingency problem**
- Unknown state space ⇒ **exploration problem (“online”)**

##