cinematica
==========

Just a small project to learn Haskell (and solve my homework...).

No guarantee that it is working correctly. Right now only in one dimension, although I'm working on adding 2+ dimensions (not committing yet, the idea is that it should be sync'd with what we're working on at class so it can solve my homework).

Example
-------

```haskell
module Main where

import Cinematica

mobil1 t
    | t < 10  = mru 2 5 0
    | t >= 10 = mrua 52 5 (-8) 10

mobil2 t
    | t < 5 = mrua 2 (-5) 3 0
    | (t >= 5) && (t <= 15) = mru 14.5 10 5
    | t > 15 = mrua 114.5 10 (-6) 15

xt1 = xt mobil1

main = do
        xtplot [mobil1, mobil2] 0 18 "out.png"
        print $ xt1 12
        print $ tx mobil1 2 0 20
```

Defining a movement
-------------------
A movement can be defined with the functions mru and mrua, the former being a shortcut for mrua (with a=0)
* mrua x0 v0 a t0
* mru x0 v0 t0
It uses Haskell's guard pattern, and must take time as an argument:

```haskell
movement t
    | t < 5 = mrua 2 (-5) 3 0
    | (t >= 5) && (t <= 15) = mru 14.5 10 5
    | t > 15 = mrua 114.5 10 (-6) 15
```

Functions
---------
* xt time: position as a function of time.
* vt time: speed as a function of time.
* tx movement target min_time max_time: time as a function of position.
* tx0 movement min_time max_time: time when position = 0.
* tv movement target min_time max_time: time as a function of speed.
* tv0 movement min_time max_time: time when speed = 0.
* desplacament movement initial_time final_time: displacement.
* distancia movement list of (initial_time, final_time): sum of distances in given times.
* vm movement initial_time final_time: average speed.
* am movement initial_time final_time: average acceleration.
* vtplot list_of_movements initial_time final_time out_file: plot a v/t graph.
* xtplot list_of_movements initial_time final_time out_file: plot a x/t graph.
