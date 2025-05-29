module Hazi2 where

--1. Feladat

addV :: (Double,Double) -> (Double,Double) -> (Double,Double)
addV (a , b) (c , d) = (a + c , b + d)
subV :: (Double,Double) -> (Double,Double) -> (Double,Double)
subV (a , b) (c , d) = (a - c , b - d)

--2. Feladat

scaleV :: Double -> (Double,Double) -> (Double,Double)
--scaleV n pair = (n * fst pair, n * snd pair)
scaleV n (a , b) = (n * a, n * b)

--3. Feladat

scalar :: (Double,Double) -> (Double,Double) -> Double
--scalar x y = fst x * fst y + snd x * snd y
scalar (a , b) (c , d) = a * c + b * d

--4. Feladat

divides :: Integer -> Integer -> Bool
divides 0 0 = True
divides 0 _ = False
divides x y = mod y x == 0

--5. Feladat

add :: Integer -> Int -> Integer
add x y = fromIntegral x + fromIntegral y
