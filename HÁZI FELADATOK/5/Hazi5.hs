module Hazi5 where

--1. Feladat

mountain :: Integral i => i -> String
mountain 0 = ""
mountain n = mountain (n-1) ++ replicate (fromIntegral n) '#' ++ "\n"

--2. Feladat

countAChars :: Num i => String -> i
countAChars [] = 0
countAChars ('a':xs) = 1 + countAChars xs
countAChars (_:xs) = countAChars xs

--3. Feladat

lucas :: (Integral a, Num b) => a -> b
lucas 0 = 2
lucas 1 = 1
lucas n = lucas (n-1) + lucas (n-2)

--4. Feladat

longerThan :: Integral i => [a] -> i -> Bool
longerThan [] n = n < 0
longerThan (_:xs) n = n < 0 || longerThan xs (n - 1)

--5. Feladat

format :: Integral i => i -> String -> String
format 0 ys = ys
format m [] = ' ' : format (m-1) []
format m (y:ys) = y : format (m-1) ys

--6. Feladat

merge :: [a] -> [a] -> [a]
merge [] ys = ys
merge xs [] = xs
merge (x:xs) (y:ys) = x : y : merge xs ys