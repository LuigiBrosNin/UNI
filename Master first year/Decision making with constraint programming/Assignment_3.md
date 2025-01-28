100/100
# N-Queens

| n   | Fails       |                 |         |              |                 |         |
| --- | ----------- | --------------- | ------- | ------------ | --------------- | ------- |
|     | min value   |                 |         | random value |                 |         |
|     | input order | min domain size | domWdeg | input order  | min domain size | domWdeg |
| 30  | 1.588.827   | 15              | 15      | 9            | ==1==           | ==1==   |
| 35  | 2.828.740   | 21              | 21      | 10           | ==0==           | ==0==   |
| 45  | -           | 6               | 6       | 6            | ==1==           | ==1==   |
| 50  | -           | 123             | 123     | 42           | ==10==          | ==10==  |

Present briefly your observations. Pay attention to the
following points.
- For a given variable ordering, how does random value choice change the performance?
	In all given cases, using random value choice significantly boosts performance, this is because if we're using minimum value choice, we fall into what we call "heavy tail behaviour", which for some combination of instance + solver parameters, if we make a "mistake" early during search, the solver will take a long time (especially in DFS) to change the variable choice at root since it will first explore the subtree. This makes the solver take an exponential amount of time to solve the problem.
	With random variable choice, the solver will never explore two identical subproblems the same way, and proceed in a different path than the one explored by min value.
	
- For a given value ordering, how does a dynamic variable ordering change the performance?
	Min domain size and domWdeg impact performance positively in the same way. This is because
	- Minimum domain size minimizes the search tree size, as picking the variable with the smallest domain size will make sure that the decision taken at root minimizes the subtrees generated from every variable choice.
	- domWdeg aims to maximize constraint propagation AND minimize the search tree size, as its decision is based of both minimum domain size and a weight score. Constraints and variables both have a weight. Constraints have a starting weight of 1 that increments each time a constraint fails. The weight used by the heuristic is the variable one $w(X_i)$, calculated as the sum of the weights of the constraints where $X_i$ is involved.
	- Input order has no particular strategy that helps the search, just picking the smallest value in the domain each time, which may lead to trashing. Hence why we see the worst performance out of this strategy.
	
- Are there any heuristics that behave similarly? Explain the reason.
	By the number of fails in the domWdeg and min domain heuristic we can evidently see that the values chosen by the two are the same.
	This means that in the two runs, the choice:
	$$\min(\text{size} (D(X_{i})))= min(\text{size} (D(X_{i}))/w(X_i))$$
	aka, the minimum size of the domain of the chosen variable is equal to the weighted degree of that same variable.
	This is because all weights are incremented in the same way since every variable is involved in every constraint, which makes the domWdeg heuristic behave like the min domain size heuristic.

---
Prof note
- Note however that there is no reason to believe that "the minimum size of the domain of the chosen variable is equal to the weighted degree of that same variable.". The same holds for the formula you wrote. All variables have the same weight means whether you choose them based on their domain size or domain size/weight , the ranking of the variables will be the same (i.e. the various domain size values will be divided by the same weight factor). You can think of it like a normalised value.
	- Yes, the correct formula would not use the equal sign. the formula is flawed but the idea in my head is clear, and a normalized value is a good way to put it.
	- another way i'd explain this is that the order of selection of the variables are the same in domWdeg and min domain size
	$$domWdeg(X)=minDomain(X)=X_{i}$$
- with a formula like this, where given the input X, both heuristics have as a result the same $X_i$

# Poster Placement


$[X_1,Y_1,..X_n,Y_n]$

| Order | Fails       |              |             |              |
| ----- | ----------- | ------------ | ----------- | ------------ |
|       | input order |              | domWdeg     |              |
|       | min value   | random value | min value   | random value |
| 19x19 | 1.362.457   | -            | ==236.024== | 2.929.030    |
| 20x20 | -           | -            | ==1.873==   | 5.797.456    |


decreasing by their perimeter

| Order | Fails       |              |           |              |
| ----- | ----------- | ------------ | --------- | ------------ |
|       | input order |              | domWdeg   |              |
|       | min value   | random value | min value | random value |
| 19x19 | ==62==      | -            | 245.568   | 10.530.468   |
| 20x20 | ==323==     | -            | 1.731     | 3.743.786    |


Present briefly your observations. Pay attention to the
following points.
- For a given variable ordering, how does random value choice change the performance? Explain the reason.
	Minimum value choice is better than random value in both variable ordering heuristics.
	Random value heuristics for this problem hurts performance because placing rectangles in the minimum domain value ensures that we are placing the rectangles close together with no gaps in the grid among them, while with random domain value we are placing rectangles randomly across the board, potentially leaving a lot of gaps and wasting space. Hence why minimum domain value naturally guides the search better as it places rectangles next to each other instead of leaving gaps.
	 
- Which heuristic reveals the best performance? Explain the reason.
	min value with domWdeg reveals the best performance with the $[X_1,Y_1,..X_n,Y_n]$ ordering, while Input order with min value reveals the best performance with decreasing by perimeter order.
	We can see that the results of the domWdeg - min value heuristics are very similar across the two tables, while the true difference in performance comes from input order - min value, which improves significantly once the order of the input is decreasing perimeter.
	This is because as we saw at the beginning of the course trough the number puzzle, it's sometimes smart to place the most constrained variables first. Naturally, the heuristic in this case picks the biggest rectangles in the list first - aka the most constrained, as big rectangles can lead to many fails because of the numerous ways smaller rectangles can be positioned so that the biggest rectangles won't fit.

- Which heuristic is not affected much by the order of the rectangles? Explain the reason.
	Without a doubt, the domWdeg - min value heuristic is not affected by the input order, which makes it the most consistent heuristic across our tests.
	This is because the domWdeg heuristic does make distinctions in input order, as it takes the variables ordered by their domain size and weight, as explained before:
	
	> domWdeg aims to maximize constraint propagation AND minimize the search tree size, as its decision is based of both minimum domain size and a weight score. Constraints and variables both have a weight. Constraints have a starting weight of 1 that increments each time a constraint fails. The weight used by the heuristic is the variable one $w(X_i)$, calculated as the sum of the weights of the constraints where $X_i$ is involved.
	
	Since the input order is not that relevant in this heuristic, we see that it acts about the same with different input orders.

# Quasigroup Completion Problem

| file    | Default search |           | domWdeg      |           |                                        |           |
| ------- | -------------- | --------- | ------------ | --------- | -------------------------------------- | --------- |
|         |                |           | random value |           | random value + restarting (Luby L=250) |           |
|         | Time           | Fails     | Time         | Fails     | Time                                   | Fails     |
| qc30-03 | -              | 1.490.223 | 2m 17s       | 1.495.755 | 1m 51s                                 | 1.090.634 |
| qc30-05 | 1m 24s         | 657.955   | 841msec      | 7.163     | 36s 644msec                            | 362.702   |
| qc30-08 | 274msec        | 627       | 537msec      | 4.398     | 2s 185msec                             | 11.990    |
| qc30-12 | 29s 915msec    | 259.082   | 4s 833msec   | 47.036    | 3s 928msec                             | 21.986    |
| qc30-19 | 49s 440msec    | 381.330   | -            | 2.861.592 | 8s 834msec                             | 48.244    |

Present briefly your observations. Pay attention to the following points.
- When does programming search do not improve the default search?
	The only instance where the default search is better than the programming searches are with the qc30-08 set of inputs.
	In this case, the default search strategy alligns well with the problem structure, and the complexity added by the other heuristics slow down what would be an already optimal performance with the default search.
	domWdeg -random value and Luby restarting may not provide a significant advantage because there is little to exploit in the constraint weights or domain choices, and the default heuristic might do a better job exploiting the problem structure with that particular set of inputs.
	
- When restarting the domWdeg - random value heuristic degrade the performance, what could be the reason?
	The domWdeg heuristic is effective because it focuses on heavily constrained variables. However, as restarts continually reset the variable ordering, the solver does not concentrate enough on critical variables to make meaningful progress.
	This results in the domWdeg random value without restart have better performances with the qc30-05 and qc30-08 sets of inputs, as a result of the restarting behaviour degrading performance instead of helping.
	The depth level is evidently not enough during the beginning of the search in the 05 and 08 sets, delaying the resolution.
	
- Which search approach is the best overall? Justify your answer.
	Besides with the problem qc30-08, the technique domWdeg with random value and Luby restart is never the worst heuristic among the three options. It is always able to find a solution unlike the other two heuristics, and this is due to its hybrid approach where the heuristic tends to get the best of both worlds, softening the decision burden near the root of the tree, and slowly putting more search time the longer the problem is running. The only times where this heuristic gets outperformed is in extreme cases where the default search is highly unfavorable and the domWdeg with random value is highly favorable, and viceversa.
