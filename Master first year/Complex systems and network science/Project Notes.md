deadline 04 jan 2025 (included)
email subject CSNS Project 2024
netlogo source code
PDF report

- describe the model that was implemented and justify all significant design decisions and extensions that were applied to it.
- explain the experiments that you performed in terms of methodology and the results that you obtained
- find tipping points or interesting equilibrium states in your model.

### 1. Baseline model
2d space, agents move (fishes)
- Roaming
- Fleeing
- Reproduce
(Dolphin)
- Roaming
- Hunting
- Eat

params
speed v (slightly higher in dolphins)
vision range $\gamma$   

### 2. Schooling of fish model
- Separation -> If a fish is inside a threshold distance γ near , move away from the nearest fish in the opposite direction to avoid collision.
- Cohesion / Alignment -> Move towards other fishes while maintaining alignment to them. The desired direction is the weighted contribution of the cohesion ĉ and alignment vector â. The cohesion vector ĉ is the direction toward the centroid of nearby fishes. The alignment vector â is the mean direction of nearby fishes’ current directions.
- fleeing
- roaming (current direction)

additional params
near range collision Y near
current direction s_t (last fish direction to compute next step)
max turn theta_max (optional, max turn angle for current fish direction)

### 3. Hunting strategy model

