
# N-Queens

| n   | # sols | r       | rc1     | rc2     | rc3     | alldiff |
| --- | ------ | ------- | ------- | ------- | ------- | ------- |
| 8   | 92     | 853     | 449     | 493     | 844     | 284     |
| 9   | 352    | 3,900   | 1,921   | 2,005   | 3,613   | 1,115   |
| 10  | 724    | 18,657  | 9,702   | 9,969   | 16,074  | 5,043   |
| 12  | 14,200 | 459,470 | 239,556 | 235,191 | 428,376 | 108,980 |


| n   | # sols | alldiffsym |
| --- | ------ | ---------- |
| 8   | 12     | 90         |
| 9   | 46     | 264        |
| 10  | 92     | 881        |
| 12  | 1,787  | 16,510     |
1. What is happening when going r → rc1 → alldiff ? Why?
	From r to rc1, we are defining a combined model, composed of a dual view on the same problem, one from the perspective of the columns, and one from the perspective of the rows. 
	These views have the same sets of solutions, and 
	by combining them we enhance the constraint propagation thanks to the channeling constraints introduced to maintain consistency between the variables of `rows` and `cols`.
	This results in noticeably less failures compared to the `r` model.
	Going to alldiff, it is defined as a model that uses the "alldifferent" global constraint. 
	Being a global constraint, it has embed specialized propagation which exploits the substructure of the problem, inferring strongly onto the base propagation.
	In this case, alldifferent is restricting the number of times values are taken, which enhances propagation strength compared to the `r` and `rc1` models who don't take advantage of this constraint.
	

2. What is happening when going rc1 → rc2 → rc3 ? Why?
	We are removing **implied constraints**: a semantically redundant constraint for us.
	Each removed constraint is implied from `inverse(rows,cols)`-> $\forall i,j\ X_{i}=j\iff Y_{j}= i$) (C1)
	as:
	`alldifferent([X_1,..,X_n])` -> redundant as C1 already imposes all values of $X$ to be different (the constraints effectively maps indexes 1 on 1 between the 2 arrays, and if there's a repeated value inside `X_i` then `Y_j` should contain two distinct values, which is not possible)
	`alldifferent([Y_1,..,Y_n])` -> redundant as C1 imposes all values of $Y$ to be different (see above explaination)
	$\forall\ i<j\ |Y_i - Y_j| ≠ |i - j|$ -> redundant as the channeling constraint C1 imposes this same constraint implicitly trough symmetry:
	since we have $\forall\ i<j\ |X_i - X_j| ≠ |i - j|$, $Y$ has to abide by the same rule, because if the $X$ board is not able to make diagonal attacks, by inverting the board like C1 imposes, the same is true for the $Y$ board. if Diagonal attacks are not possible in any of the two boards, we can say that it is not possible in both boards.
	These constraints do not change the solution set, but they narrow the search space of the solver, thus making the failures higher when the search space is wider, which is expected.
	

3. What is happening when going alldiff → alldiffsym? Why?
	Because we're adding a symmetry breaking constraint, the given solutions for the `alldiffsym` model do not include many of the solutions found in the `alldiff` model, since all the missing solutions are all symmetric solutions of the already existing $n$ set of solutions found by the `alldiffsym` model.
	By constraining the symmetries in the solutions, we are narrowing the search space considerably, this is why we have noticeably less failures. 


PROF NOTES
- It is not clear why "combining models enhances constraint propagation thanks to the channeling constraints." I can ask this during the oral exam
	- channeling constraints make sure to link together the different parts of the solution space (row, column, diagonal constraints).
	- By channeling these variables (row, column, diagonal), we make sure that assigning values to one set of variables (e.g., rows) automatically informs or restricts the values of others (e.g., columns or diagonals), helping propagate constraints more effectively.


# Sequence

| n         | Base      |             | Base+Implied |             |
| --------- | --------- | ----------- | ------------ | ----------- |
|           | **Fails** | **Time**    | **Fails**    | **Time**    |
| **500**   | 652       | 29s 979msec | 495          | 11s 401msec |
| **1,000** | 1,362     | 2m 17s      | 995          | 49s 409msec |

1. What is happening when going base → base+implied ? Why?
	The implied constraints cut empty-solution branches earlier than the Base model, thus making the search space progressively smaller compared to the Base model, which explores the empty-solution branches deeper, costing us more fails and more time calculating a solution.
	Implied constraints are semantically redundant but are a good constraints to have to help the solver compute solutions faster, as it's able to remove all the roads that lead nowhere sooner than if the implied constraints were not there.
	