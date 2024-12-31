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

Q2: You have written generic descriptions, instead focus on how new solutions would look like with the regular backtracking in EST with proper justification, and how different it is from the optimal (which also motivates another strategy (SetTimes) based on postponing). You can verify it even with the small example used in the slides.
