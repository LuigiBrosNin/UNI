99/100

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
		- Highest failures of any tested strategies, but also the highest number of solutions. Speaking about the number of solutions, the lack of a restart heuristic does not introduce a limit to how deep the search is allowed in the search tree, never giving up on potential solutions hidden deep in the search tree and found thanks to the dWd nature of strengthening propagation and minimizing the search space. Failures in dWd-rand guide the search, so it's also thanks to the higher amount of fails that we're able to find more and better solutions.
	- dWd-rand + restart
		- Considerably less failures than dWd-rand but also considerably more failures than the last experiment with LNS. The number of solutions is lower than dWd-rand as restarting cuts away solutions hidden deep into the search tree, while at the same time ensures we have better chances for an objective value closer to the optimal solution because of the broader search in the surface of the tree. As for the lower failures, the restart search is more robust as it avoid getting stuck in unproductive areas of the search, which noticeably decrease the failures during said search.
	- dWd-rand + restart + LNS
		- With the exception of number of solutions found, this is the best strategy for the low amount of failures and best objective value, as well as being close to the best in terms of number of solutions. LNS enables smaller subproblems to explore, as reducing domain sizes with fixed variables helps not only the total size of the subproblem, but also boosts propagation as it works really well with small domains. The noticeable improvement in solution quality is also thanks to the introduction of LNS. In particular, by searching into the neighborhood of a found solution we're able to quickly locate another better solution with few tries by relaxing the found solution. We're able to explore the neighbourhood efficiently because of CP, and this leads to the quickness we experience in the resulting statistics.
- Does any search strategy (s1) return a better solution than another s2, while having more failures than s2? What could be the reason?
	- dWd is our s1 strategy compared to default search, which is our s2. The lack of restart in dWd-rand makes the dynamic search spend more time on deeper branches, causing a higher number of failures because of no declared limits on depth exploration. We can attribute the higher amount of solutions found to the dynamic search strategy of domWdeg that is able to guide the search better than the default search thanks to the fails as it's what guides the heuristic. The linearity and symmetry of the N-queens problem might also play a role with how randomization interacts with the search, leading to increased failures over the search for different solutions.
	  Another important note about the higher failures is how dWd-rand fails more towards the beginning of the search, sharpening the search as time goes on and ultimately finding more solutions than the default search strategy thanks to the guided heuristic.


dWd-rand  

- "Failures in dWd-rand guide the search" --> what does this mean? You are saying sth similar also under Q2  
	- The dWd heuristic is based on weighted constraints: each time a constraint fails during propagation its weight increments (starting from 1). the variable that gets chosen subsequently by the heuristic is $X_i$ with $\min \frac{ dom(X_{i})}{w(X_{i})}$ (where $w(X_{i}) = \sum\limits_{c|X_{i}\in X(c)}w(c)$). This means that before any propagation, the search is guided by the minimum domain size, but as the solver propagates, the constraints that cause failure get weighted and thus guide the search towards the "heaviest" variables as a result, aka the ones that fail more (fail-first principle). This is what i meant by "failures in dWd-rand guide the search"

- "so it's also thanks to the higher amount of fails that we're able to find more and better solutions." -> the reason of this connection is missing
	- see above explaination; dWd guides the search trough fails.

Overall I couldn't see the answer of Q2, neither in dWd-rand or under Q2. You are writing some guesses but the answer is indeed in the interpretation of the table values. **Within a time limit**, s1 has more fails than s2,  giving also more solutions than s2, resulting in a better solution quality. What does this indicate?
- The fact that dWd-rand finds more solutions despite the higher failure count indicates that it is more explorative in the search space. It is testing more configurations thanks to the weighted heuristic and randomness, even though some of them lead to failures. the default search may also experience more heavy tail behaviour than dWd-rand, which also explains the higher amount of solutions.
  
