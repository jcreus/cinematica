module Main where

import Cinematica

mobil1 t
	| t < 10  = mru 2 5 0
	| t >= 10 = mrua 52 5 (-8) 10

mobil2 t
	| t < 5 = mrua 2 (-5) 3 0
	| (t >= 5) && (t <= 15) = mru 14.5 10 5
	| t > 15 = mrua 114.5 10 (-6) 15

main = do xtplot [mobil1, mobil2] 0 18 "out.png"
