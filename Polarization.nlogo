;; README
;; Lorenzo Molfetta
;; mart. 1037519
;; lorenzo.molfetta@studio.unibo.it

;; Source code in ./src
__includes["src/main.nls"]


;; DIRECTORY OF SOURCE FILES
; src:
;   |_ net_config: <contains the different models configuration files>
;   |_ objectives-plots: <define the measures watched during the simulation and the plot implementations>
;   |_ utils: <include probabilistic util functions used for drawing samples according to the given policies>
@#$#@#$#@
GRAPHICS-WINDOW
836
36
1226
427
-1
-1
11.6
1
10
1
1
1
0
1
1
1
-16
16
-16
16
0
0
1
ticks
30.0

INPUTBOX
697
105
809
165
N
50.0
1
0
Number

SWITCH
298
84
541
117
layout?
layout?
0
1
-1000

SWITCH
22
84
273
117
plot?
plot?
0
1
-1000

CHOOSER
631
382
821
427
net_type
net_type
"Contagion-Static" "Contagion-Dynamic" "User-Roles"
2

BUTTON
562
106
681
165
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
562
39
681
99
NIL
go
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
0

BUTTON
697
39
809
98
NIL
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

SLIDER
21
180
274
213
average_number_of_connections
average_number_of_connections
0
max_number_of_connections
4.0
1
1
NIL
HORIZONTAL

PLOT
21
444
623
604
Support to Party
t
NIL
0.0
10.0
0.0
0.2
true
true
"" ""
PENS
"dems" 1.0 0 -13791810 true "" "if (plot?)[\n let n_dems count turtles with [party = 0]\n plot n_dems\n]"
"reps" 1.0 0 -2674135 true "" "if plot? [\n let n_reps count turtles with [party = 2]\n plot n_reps\n]"
"wav" 1.0 0 -7500403 true "" "if (plot?) [\n let n_wav count turtles with [party = 1]\n plot n_wav\n]"

SLIDER
567
181
820
214
link_resistance
link_resistance
0
1
0.27
0.01
1
NIL
HORIZONTAL

PLOT
632
444
1228
603
Network Stats
t
NIL
0.0
10.0
-1.0
3.0
true
true
"" ""
PENS
"disagreement" 1.0 0 -955883 true "" "if (plot?)[\nplot get_disagreement\n;print(\"N\")\n]"
"polarization" 1.0 0 -5825686 true "" "if (plot?)[plot opinion_polarization]"
"polarization index" 1.0 0 -13791810 true "" "if (plot?)[plot polarization_index]"

CHOOSER
631
279
821
324
connection_making_strategy
connection_making_strategy
"random" "same party" "different party"
2

CHOOSER
631
331
821
376
connection_drop_strategy
connection_drop_strategy
"random" "popularity-based" "un-popularity-based"
0

SLIDER
22
132
273
165
virus-check-frequency
virus-check-frequency
0
50
31.0
1
1
NIL
HORIZONTAL

SLIDER
567
228
820
261
max_number_of_connections
max_number_of_connections
0
N - 1
7.0
1
1
NIL
HORIZONTAL

SLIDER
21
228
274
261
elite_percentage
elite_percentage
0
1
0.15
0.01
1
NIL
HORIZONTAL

TEXTBOX
183
43
426
89
OPINION POLARIZATION
19
0.0
1

SWITCH
298
132
542
165
cross_following?
cross_following?
1
1
-1000

SLIDER
297
228
541
261
elite_polarization
elite_polarization
0
1
0.55
0.01
1
NIL
HORIZONTAL

PLOT
22
278
622
428
Gravity Center Distribution
NIL
NIL
-10.1
10.1
0.0
10.0
true
true
";setup_hist_gc" ""
PENS
"dems" 1.0 1 -13791810 true "" "if (plot?)[\n ;clear-plot\n let dems turtles with [party = 0]\n ;cumulative_distr_gc dems blue\n cumulative_distr_gc_hist dems blue\n]"
"reps" 1.0 1 -2674135 true "" "if (plot?)[\n ;clear-plot\n let reps turtles with [party = 2]\n ;cumulative_distr_gc reps red\n cumulative_distr_gc_hist reps red\n]"

SLIDER
297
181
541
214
wavering_weight
wavering_weight
0
1
0.4
0.01
1
NIL
HORIZONTAL

@#$#@#$#@
# "Why Your Friends Have More Friends than You Do"

Lorenzo Molfetta
matr. 1037519
email: lorenzo.molfetta@studio.unibo.it


## Models

The user can select different network models which differently handle the popularity-directed preferential attachment policy for the considered problem. All three proposed approaches analyze the given problem from different perspectives. 

Specifically, each model tries to verify the outcome of a biased friend-making strategy
by starting from different situations. The available network types are the followings:

* **Barabasi-Albert**: build the network using a preferential attachment policy, then simulates the interactions between individuals according to the user-specified linking settings described in the "_Linking Strategies_" section. It is indeed possible to make the singular individuals choose the less or more popular node to drop or make new friends with. This approach tests the veracity of the average friend statistics resulting from a preferential attachment strategy whose (un)correlation may raise an inadequacy feeling in most individuals;

* **Social-Infection**: starting from a healthy network, that is a configuration thought of to reduce the "inadequacy feeling" of individuals by properly balancing the _AVG_ff_ parameter, this model includes a virus propagation in addition to the usual random tweaks to the topology of the network. Such a social virus encodes a sort of accountability measure for individuals which negatively biases the probability of making new relationships with those resulting infected. This method enriches the complexity of the analysis by providing the user with additional parameters that can be tuned to change the speed and scope of the infection, for instance, to include in the comparison the effects of bad publicity in social network-based relationships;

* **Game-Theory**: starting from a network built using the Barabasi-Albert approach, this version tries to investigate how inadequacy feeling can shape the way individuals choose their friendships. This configuration includes the presence of cooperative and non-cooperative individuals, the former being willing to make friendships with less popular individuals, as opposed to the latter. The goal of this analysis is to investigate how being prone to build relationships with unknown nodes affects the final popularity.


## Linking Strategies
The user can select different policies for the drop or the creation of relationships between individuals. In addition to a general "random" behaviour that unbiasedly weights the drawing of samples when deciding which links to drop and which nodes to use as the destination for new ones, the application provides more specific behaviours:

* _friend\_making\_strategy_ shape the distribution of individuals to draw
for a new connection:
	* "_absolute popularity_": link with the current most popular node in the network;
	* "_relative popularity_": weight more the individuals with more connections, i.e. the most popular.
* _friend\_drop\_strategy_ set the priority with which the links to drop are selected:
	* "_un-popularity-based_": drop links with unknown individuals;
	* "_popularity-based_": deletes the connections from nodes with high popularity.

The last option can be used when we wish to encode the scenarios wherein having more relationships affect their strengths. In such contexts, it is fair to assume that a person with more friends cares less about them individually.

## Social Environments
To better capture the variability of relationship types, the user can select
whether to include in the model a categorization of friendships. In so doing, the simulation is provided with the capability of handling more or less resistant types
of links between nodes which may resist differently to the network evolution.

It is indeed usual to characterize the ties with respect to the context they take place in. Even if a friendship drop is likely to occur, a relationship between individuals going to the same school or working in the same office is more resistant than one on social networks - just for a mere reason of proximity. These three mentioned cases are exactly the types of relationships this feature is shaped on. Inside the simulation, they can be distinguished by the thickness and the colour of links in the network. Such a further characterization is included to endow the model with the possibility to encode specific case studies requiring different weighting strategies for relationships and a specific clusterization of nodes.


For the sake of our specific purpose, their tuning is not important and therefore not let for the user to set. However, for more specific uses you can modify their specifics in the source file "utils/turtle_struct".

## Network Evolution
Once the population has reached the given number of individuals, the model evolution is ruled by a drop-rewiring procedure on random links. The choice of the relationships to modify is based on the current nodes' popularity. It is indeed conceivable to eliminate the relationships of one of the most popular individuals, as we assume that the more friends you have the less they are important and resistant, while a new link is added between unknown and popular individuals. The latter according to the phenomenon for which individuals tend to choose friends that are more popular than they are, in an attempt to lift their social status.


According to the used network configuration, the user can set the following hyperparameters:

* plot?: plot the statistics from the analysis;
* layout?: enhance the plot by spreading the nodes to avoid overlaps;
* Social-Infection:
	* virus-check-frequency: set the maximum time after which the infection status of a node is checked and eventually modified;
* Game-Theory:
	* initial-cooperation: percentage of cooperative nodes at the beginning of the simulation;
	* inadequacy-weight: influence the fitness score of individuals accordingly accounting more for their inadequacy feeling, i.e., the difference between the number of their friends and the number of friends their own friends have.

The rest of them are self-explainable and won't be listed here.
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
NetLogo 6.3.0
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
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
0
@#$#@#$#@
