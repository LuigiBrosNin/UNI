99/100
# RCPSP

| Default search | Objective value | Time       |
| -------------- | --------------- | ---------- |
| rcpspData1     | 90              | 360msec    |
| rcpspData2     | 53              | 1s 53msec  |
| rcpspData3     | 82              | 5s 567msec |

| EST        | Objective value | Time        | Time initial solution |
| ---------- | --------------- | ----------- | --------------------- |
| rcpspData1 | 90              | 362msec     | 343msec               |
| rcpspData2 | 54              | 45s 901msec | 361msec               |
| rcpspData3 | 75              | 2s 506msec  | 362msec               |


# JSP

| Default search | Objective value | Time    |
| -------------- | --------------- | ------- |
| jobshop1       | 666             | 370msec |
| jobshop2       | 924             | -       |

| EST      | Objective value | Time | Time initial solution |
| -------- | --------------- | ---- | --------------------- |
| jobshop1 | 669             | -    | 969msec               |
| jobshop2 | 984             | -    | 540msec               |


1. Is searching on EST a good strategy to find an initial solution?
	The initial solutions of the EST methods are good approximations of the optimal solutions and they get compute very early in the search (in the msec range for all our tests). The initial solutions found are close enough to what the optimal solution is in the RCPSP exercise, while in the JSP exercise the initial solutions are way more far off the optimal solution found by the default search, which depending on the situation, might not be a good enough solution.
	EST appears to be a consistent strategy time-wise, where it could be considered a good strategy for a initial solution if the context of the problem admits initial solutions that may be relatively far from optimal.
	
2. Is searching on EST a good strategy to find an optimal solution? Justify your answer
	EST didn't manage to find solutions that matched the results found by the default search outside of rcpspData1, where it found the same solution with slightly more time.
	In any of our experiments, EST timed out or took considerably longer times to achieve a solution that was somewhat close but never better than what the default search was able to find, so it doesn't appear that EST can be considered a good strategy to find optimal solutions compared to the default search.
	EST is designed to easily find feasible solutions by focusing on scheduling jobs as early as possible, which may not always lead to the global optimal makespan due to the complexity of task-machine interactions or due to the resource constraints in the exercises we conducted.
	It is not an ideal strategy for finding the **optimal solution** due to its tendency to prioritize early task start times without considering the broader problem structure.


PROF NOTES
Your observations are nicely justified but you still have problems in your JSP model (which affects the optimal results). You should pay more attention when writing code (you have had many errors so far). 

- Can you explain why you still have this in your model? `constraint makespan = max([s[j,M] + duration[j,machine[j,M]] | j in JOB])`. 
- Your disjunctive constraint is still posted wrongly. Find out the error and explain how you can fix it.

MAKESPAN
```minizinc
% Makespan as dummy task at the end of each job  
constraint forall(j in JOB)(s[j, M] + duration[j, machine[j, M]] <= makespan);
```

This is how we now implement the dummy task constraint.  
The issue i personally had with coding this constraint is the disjunction i created in my head between the dummy task concept and the makespan. I can understand it looking at the execution, but i cannot understand the execution trough the dummy task concept. I always thought the dummy task had to be something tangible in the form of a variable, instead of just makespan representing it, it's something weird my head never turned around to figure it out until recently...

DISJUNCTIVE
```
% Disjunctive: tasks on the same machine must not overlap  
constraint forall(m in MACH)(  
disjunctive([s[j,t] | j in JOB, t in TASK where machine[j,t] = m],  
[duration[j,m] | j in JOB])  
);  
```
  
The issue in the disjunctive constraint is that we were iterating trough the duration matrix with tasks instead of just using the machine index, leading to the constraint not checking properly for overlaps.