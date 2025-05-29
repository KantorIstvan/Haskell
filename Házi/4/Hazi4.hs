module Hazi4 where

--1. Feladat

password :: [Char] -> [Char]
password [] = []
password xs = [ '*' | _ <- xs]

--2. Feladat

filterIncPairs :: Ord a => [(a,a)] -> [(a,a)]
filterIncPairs [] = []
filterIncPairs xs = [ (a,b) | (a,b) <- xs, a < b]

--3. Feladat

startsWithUpper :: [String] -> [String]
startsWithUpper [""] = []
startsWithUpper xs = [ x | x@(c:_) <- xs, c `elem` ['A'..'Z'] ]

--4. Feladat

onlySingletons :: [[a]] -> [[a]]
onlySingletons [] = []
onlySingletons xs = [ x | x@[_] <- xs]