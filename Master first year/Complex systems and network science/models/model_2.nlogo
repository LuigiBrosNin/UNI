; fish and dolphin turtles
breed [ fishes fish ]
breed [ dolphins dolphin ]

fishes-own [ lifetime fish-reproduce current-direction]
dolphins-own [ fishes-eaten ]

globals [ max_turtles equilibrium_ticks ]

to setup
  clear-all

  ; blue background
  ask patches [ set pcolor blue ]

  set max_turtles 2000
  set equilibrium_ticks 100000 ; 100K ticks

  create-fishes initial-number-fish ; create the fishes, then initialize their variables
  [
    set shape  "fish"
    set color white
    set size 1.5  ; easier to see
    set label-color blue - 2
    set lifetime 0
    set fish-reproduce 0
    set current-direction 0
    setxy random-xcor random-ycor
  ]

  create-dolphins initial-number-dolphins  ; create the dolphines, then initialize their variables
  [
    set shape "shark"
    set color black
    set size 2  ; easier to see
    set fishes-eaten 0
    setxy random-xcor random-ycor
  ]
  display-labels
  reset-ticks
end

to go
  ; stop the model if there are no turtles or if there are too many turtles in the simulation
  if not any? turtles [ stop ]

  if not any? fishes [ user-message "The dolphins have inherited the earth" stop ]

  if count turtles > max_turtles [ user-message "Turtles limit reached" stop ]

  if ticks > equilibrium_ticks [ user-message "equilibrium potentially reached" stop ]

  ask fishes [ ; fish logic

    moveFish

    set lifetime lifetime + 1

    if fish-reproduction [
      reproduceFishes  ; fish reproduce at a random rate governed by a slider
    ]
  ]

  ask dolphins [ ; dolphin logic
    moveDolphin

    eatFish ; dolphins eat a fish on their patch
  ]

  tick
  display-labels
end

to moveFish  ; move fish procedure
  let fish-moved false

  ; Fleeing must have high priority otherwise they will never escape
  ; Fleeing: If a dolphin is nearby, move in the opposite direction of the closest dolphin
  let nearby-dolphins dolphins in-radius fish-vision-range
  if any? nearby-dolphins and not fish-moved [
    let nearest-dolphin min-one-of nearby-dolphins [distance myself]
    face nearest-dolphin
    set heading (heading + 180)  ;; Turn around (flee)
    forward speed-fish
    set fish-moved true
  ]

  ; Separation: Move away from the nearest fish if it's too close (threshold γnear)
  let nearby-fish other fishes in-radius fish-collision-range
  if any? nearby-fish and not fish-moved [
    let nearest-fish min-one-of nearby-fish [distance myself]
    face nearest-fish
    set heading (heading + 180)  ; Turn away from the nearest fish
    forward speed-fish ; Move away from the nearest fish
    set fish-moved true
  ]

  ; Cohesion and Alignment: Move towards other fish and align with their directions
  let nearby-fish-for-cohesion other fishes in-radius fish-cohesion-range  ; Adjust γcohesion for nearby fish range

  ; Calculate centroid for cohesion (weighted average of positions)
  if any? nearby-fish-for-cohesion and not fish-moved [
    let nearby-fish-for-separation other fishes in-radius fish-collision-range ; Range for collision avoidance

    let centroid-x mean [xcor] of nearby-fish-for-cohesion
    let centroid-y mean [ycor] of nearby-fish-for-cohesion
    let direction-to-centroid atan (centroid-y - ycor) (centroid-x - xcor)

    let alignment-vector mean [heading] of nearby-fish-for-cohesion ; Find mean direction of nearby fish

    ; Combine cohesion, alignment, and separation
    let desired-direction direction-to-centroid * cohesion-weight + alignment-vector * alignment-weight

    ; Calculate the angle θ to the desired direction
    let theta desired-direction - current-direction

    ; Limit the turn to θmax
    if abs theta > max-turn [
      ifelse theta > 0 [
        set theta max-turn
      ] [
        set theta (0 - max-turn)
      ]
    ]

    ; Update the current direction and move the fish
    set current-direction current-direction + theta
    set heading current-direction
    fd speed-fish ; Move the fish
    set fish-moved true

  ]


  ; Roaming: If no fish or dolphins are nearby, continue in the current direction
  if not any? nearby-fish and not any? nearby-dolphins and not fish-moved [
    forward speed-fish  ; Roam in the current direction (no need to adjust heading)
  ]
end

to moveDolphin  ; move dolphin procedure
  let closest-fish min-one-of fishes [distance myself]  ; Find the closest fish to this dolphin
  ; print distance closest-fish
  ifelse closest-fish != nobody and distance closest-fish <= dolphin-vision-range [  ; Adjust to vision range
    set color red  ; Change color to red if a fish is detected
    face closest-fish  ; Face the closest fish
    ifelse distance closest-fish < speed-dolphin [ ; fish in speed range -> no need to go at full speed
      fd distance closest-fish ; move to the fish
    ]
    [
      fd speed-dolphin  ; Move toward the fish
    ]
  ]
  [
    set color black  ; Set color back to black if no fish are detected
    rt random 180  ; Turn randomly
    lt random 180
    fd speed-dolphin  ; Move in a random direction
  ]
end

to reproduceFishes  ; fishes procedure
  set fish-reproduce (fish-reproduce + 1)
  if fish-reproduce >= fish-reproduction-rate [  ; check if it's time to make fishes reproduce
    set fish-reproduce 0
    hatch 1
    [ rt random-float 360
      fd 1
      set lifetime 0
    ]   ; hatch an offspring and move it forward 1 step
  ]
end

to eatFish  ; dolphin procedure to eat
  let prey one-of fishes-here                    ; grab a random fish
  if prey != nobody  [                          ; did we get one? if so,
    ask prey [ die ]                            ; kill it
    set fishes-eaten fishes-eaten + 1
  ]
end

to display-labels
  ask turtles [ set label "" ]
end
@#$#@#$#@
GRAPHICS-WINDOW
360
10
1038
689
-1
-1
13.14
1
14
1
1
1
0
1
1
1
-25
25
-25
25
1
1
1
ticks
30.0

SLIDER
0
10
202
43
initial-number-fish
initial-number-fish
1
250
185.0
1
1
NIL
HORIZONTAL

SLIDER
0
190
185
223
fish-reproduction-rate
fish-reproduction-rate
0
1000
300.0
10
1
NIL
HORIZONTAL

SLIDER
0
45
217
78
initial-number-dolphins
initial-number-dolphins
1
250
10.0
1
1
NIL
HORIZONTAL

SLIDER
0
100
110
133
speed-fish
speed-fish
1
5
1.0
0.5
1
NIL
HORIZONTAL

BUTTON
280
10
349
43
setup
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
275
50
350
83
go
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
0

PLOT
5
520
355
690
populations
time
pop.
0.0
100.0
0.0
100.0
true
true
"" ""
PENS
"fishes" 1.0 0 -612749 true "" "plot count fishes"

MONITOR
300
555
350
600
fishes
count fishes
3
1
11

SLIDER
110
100
245
133
speed-dolphin
speed-dolphin
1
10
1.1
0.1
1
NIL
HORIZONTAL

SWITCH
0
225
177
258
fish-reproduction
fish-reproduction
0
1
-1000

SLIDER
0
135
135
168
fish-vision-range
fish-vision-range
1
25
3.0
1
1
NIL
HORIZONTAL

SLIDER
135
135
300
168
dolphin-vision-range
dolphin-vision-range
1
25
3.0
1
1
NIL
HORIZONTAL

SLIDER
0
260
187
293
fish-collision-range
fish-collision-range
0
2
1.0
0.1
1
NIL
HORIZONTAL

SLIDER
185
260
345
293
fish-cohesion-range
fish-cohesion-range
1
10
10.0
1
1
NIL
HORIZONTAL

SLIDER
185
290
345
323
max-turn
max-turn
10
180
90.0
10
1
NIL
HORIZONTAL

SLIDER
0
290
185
323
cohesion-weight
cohesion-weight
0
1
0.3
0.1
1
NIL
HORIZONTAL

SLIDER
0
320
185
353
alignment-weight
alignment-weight
0
1
0.3
0.1
1
NIL
HORIZONTAL

MONITOR
5
430
97
475
max lifetime
max [lifetime] of fishes
17
1
11

MONITOR
5
475
92
520
avg lifetime
mean [lifetime] of fishes
17
1
11

MONITOR
90
475
212
520
avg fishes eaten
mean [fishes-eaten] of dolphins
17
1
11

@#$#@#$#@
# Introduction
An implementation of three agent-based models for a prey and predator system aimed at studying the impacts of the chosen parameters in the simulation such as vision range, speed, population, reproduction rate and communication range. The three models implement a basic environment, a self-organizing schooling system for fishes and a hunting communication network for dolphins. The results show how each affect the simulation, and in particular how survival is dictated by prevention instead of fleeing, or how communication makes hunting more consistent, but does not make predators better overall at hunting.

# Loading the models into NetLogo
The models are written in [NetLogo 6.4](https://ccl.northwestern.edu/netlogo/download.shtml), which is required to run the models.
In NetLogo, go to `File > Open` (or `Ctrl + O`) and Browse the files to open the desired model. 

# Running the experiments
Once the model is loaded, navigate `Tools > BehaviorSpace` (or `Ctrl + Shift + B`) to run the desired experiment.

# Author

Luizo :)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

shark
false
0
Polygon -7500403 true true 283 153 288 149 271 146 301 145 300 138 247 119 190 107 104 117 54 133 39 134 10 99 9 112 19 142 9 175 10 185 40 158 69 154 64 164 80 161 86 156 132 160 209 164
Polygon -7500403 true true 199 161 152 166 137 164 169 154
Polygon -7500403 true true 188 108 172 83 160 74 156 76 159 97 153 112
Circle -16777216 true false 256 129 12
Line -16777216 false 222 134 222 150
Line -16777216 false 217 134 217 150
Line -16777216 false 212 134 212 150
Polygon -7500403 true true 78 125 62 118 63 130
Polygon -7500403 true true 121 157 105 161 101 156 106 152

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.4.0
@#$#@#$#@
set model-version "sheep-wolves-grass"
set show-energy? false
setup
repeat 75 [ go ]
@#$#@#$#@
@#$#@#$#@
<experiments>
  <experiment name="1-fish-population" repetitions="5" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <metric>sum [ fishes-eaten ] of dolphins / ticks</metric>
    <metric>sum [ fishes-eaten ] of dolphins</metric>
    <metric>mean [fishes-eaten] of dolphins</metric>
    <metric>count fishes</metric>
    <runMetricsCondition>(count fishes) = 0 or (count fishes + count dolphins) &gt;= max_turtles or ticks &gt;= equilibrium_ticks</runMetricsCondition>
    <enumeratedValueSet variable="fish-reproduction">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="speed-dolphin">
      <value value="1.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="dolphin-vision-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-vision-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-reproduction-rate">
      <value value="150"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="speed-fish">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-number-dolphins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-collision-range">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-cohesion-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cohesion-weight">
      <value value="0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alignment-weight">
      <value value="0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="max-turn">
      <value value="20"/>
    </enumeratedValueSet>
    <subExperiment>
      <enumeratedValueSet variable="initial-number-fish">
        <value value="50"/>
        <value value="100"/>
        <value value="200"/>
      </enumeratedValueSet>
    </subExperiment>
  </experiment>
  <experiment name="2-dolphin-population" repetitions="5" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <metric>sum [ fishes-eaten ] of dolphins / ticks</metric>
    <metric>sum [ fishes-eaten ] of dolphins</metric>
    <metric>mean [fishes-eaten] of dolphins</metric>
    <metric>count fishes</metric>
    <runMetricsCondition>(count fishes) = 0 or (count fishes + count dolphins) &gt;= max_turtles or ticks &gt;= equilibrium_ticks</runMetricsCondition>
    <enumeratedValueSet variable="fish-reproduction">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="speed-dolphin">
      <value value="1.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="dolphin-vision-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-vision-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-reproduction-rate">
      <value value="150"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="speed-fish">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-number-fish">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-collision-range">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-cohesion-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cohesion-weight">
      <value value="0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alignment-weight">
      <value value="0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="max-turn">
      <value value="20"/>
    </enumeratedValueSet>
    <subExperiment>
      <enumeratedValueSet variable="initial-number-dolphins">
        <value value="5"/>
        <value value="10"/>
        <value value="20"/>
      </enumeratedValueSet>
    </subExperiment>
  </experiment>
  <experiment name="1-fish-population-reproduction" repetitions="5" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <metric>sum [ fishes-eaten ] of dolphins / ticks</metric>
    <metric>sum [ fishes-eaten ] of dolphins</metric>
    <metric>mean [fishes-eaten] of dolphins</metric>
    <metric>count fishes</metric>
    <runMetricsCondition>(count fishes) = 0 or (count fishes + count dolphins) &gt;= max_turtles or ticks &gt;= equilibrium_ticks</runMetricsCondition>
    <enumeratedValueSet variable="fish-reproduction">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="speed-dolphin">
      <value value="1.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="dolphin-vision-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-vision-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-reproduction-rate">
      <value value="150"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="speed-fish">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-number-dolphins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-collision-range">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-cohesion-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cohesion-weight">
      <value value="0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alignment-weight">
      <value value="0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="max-turn">
      <value value="20"/>
    </enumeratedValueSet>
    <subExperiment>
      <enumeratedValueSet variable="initial-number-fish">
        <value value="50"/>
        <value value="100"/>
        <value value="200"/>
      </enumeratedValueSet>
    </subExperiment>
  </experiment>
  <experiment name="2-dolphin-population-reproduction" repetitions="5" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <metric>sum [ fishes-eaten ] of dolphins / ticks</metric>
    <metric>sum [ fishes-eaten ] of dolphins</metric>
    <metric>mean [fishes-eaten] of dolphins</metric>
    <metric>count fishes</metric>
    <runMetricsCondition>(count fishes) = 0 or (count fishes + count dolphins) &gt;= max_turtles or ticks &gt;= equilibrium_ticks</runMetricsCondition>
    <enumeratedValueSet variable="fish-reproduction">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="speed-dolphin">
      <value value="1.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="dolphin-vision-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-vision-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-reproduction-rate">
      <value value="150"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="speed-fish">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-number-fish">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-collision-range">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-cohesion-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cohesion-weight">
      <value value="0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alignment-weight">
      <value value="0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="max-turn">
      <value value="20"/>
    </enumeratedValueSet>
    <subExperiment>
      <enumeratedValueSet variable="initial-number-dolphins">
        <value value="5"/>
        <value value="10"/>
        <value value="20"/>
      </enumeratedValueSet>
    </subExperiment>
  </experiment>
  <experiment name="3-fish-speed" repetitions="5" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <metric>sum [ fishes-eaten ] of dolphins / ticks</metric>
    <metric>sum [ fishes-eaten ] of dolphins</metric>
    <metric>mean [fishes-eaten] of dolphins</metric>
    <metric>count fishes</metric>
    <runMetricsCondition>(count fishes) = 0 or (count fishes + count dolphins) &gt;= max_turtles or ticks &gt;= equilibrium_ticks</runMetricsCondition>
    <enumeratedValueSet variable="fish-reproduction">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="speed-dolphin">
      <value value="1.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="dolphin-vision-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-vision-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-reproduction-rate">
      <value value="150"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="speed-fish">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-number-dolphins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-number-fish">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-collision-range">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-cohesion-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cohesion-weight">
      <value value="0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alignment-weight">
      <value value="0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="max-turn">
      <value value="20"/>
    </enumeratedValueSet>
    <subExperiment>
      <enumeratedValueSet variable="speed-fish">
        <value value="1"/>
        <value value="1.2"/>
        <value value="1.5"/>
        <value value="1.7"/>
        <value value="2"/>
      </enumeratedValueSet>
    </subExperiment>
  </experiment>
  <experiment name="4-dolphin-speed" repetitions="5" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <metric>sum [ fishes-eaten ] of dolphins / ticks</metric>
    <metric>sum [ fishes-eaten ] of dolphins</metric>
    <metric>mean [fishes-eaten] of dolphins</metric>
    <metric>count fishes</metric>
    <runMetricsCondition>(count fishes) = 0 or (count fishes + count dolphins) &gt;= max_turtles or ticks &gt;= equilibrium_ticks</runMetricsCondition>
    <enumeratedValueSet variable="fish-reproduction">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="dolphin-vision-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-vision-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-reproduction-rate">
      <value value="150"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="speed-fish">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-number-dolphins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-number-fish">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-collision-range">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-cohesion-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cohesion-weight">
      <value value="0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alignment-weight">
      <value value="0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="max-turn">
      <value value="20"/>
    </enumeratedValueSet>
    <subExperiment>
      <enumeratedValueSet variable="speed-dolphin">
        <value value="1"/>
        <value value="1.2"/>
        <value value="1.5"/>
        <value value="1.7"/>
        <value value="2"/>
      </enumeratedValueSet>
    </subExperiment>
  </experiment>
  <experiment name="3-fish-speed-reproduction" repetitions="5" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <metric>sum [ fishes-eaten ] of dolphins / ticks</metric>
    <metric>sum [ fishes-eaten ] of dolphins</metric>
    <metric>mean [fishes-eaten] of dolphins</metric>
    <metric>count fishes</metric>
    <runMetricsCondition>(count fishes) = 0 or (count fishes + count dolphins) &gt;= max_turtles or ticks &gt;= equilibrium_ticks</runMetricsCondition>
    <enumeratedValueSet variable="fish-reproduction">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="speed-dolphin">
      <value value="1.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="dolphin-vision-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-vision-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-reproduction-rate">
      <value value="150"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-number-dolphins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-number-fish">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-collision-range">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-cohesion-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cohesion-weight">
      <value value="0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alignment-weight">
      <value value="0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="max-turn">
      <value value="20"/>
    </enumeratedValueSet>
    <subExperiment>
      <enumeratedValueSet variable="speed-fish">
        <value value="1"/>
        <value value="1.2"/>
        <value value="1.5"/>
        <value value="1.7"/>
        <value value="2"/>
      </enumeratedValueSet>
    </subExperiment>
  </experiment>
  <experiment name="4-dolphin-speed-reproduction" repetitions="5" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <metric>sum [ fishes-eaten ] of dolphins / ticks</metric>
    <metric>sum [ fishes-eaten ] of dolphins</metric>
    <metric>mean [fishes-eaten] of dolphins</metric>
    <metric>count fishes</metric>
    <runMetricsCondition>(count fishes) = 0 or (count fishes + count dolphins) &gt;= max_turtles or ticks &gt;= equilibrium_ticks</runMetricsCondition>
    <enumeratedValueSet variable="fish-reproduction">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="dolphin-vision-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-vision-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-reproduction-rate">
      <value value="150"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="speed-fish">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-number-dolphins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-number-fish">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-collision-range">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-cohesion-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cohesion-weight">
      <value value="0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alignment-weight">
      <value value="0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="max-turn">
      <value value="20"/>
    </enumeratedValueSet>
    <subExperiment>
      <enumeratedValueSet variable="speed-dolphin">
        <value value="1"/>
        <value value="1.2"/>
        <value value="1.5"/>
        <value value="1.7"/>
        <value value="2"/>
      </enumeratedValueSet>
    </subExperiment>
  </experiment>
  <experiment name="5-fish-vision" repetitions="5" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <metric>sum [ fishes-eaten ] of dolphins / ticks</metric>
    <metric>sum [ fishes-eaten ] of dolphins</metric>
    <metric>mean [fishes-eaten] of dolphins</metric>
    <metric>count fishes</metric>
    <runMetricsCondition>(count fishes) = 0 or (count fishes + count dolphins) &gt;= max_turtles or ticks &gt;= equilibrium_ticks</runMetricsCondition>
    <enumeratedValueSet variable="fish-reproduction">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="speed-dolphin">
      <value value="1.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="dolphin-vision-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-reproduction-rate">
      <value value="150"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="speed-fish">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-number-dolphins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-number-fish">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-collision-range">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-cohesion-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cohesion-weight">
      <value value="0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alignment-weight">
      <value value="0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="max-turn">
      <value value="20"/>
    </enumeratedValueSet>
    <subExperiment>
      <enumeratedValueSet variable="fish-vision-range">
        <value value="1"/>
        <value value="3"/>
        <value value="5"/>
        <value value="10"/>
      </enumeratedValueSet>
    </subExperiment>
  </experiment>
  <experiment name="6-dolphin-vision" repetitions="5" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <metric>sum [ fishes-eaten ] of dolphins / ticks</metric>
    <metric>sum [ fishes-eaten ] of dolphins</metric>
    <metric>mean [fishes-eaten] of dolphins</metric>
    <metric>count fishes</metric>
    <runMetricsCondition>(count fishes) = 0 or (count fishes + count dolphins) &gt;= max_turtles or ticks &gt;= equilibrium_ticks</runMetricsCondition>
    <enumeratedValueSet variable="fish-reproduction">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="speed-dolphin">
      <value value="1.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-reproduction-rate">
      <value value="150"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="speed-fish">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-number-dolphins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-number-fish">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-collision-range">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-cohesion-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cohesion-weight">
      <value value="0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alignment-weight">
      <value value="0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="max-turn">
      <value value="20"/>
    </enumeratedValueSet>
    <subExperiment>
      <enumeratedValueSet variable="dolphin-vision-range">
        <value value="1"/>
        <value value="3"/>
        <value value="5"/>
        <value value="10"/>
      </enumeratedValueSet>
    </subExperiment>
  </experiment>
  <experiment name="5-fish-vision-reproduction" repetitions="5" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <metric>sum [ fishes-eaten ] of dolphins / ticks</metric>
    <metric>sum [ fishes-eaten ] of dolphins</metric>
    <metric>mean [fishes-eaten] of dolphins</metric>
    <metric>count fishes</metric>
    <runMetricsCondition>(count fishes) = 0 or (count fishes + count dolphins) &gt;= max_turtles or ticks &gt;= equilibrium_ticks</runMetricsCondition>
    <enumeratedValueSet variable="fish-reproduction">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="speed-dolphin">
      <value value="1.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="dolphin-vision-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-reproduction-rate">
      <value value="150"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="speed-fish">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-number-dolphins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-number-fish">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-collision-range">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-cohesion-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cohesion-weight">
      <value value="0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alignment-weight">
      <value value="0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="max-turn">
      <value value="20"/>
    </enumeratedValueSet>
    <subExperiment>
      <enumeratedValueSet variable="fish-vision-range">
        <value value="1"/>
        <value value="3"/>
        <value value="5"/>
        <value value="10"/>
      </enumeratedValueSet>
    </subExperiment>
  </experiment>
  <experiment name="6-dolphin-vision-reproduction" repetitions="5" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <metric>sum [ fishes-eaten ] of dolphins / ticks</metric>
    <metric>sum [ fishes-eaten ] of dolphins</metric>
    <metric>mean [fishes-eaten] of dolphins</metric>
    <metric>count fishes</metric>
    <runMetricsCondition>(count fishes) = 0 or (count fishes + count dolphins) &gt;= max_turtles or ticks &gt;= equilibrium_ticks</runMetricsCondition>
    <enumeratedValueSet variable="fish-reproduction">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="speed-dolphin">
      <value value="1.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-reproduction-rate">
      <value value="150"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="speed-fish">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-number-dolphins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-number-fish">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-collision-range">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-cohesion-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cohesion-weight">
      <value value="0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alignment-weight">
      <value value="0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="max-turn">
      <value value="20"/>
    </enumeratedValueSet>
    <subExperiment>
      <enumeratedValueSet variable="dolphin-vision-range">
        <value value="1"/>
        <value value="3"/>
        <value value="5"/>
        <value value="10"/>
      </enumeratedValueSet>
    </subExperiment>
  </experiment>
  <experiment name="7-fish-reproduction" repetitions="5" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <metric>sum [ fishes-eaten ] of dolphins / ticks</metric>
    <metric>sum [ fishes-eaten ] of dolphins</metric>
    <metric>mean [fishes-eaten] of dolphins</metric>
    <metric>count fishes</metric>
    <runMetricsCondition>(count fishes) = 0 or (count fishes + count dolphins) &gt;= max_turtles or ticks &gt;= equilibrium_ticks</runMetricsCondition>
    <enumeratedValueSet variable="fish-reproduction">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="speed-dolphin">
      <value value="1.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="dolphin-vision-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-vision-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="speed-fish">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-number-dolphins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-number-fish">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-collision-range">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-cohesion-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cohesion-weight">
      <value value="0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alignment-weight">
      <value value="0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="max-turn">
      <value value="20"/>
    </enumeratedValueSet>
    <subExperiment>
      <enumeratedValueSet variable="fish-reproduction-rate">
        <value value="25"/>
        <value value="50"/>
        <value value="100"/>
        <value value="150"/>
        <value value="300"/>
      </enumeratedValueSet>
    </subExperiment>
  </experiment>
  <experiment name="8-fish-collision-range" repetitions="5" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <metric>sum [ fishes-eaten ] of dolphins / ticks</metric>
    <metric>sum [ fishes-eaten ] of dolphins</metric>
    <metric>mean [fishes-eaten] of dolphins</metric>
    <metric>count fishes</metric>
    <runMetricsCondition>(count fishes) = 0 or (count fishes + count dolphins) &gt;= max_turtles or ticks &gt;= equilibrium_ticks</runMetricsCondition>
    <enumeratedValueSet variable="fish-reproduction">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-reproduction-rate">
      <value value="150"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="speed-dolphin">
      <value value="1.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="dolphin-vision-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-vision-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="speed-fish">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-number-dolphins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-number-fish">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-cohesion-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cohesion-weight">
      <value value="0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alignment-weight">
      <value value="0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="max-turn">
      <value value="20"/>
    </enumeratedValueSet>
    <subExperiment>
      <enumeratedValueSet variable="fish-collision-range">
        <value value="1"/>
        <value value="1.2"/>
        <value value="1.5"/>
        <value value="2"/>
      </enumeratedValueSet>
    </subExperiment>
  </experiment>
  <experiment name="8-fish-collision-range-reproduction" repetitions="5" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <metric>sum [ fishes-eaten ] of dolphins / ticks</metric>
    <metric>sum [ fishes-eaten ] of dolphins</metric>
    <metric>mean [fishes-eaten] of dolphins</metric>
    <metric>count fishes</metric>
    <runMetricsCondition>(count fishes) = 0 or (count fishes + count dolphins) &gt;= max_turtles or ticks &gt;= equilibrium_ticks</runMetricsCondition>
    <enumeratedValueSet variable="fish-reproduction">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-reproduction-rate">
      <value value="150"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="speed-dolphin">
      <value value="1.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="dolphin-vision-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-vision-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="speed-fish">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-number-dolphins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-number-fish">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-cohesion-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cohesion-weight">
      <value value="0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alignment-weight">
      <value value="0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="max-turn">
      <value value="20"/>
    </enumeratedValueSet>
    <subExperiment>
      <enumeratedValueSet variable="fish-collision-range">
        <value value="1"/>
        <value value="1.2"/>
        <value value="1.5"/>
        <value value="2"/>
      </enumeratedValueSet>
    </subExperiment>
  </experiment>
  <experiment name="9-fish-cohesion-range" repetitions="5" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <metric>sum [ fishes-eaten ] of dolphins / ticks</metric>
    <metric>sum [ fishes-eaten ] of dolphins</metric>
    <metric>mean [fishes-eaten] of dolphins</metric>
    <metric>count fishes</metric>
    <runMetricsCondition>(count fishes) = 0 or (count fishes + count dolphins) &gt;= max_turtles or ticks &gt;= equilibrium_ticks</runMetricsCondition>
    <enumeratedValueSet variable="fish-reproduction">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-reproduction-rate">
      <value value="150"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="speed-dolphin">
      <value value="1.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="dolphin-vision-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-vision-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="speed-fish">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-number-dolphins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-number-fish">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-collision-range">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cohesion-weight">
      <value value="0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alignment-weight">
      <value value="0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="max-turn">
      <value value="20"/>
    </enumeratedValueSet>
    <subExperiment>
      <enumeratedValueSet variable="fish-cohesion-range">
        <value value="1"/>
        <value value="3"/>
        <value value="5"/>
        <value value="10"/>
      </enumeratedValueSet>
    </subExperiment>
  </experiment>
  <experiment name="1X-fish-generic" repetitions="5" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <metric>sum [ fishes-eaten ] of dolphins / ticks</metric>
    <metric>sum [ fishes-eaten ] of dolphins</metric>
    <metric>mean [fishes-eaten] of dolphins</metric>
    <metric>count fishes</metric>
    <runMetricsCondition>(count fishes) = 0 or (count fishes + count dolphins) &gt;= max_turtles or ticks &gt;= equilibrium_ticks</runMetricsCondition>
    <enumeratedValueSet variable="fish-reproduction">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-reproduction-rate">
      <value value="150"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="speed-dolphin">
      <value value="1.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="dolphin-vision-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-vision-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="speed-fish">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-number-dolphins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-number-fish">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-collision-range">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-cohesion-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cohesion-weight">
      <value value="0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alignment-weight">
      <value value="0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="max-turn">
      <value value="20"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="9-fish-cohesion-range-reproduction" repetitions="5" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <metric>sum [ fishes-eaten ] of dolphins / ticks</metric>
    <metric>sum [ fishes-eaten ] of dolphins</metric>
    <metric>mean [fishes-eaten] of dolphins</metric>
    <metric>count fishes</metric>
    <runMetricsCondition>(count fishes) = 0 or (count fishes + count dolphins) &gt;= max_turtles or ticks &gt;= equilibrium_ticks</runMetricsCondition>
    <enumeratedValueSet variable="fish-reproduction">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-reproduction-rate">
      <value value="150"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="speed-dolphin">
      <value value="1.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="dolphin-vision-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-vision-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="speed-fish">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-number-dolphins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-number-fish">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-collision-range">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cohesion-weight">
      <value value="0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alignment-weight">
      <value value="0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="max-turn">
      <value value="20"/>
    </enumeratedValueSet>
    <subExperiment>
      <enumeratedValueSet variable="fish-cohesion-range">
        <value value="1"/>
        <value value="3"/>
        <value value="5"/>
        <value value="10"/>
      </enumeratedValueSet>
    </subExperiment>
  </experiment>
  <experiment name="10-fish-weights" repetitions="5" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <metric>sum [ fishes-eaten ] of dolphins / ticks</metric>
    <metric>sum [ fishes-eaten ] of dolphins</metric>
    <metric>mean [fishes-eaten] of dolphins</metric>
    <metric>count fishes</metric>
    <runMetricsCondition>(count fishes) = 0 or (count fishes + count dolphins) &gt;= max_turtles or ticks &gt;= equilibrium_ticks</runMetricsCondition>
    <enumeratedValueSet variable="fish-reproduction">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-reproduction-rate">
      <value value="150"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="speed-dolphin">
      <value value="1.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="dolphin-vision-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-vision-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="speed-fish">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-number-dolphins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-number-fish">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-collision-range">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-cohesion-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="max-turn">
      <value value="20"/>
    </enumeratedValueSet>
    <subExperiment>
      <enumeratedValueSet variable="cohesion-weight">
        <value value="0.1"/>
        <value value="0.3"/>
        <value value="0.5"/>
        <value value="0.7"/>
        <value value="1"/>
      </enumeratedValueSet>
      <enumeratedValueSet variable="alignment-weight">
        <value value="0.1"/>
        <value value="0.3"/>
        <value value="0.5"/>
        <value value="0.7"/>
        <value value="1"/>
      </enumeratedValueSet>
    </subExperiment>
  </experiment>
  <experiment name="10-fish-weights-reproduction" repetitions="5" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <metric>sum [ fishes-eaten ] of dolphins / ticks</metric>
    <metric>sum [ fishes-eaten ] of dolphins</metric>
    <metric>mean [fishes-eaten] of dolphins</metric>
    <metric>count fishes</metric>
    <runMetricsCondition>(count fishes) = 0 or (count fishes + count dolphins) &gt;= max_turtles or ticks &gt;= equilibrium_ticks</runMetricsCondition>
    <enumeratedValueSet variable="fish-reproduction">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-reproduction-rate">
      <value value="150"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="speed-dolphin">
      <value value="1.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="dolphin-vision-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-vision-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="speed-fish">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-number-dolphins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-number-fish">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-collision-range">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-cohesion-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="max-turn">
      <value value="20"/>
    </enumeratedValueSet>
    <subExperiment>
      <enumeratedValueSet variable="cohesion-weight">
        <value value="0.1"/>
        <value value="0.3"/>
        <value value="0.5"/>
        <value value="0.7"/>
        <value value="1"/>
      </enumeratedValueSet>
      <enumeratedValueSet variable="alignment-weight">
        <value value="0.1"/>
        <value value="0.3"/>
        <value value="0.5"/>
        <value value="0.7"/>
        <value value="1"/>
      </enumeratedValueSet>
    </subExperiment>
  </experiment>
  <experiment name="11-fish-max-turn" repetitions="5" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <metric>sum [ fishes-eaten ] of dolphins / ticks</metric>
    <metric>sum [ fishes-eaten ] of dolphins</metric>
    <metric>mean [fishes-eaten] of dolphins</metric>
    <metric>count fishes</metric>
    <runMetricsCondition>(count fishes) = 0 or (count fishes + count dolphins) &gt;= max_turtles or ticks &gt;= equilibrium_ticks</runMetricsCondition>
    <enumeratedValueSet variable="fish-reproduction">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-reproduction-rate">
      <value value="150"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="speed-dolphin">
      <value value="1.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="dolphin-vision-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-vision-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="speed-fish">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-number-dolphins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-number-fish">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-collision-range">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-cohesion-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cohesion-weight">
      <value value="0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alignment-weight">
      <value value="0.3"/>
    </enumeratedValueSet>
    <subExperiment>
      <enumeratedValueSet variable="max-turn">
        <value value="1"/>
        <value value="20"/>
        <value value="50"/>
        <value value="90"/>
        <value value="120"/>
        <value value="180"/>
      </enumeratedValueSet>
    </subExperiment>
  </experiment>
  <experiment name="11-fish-max-turn-reproduction" repetitions="5" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <metric>sum [ fishes-eaten ] of dolphins / ticks</metric>
    <metric>sum [ fishes-eaten ] of dolphins</metric>
    <metric>mean [fishes-eaten] of dolphins</metric>
    <metric>count fishes</metric>
    <runMetricsCondition>(count fishes) = 0 or (count fishes + count dolphins) &gt;= max_turtles or ticks &gt;= equilibrium_ticks</runMetricsCondition>
    <enumeratedValueSet variable="fish-reproduction">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-reproduction-rate">
      <value value="150"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="speed-dolphin">
      <value value="1.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="dolphin-vision-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-vision-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="speed-fish">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-number-dolphins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-number-fish">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-collision-range">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-cohesion-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cohesion-weight">
      <value value="0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alignment-weight">
      <value value="0.3"/>
    </enumeratedValueSet>
    <subExperiment>
      <enumeratedValueSet variable="max-turn">
        <value value="1"/>
        <value value="20"/>
        <value value="50"/>
        <value value="90"/>
        <value value="120"/>
        <value value="180"/>
      </enumeratedValueSet>
    </subExperiment>
  </experiment>
  <experiment name="13-dolphin-communication-0-range" repetitions="50" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <metric>sum [ fishes-eaten ] of dolphins / ticks</metric>
    <metric>sum [ fishes-eaten ] of dolphins</metric>
    <metric>mean [fishes-eaten] of dolphins</metric>
    <metric>count fishes</metric>
    <runMetricsCondition>(count fishes) = 0 or (count fishes + count dolphins) &gt;= max_turtles or ticks &gt;= equilibrium_ticks</runMetricsCondition>
    <enumeratedValueSet variable="fish-reproduction">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-reproduction-rate">
      <value value="150"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="speed-dolphin">
      <value value="1.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="dolphin-vision-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-vision-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="speed-fish">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-number-dolphins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-number-fish">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-collision-range">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="fish-cohesion-range">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cohesion-weight">
      <value value="0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alignment-weight">
      <value value="0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="max-turn">
      <value value="20"/>
    </enumeratedValueSet>
  </experiment>
</experiments>
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
1
@#$#@#$#@
