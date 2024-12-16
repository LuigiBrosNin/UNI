
| search                   | f          | # s | obj |
| ------------------------ | ---------- | --- | --- |
| def                      | 13.992.711 | 5   | 810 |
| dWd-rand                 | 15.577.386 | 20  | 732 |
| dWd-rand + restart       | 9.389.534  | 15  | 676 |
| dWd-rand + restart + lns | 2.776.751  | 19  | 654 |

Compare briefly the different search strategies going from the first to the last, paying attention to the following points:
- How slowly/quickly they explore better solutions.
	- default search
		- Relatively high failures with the least amount of solutions found, and the objective solution is the worst found among the tested strategies. The Default search in Minizinc is not optimized for this kind of research as it lacks restarts, which greatly influences the amount of solutions found and especially the number of failures. It seems that even without restarts, the dWd-rand strategy alone is an improvement over number of solutions and objective solutions.
	- dWd-rand
		- Highest failures of any tested strategies, but also the highest number of solutions. Speaking about the number of solution, the lack of a restart heuristic does not introduce a limit to how deep the search is allowed in the search tree, never giving up on potential solutions hidden deep in the search tree and found thanks to the dWd nature of strengthening propagation and minimizing the search space.
	- dWd-rand + restart
		- Considerably less failures than dWd-rand but also considerably more failures than the last experiment with LNS. The number of solutions is lower than dWd-rand as restarting cuts away solutions hidden deep into the search tree, while at the same time ensures we have better chances for an objective value closer to the optimal solution because of the broader search in the surface of the tree. As for the lower failures, the restart search is more robust as it avoid getting stuck in unproductive areas of the search, which noticeably decrease the failures during said search.
	- dWd-rand + restart + LNS
		- With the exception of number of solutions found, this is the best strategy for the low amount of failures and best objective value, as well as being close to the best in terms of number of solutions. LNS enables smaller subproblems to explore, as reducing domain sizes with fixed variables helps not only the total size of the subproblem, but also boosts propagation as it works really well with small domains.
- Does any search strategy (s1) return a better solution than another s2, while having more failures than s2? What could be the reason?
	- dWd is our s1 strategy compared to default search, which is our s2. domWdeg is a fail-first heuristic, which makes an higher amount of fails possible in comparison to the default search, while we can attribute the higher amount of solutions found to the dynamic search strategy of domWdeg that is able to guide the search better than the default search. The linearity and symmetry of the N-queens problem might also play a role with how randomization interacts with the search, leading to increased failures over the search for different solutions.
	