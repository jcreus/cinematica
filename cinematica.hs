module Cinematica where

import Graphics.EasyPlot

data Moviment = Moviment Double Double Double Double

instance Show Moviment where
	show (Moviment x0 v0 a t0) = (show x0) ++" "++ (show v0) ++" "++ (show a) ++" "++ (show t0)

mrua x0 v0 a t0 = Moviment x0 v0 a t0
mru x0 v0 = mrua x0 v0 0

xt mov t = x0 + v0*temps + 1/2*a*temps^2
			where
				(Moviment x0 v0 a t0) = mov t
				temps = t-t0

vt mov t = v0 + a*temps
			where
				(Moviment x0 v0 a t0) = mov t
				temps = t-t0

desplacament :: (Double -> Moviment) -> Double -> Double -> Double
desplacament mov t1 t2 = (func t2) - (func t1)
			where
				func = xt mov

distancia mov llista = sum [
						abs ((func $ snd x :: Double) - (func $ fst x ::Double))
							| x <- llista,
							let func = xt mov
				       ]

tx mov target t1 t2 
	| a /= 0 = [ t | t <- [result1, result2], t >= t1, t <= t2]
	| otherwise = if (resultmru >= t1) && (resultmru <= t2) then [resultmru] else []

	where
		(Moviment x0 v0 a t0) = mov t1
		discriminant = (v0-t0*a)^2-2*a*(x0-target-v0*t0+(1/2)*a*t0^2)
		result1 = ((-v0+t0*a)+sqrt discriminant)/a
		result2 = ((-v0+t0*a)-sqrt discriminant)/a
		resultmru = (target-x0+v0*t0)/v0

tx0 mov = tx mov 0

tv mov target t1 t2 = 
	if result > t2 || result < t1 then -1 else result

	where 
		(Moviment x0 v0 a t0) = mov t1
		temps = t1-t0
		result = (target-v0+a*t0)/a-- target = v0+a(t-t0) target-v0+at0 / a = t
tv0 mov = tv mov 0

vm mov t1 t2 = ((func t2)-(func t1))/(t2-t1)
			where
				func = xt mov
am mov t1 t2 = ((func t2)-(func t1))/(t2-t1)
			where
				func = vt mov

vtplot moviments xi xf file = plot (PNG file) [Function2D [Title ("v/t mòbil "++show num)] [Range xi xf] $ vt mov | mov <- moviments, num <- [1..length moviments]]

xtplot moviments xi xf file = plot (PNG file) [Function2D [Title ("x/t mòbil "++show num)] [Range xi xf] $ xt mov | (num, mov) <- zip [1..length moviments] moviments]
